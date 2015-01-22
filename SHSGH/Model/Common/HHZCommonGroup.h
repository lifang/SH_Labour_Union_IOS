//
//  HHZCommonGroup.h
//  微博
//
//  Created by Mr.h on 14/12/12.
//  Copyright (c) 2014年 gem. All rights reserved.
//
//  用一个HHZCommonGroup模型来描述每组的信息：组头，组尾，这组的所有行模型
#import <Foundation/Foundation.h>

@interface HHZCommonGroup : NSObject
/** 组头 */
@property(nonatomic,copy) NSString *header;
/** 组尾 */
@property(nonatomic,copy) NSString *footer;
/** 这行的所有行模型（数组中存放的都是HHZCommonItem模型） */
@property(nonatomic,strong) NSArray *items;

+(instancetype)group;
@end
