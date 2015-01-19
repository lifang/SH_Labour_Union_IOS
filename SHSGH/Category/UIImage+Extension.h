//
//  UIImage+Extension.h
//  微博
//
//  Created by Mr.h on 14-11-25.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//根据图片名自动加载IOS6,7
//+(UIImage *)imageWithName:(NSString *)name;
//根据图片名来拉伸图片
+(UIImage *)resizedImage:(NSString *)name;
@end
