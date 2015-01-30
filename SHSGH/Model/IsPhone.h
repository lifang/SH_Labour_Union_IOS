//
//  IsPhone.h
//  SHSGH
//
//  Created by lihongliang on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsPhone : NSObject
//手机
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//邮箱
+ (BOOL)validateEmail:(NSString *)email;
@end
