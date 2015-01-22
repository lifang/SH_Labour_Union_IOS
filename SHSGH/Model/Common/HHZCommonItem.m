//
//  HHZCommonItem.m
//  微博
//
//  Created by Mr.h on 14/12/12.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import "HHZCommonItem.h"

@implementation HHZCommonItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    HHZCommonItem *item = [[self alloc]init];
    item.title = title;
    item.icon = icon;
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

@end
