//
//  UserModel.h
//  SHSGH
//
//  Created by lihongliang on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCopying,NSCoding>

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *userID;

@property(nonatomic,strong)NSString *phoneNum;

@property(nonatomic,strong)NSString *LabourUnion;

@property(nonatomic,strong)NSString *email;

@property(nonatomic,strong)NSString *userIDName;

@property(nonatomic,strong)NSString *token;

@end
