//
//  HHZCommonItem.h
//  微博
//
//  Created by Mr.h on 14/12/12.
//  Copyright (c) 2014年 gem. All rights reserved.
//
// 再用一个HHZCommonItem模型来描述每行的信息：图标，标题，子标题，右边的样式（箭头，打钩，开关，文字，数字等）

#import <Foundation/Foundation.h>

@interface HHZCommonItem : NSObject
/** 图标 */
@property(nonatomic,copy) NSString *icon;
/** 标题 */
@property(nonatomic,copy) NSString *title;
/** 子标题 */
@property(nonatomic,copy) NSString *subtitle;
/** 右边显示的数字标记 */
@property(nonatomic,copy) NSString *badgeValue;
/** 点击这行cell，需要调转到哪个控制器 */
@property(nonatomic,assign) Class destVcClass;
/** 点击这行cell，想做的事情 */
//block只能用copy
@property(nonatomic,copy) void (^operation)();

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title;
@end
