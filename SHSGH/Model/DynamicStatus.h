//
//  DynamicStatus.h
//  SHSGH
//
//  Created by lihongliang on 15/1/28.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicStatus : NSObject

@property(nonatomic,assign)int ids;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *time;

- (id)initWithStatusDictionary:(NSDictionary *)dict;

@end
