//
//  UserTool.m
//  SHSGH
//
//  Created by lihongliang on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#define HHZAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"user.data"]

#import "UserTool.h"
#import "UserModel.h"

@implementation UserTool

+(void)save:(UserModel *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:HHZAccountFilepath];
}

+(UserModel *)userModel
{
    UserModel *accont = [NSKeyedUnarchiver unarchiveObjectWithFile:HHZAccountFilepath];
    
    return accont;
}

@end
