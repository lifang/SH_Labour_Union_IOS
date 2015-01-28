//
//  DynamicStatus.m
//  SHSGH
//
//  Created by lihongliang on 15/1/28.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DynamicStatus.h"

@implementation DynamicStatus

-(id)initWithStatusDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        _title = [NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
        _time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
        _ids = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    }
    return self;
}

@end
