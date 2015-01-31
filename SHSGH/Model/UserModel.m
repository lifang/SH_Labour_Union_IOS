//
//  UserModel.m
//  SHSGH
//
//  Created by lihongliang on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_userID forKey:@"userID"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:_LabourUnion forKey:@"LabourUnion"];
    [aCoder encodeObject:_userIDName forKey:@"userIDName"];
    [aCoder encodeObject:_token forKey:@"token"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _username = [aDecoder decodeObjectForKey:@"username"];
        _password = [aDecoder decodeObjectForKey:@"password"];
        _userID = [aDecoder decodeObjectForKey:@"userID"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
        _LabourUnion = [aDecoder decodeObjectForKey:@"LabourUnion"];
        _userIDName = [aDecoder decodeObjectForKey:@"userIDName"];
        _token = [aDecoder decodeObjectForKey:@"token"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UserModel *user = [[self class] allocWithZone:zone];
    user.username = [_username copyWithZone:zone];
    user.password = [_password copyWithZone:zone];
    user.userID = [_userID copyWithZone:zone];
    user.email = [_email copyWithZone:zone];
    user.phoneNum = [_phoneNum copyWithZone:zone];
    user.LabourUnion = [_LabourUnion copyWithZone:zone];
    user.userIDName = [_userIDName copyWithZone:zone];
    user.token = [_token copyWithZone:zone];
    return user;
}

@end
