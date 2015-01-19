//
//  UIImage+Extension.m
//  微博
//
//  Created by Mr.h on 14-11-25.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
#pragma mark IOS7图片适配的方法
//+(UIImage *)imageWithName:(NSString *)name{
//    UIImage *image = nil;
//    if (IOS7) {
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        image = [UIImage imageNamed:newName];
//    }
//    if (image == nil) {
//        image = [UIImage imageNamed:name];
//    }
//    
//    return image;
//}

+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
