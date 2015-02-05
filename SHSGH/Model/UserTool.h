//
//  UserTool.h
//  SHSGH
//
//  Created by lihongliang on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface UserTool : NSObject
//存储帐号信息
+(void)save:(UserModel *)account;
//读取帐号
+(UserModel *)userModel;

@end
