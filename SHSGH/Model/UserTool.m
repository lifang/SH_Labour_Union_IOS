//
//  UserTool.m
//  SHSGH
//
//  Created by lihongliang on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#define HHZAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"userInfo"]

#import "UserTool.h"
#import "UserModel.h"

@implementation UserTool

//+(void)save:(UserModel *)account
//{
////    BOOL s;
////     s = [NSKeyedArchiver archiveRootObject:account toFile:HHZAccountFilepath];
////    SLog(@"归档结果------------------%d",s);
//}
//
//+(UserModel *)userModel
//{
//    UserModel *accont = [NSKeyedUnarchiver unarchiveObjectWithFile:HHZAccountFilepath];
//    
//    return accont;
//}

+ (NSString *)lastestUserPath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentPath stringByAppendingPathComponent:kLastestPath];
}

+ (void)save:(UserModel *)account {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:account forKey:kLastestFile];
        [archiver finishEncoding];
        [data writeToFile:[[self class] lastestUserPath] atomically:YES];
    });
}

+ (UserModel *)userModel {
    NSString *userPath = [[self class] lastestUserPath];
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:userPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    return [unarchiver decodeObjectForKey:kLastestFile];
}


@end
