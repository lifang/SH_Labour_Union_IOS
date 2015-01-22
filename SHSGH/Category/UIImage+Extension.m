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

+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
