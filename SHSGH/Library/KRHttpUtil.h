//
//  KRHttpUtil.h
//  TongXueLu
//
//  Created by wes on 12-11-8.
//  Copyright (c) 2012年 wes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRHttpUtil : NSObject

//+ (NSString *) createPostURL:(NSMutableDictionary *)params;
+ (id) getResultDataByGet:(NSString *)url;
+ (id) getResultDataByPost:(NSString *)url param:(NSMutableDictionary *)params;
//+ (id) getResultDataByPost_openHour:(NSString *)url param:(NSMutableDictionary *)params;
//+ (id) getResultDataByPostImage:(NSString *)url param:(NSMutableDictionary *)params image:(UIImage *)image;
+ (void) post;
//+ (id) toJson;
+ (BOOL)checkString:(NSString *)string;
+(BOOL)checkNumber:(NSNumber *)number;
+ (id) getCloudAlbumUrl:(NSString *)urlStr;
+ (id) getResultDataByPostInSecrect:(NSString *)url param:(NSMutableDictionary *)parameters;
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
@end
