//
//  KRHttpUtil.m
//  TongXueLu
//
//  Created by wes on 12-11-8.
//  Copyright (c) 2012年 wes. All rights reserved.
//

#import "KRHttpUtil.h"
#import "KRConstants.h"
#import "JSONKit.h"
#define DES_KEY @"RaiChina"
#import <CommonCrypto/CommonCryptor.h>
#import <commoncrypto/CommonDigest.h>
#import "RPBase64.h"
#import "Reachability.h"
@implementation KRHttpUtil

//自动添加applyid 以及token
+ (NSString *) createPostString:(id)params
{
    NSString *str = [[NSString alloc]initWithData:[params JSONData] encoding:NSUTF8StringEncoding];
    NSString *toPost = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    toPost = [toPost stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    toPost = [toPost stringByReplacingOccurrencesOfString:@"=" withString:@"%5Cu003d"];
    toPost = [toPost stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    toPost = [toPost stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    toPost = [toPost stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    
    NSString *postStr = [NSString stringWithFormat:@"param=%@",toPost];
    
    //token:A100000136F5569,applyId:1
    return postStr;
}

+ (NSString *) createPostStringWithOutParam:(id)params
{
    NSString *str = [[NSString alloc]initWithData:[params JSONData] encoding:NSUTF8StringEncoding];
//    NSString *toPost = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *postStr = [NSString stringWithFormat:@"%@",str];
    
    //token:A100000136F5569,applyId:1
    return postStr;
}

+ (id) getResultDataByPostSubUrl:(NSString *)subUrl{
    NSString *integratedUrl = [BASEURL_PUBLIC stringByAppendingString:[NSString stringWithFormat:@"?action=%@",subUrl]];
    NSError *error;
    NSURLResponse *response;
    NSLog(@"integratedUrl===========>%@",integratedUrl);
    NSURL *remoteUrl = [NSURL URLWithString:integratedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id result = [res objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if (![data length] == 0){
        NSLog(@"res:%@",res);
    }else{
        // NSLog(@"there is no data");
    }
    return result;
}


+ (id) getResultDataByGetSubUrl:(NSString *)subUrl{
    NSString *integratedUrl = [BASEURL_PUBLIC stringByAppendingString:[NSString stringWithFormat:@"?action=%@",subUrl]];
    NSError *error;
    NSURLResponse *response;
    NSLog(@"integratedUrl===========>%@",integratedUrl);
    NSURL *remoteUrl = [NSURL URLWithString:integratedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"GET"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id result = [res objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if (![data length] == 0){
        NSLog(@"res:%@",res);
    }else{
       // NSLog(@"there is no data");
    }
    return result;
}

+ (id) getResultDataByPost:(NSString *)url param:(NSMutableDictionary *)params mingwen:(NSString *)str
{
    NSString *postString = [self createPostString:params];
    NSLog(@"%@" , postString);
    NSData* postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSURLResponse *response;
    NSString *strUrl = [BASEURL_PUBLIC stringByAppendingString:url];
    NSURL *remoteUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [request setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  // NSLog(@"DATA=============================> %@" , data);
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isConnected"] && ![data length] == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:res forKey:[url stringByAppendingString:str]];
    }
    id result = [self toJson:res];
    if (![data length] == 0)
    {
        NSLog(@"res:%@",res);
    }
    else
    {
        NSLog(@"there is no data!!!");
    }
    return result;
}


+ (id) getResultDataByPostInSecrect:(NSString *)url param:(NSMutableDictionary *)parameters
{

    NSString *postString = [self createPostStringWithOutParam:parameters];
    NSString *deskey = DES_KEY;
    NSString *truePost = [postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    truePost = [truePost stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    truePost = [truePost stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *res = [defaults objectForKey:[url stringByAppendingString:[self createPostString:parameters]]];
//===================================================================================================================> 缓存加入
    if ([self checkString:res]){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
            NSString * content_DES = [self encryptUseDES: truePost key:deskey];
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:content_DES forKey:@"content"];
            NSString *mingwen = [self createPostString:parameters];
            [self getResultDataByPost:url param:params mingwen:mingwen];
        });
        id result = [self toJson:[defaults objectForKey:[url stringByAppendingString:[self createPostString:parameters]]]];
        return result;
    }
    else
    {
        NSString * content_DES = [self encryptUseDES: truePost key:deskey];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:content_DES forKey:@"content"];
        NSString *mingwen = [self createPostString:parameters];
        id result = [KRHttpUtil getResultDataByPost:url param:params mingwen:mingwen];
        return result;
    }
    
//======================================================================================================================> 结束
}



+ (id) getResultDataByGetString:(NSMutableArray *)nameArray andValueArray:(NSMutableArray *)valueArray andActionStr:(NSString *)actionStr
{
    NSMutableString *getStr = [[NSMutableString alloc]init];
    if (nameArray == nil || valueArray == nil) {
        [getStr appendFormat:@"%@" ,actionStr];

    }
    else
    {
        [getStr appendFormat:@"%@" ,actionStr];
        for (int i = 0; i < [nameArray count]; i ++) {
            [getStr appendFormat:@"&%@=%@" , [nameArray objectAtIndex:i],[valueArray objectAtIndex:i]];
        }
    }

    
    NSError *error;
    NSURLResponse *response;
    NSString *strUrl = [BASEURL_PUBLIC stringByAppendingString:getStr];
    NSLog(@"strUrl ------------------> %@" , strUrl);
    NSURL *remoteUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"DATA=============================> %@" , data);
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"res=============================> %@" , res);

    id result = [self toJson:res];
    if (![data length] == 0)
    {
        //    NSLog(@"res:%@",res);
    }
    else
    {
        NSLog(@"there is no data!!!");
    }
    return result;
}

//+ (id) getResultDataByPostImage:(NSString *)url param:(NSMutableDictionary *)params image:(UIImage *)image
//{
//    NSString *stringParam = [self createPostString:params];
////    NSString *stringParam = [[NSString alloc]initWithData:[params JSONData] encoding:NSUTF8StringEncoding];
//    NSString *krBoundary = @"Aakjkuokll0975dmmn";
//    
//    // fenjiexian
//    NSString *MPBoundary = [NSString stringWithFormat:@"--%@\r\n",krBoundary];
//    NSString *endMPBoundary = [NSString stringWithFormat:@"\r\n--%@--\r\n",krBoundary];
//    
//    //pic data
//    NSData *imageData = UIImagePNGRepresentation(image);
//    
//    //post String data
//    NSMutableString *body = [[NSMutableString alloc]init];
//    [body appendFormat:@"%@\r\n",MPBoundary];
//    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",@"param",stringParam];
// 
//    //post image data
//    [body appendFormat:@"%@\r\n",MPBoundary];
//    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"pic.png\"\r\n"];
//    [body appendFormat:@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n"];
//    
//    NSMutableData *requestData = [NSMutableData data];
//    [requestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    [requestData appendData:imageData];
//    [requestData appendData:[endMPBoundary dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error;
//    NSURLResponse *response;
//    NSString *strUrl = [BASEURL_PUBLIC stringByAppendingString:url];
//    NSURL *remoteUrl = [NSURL URLWithString:strUrl];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:requestData];
////    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",krBoundary] forHTTPHeaderField:@"Content-Type"];
//    
// //   NSString *strData = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
//
// //   NSLog(@"strData:%@",[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    id result = [self toJson:res];
//    if (![data length] == 0)
//    {
//      //  NSLog(@"res:%@",res);
//    }
//    else
//    {
//        NSLog(@"there is no data!!!");
//    }
//    return result;
//}

+ (void)post
{
    NSString *postString = @"param={\"id\":34,\"token\":\"A100000136F5569\",\"applyId\":\"1\"}";
//    NSString *postString = [NSString stringWithFormat:@"{\"userName\":\"%@\",\"userPass\":\"%@\",\"version\":\"1.0\"}",@"123",@"123"];

    //一般转化称UTF-8，这里服务器需要ASCII
    NSData* postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:BASEURL_PUBLIC]];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    // 应该是application/x-www-form-urlencoded，但对方服务器写成了appliction/x-www-form-urlencoded，告诉服务器是一个表单提交数据方式
    [request setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    //得到提交数据的长度
    NSString* len = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    //添加一个http包头告诉服务器数据长度是多少
    [request setValue:len forHTTPHeaderField:@"Content-Length"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (![data length] == 0)
    {
       // NSLog(@"res:%@",res);
    }
    else
    {
        NSLog(@"there is no data!!!");
    }
    
}

+ (id) toJson:(NSString *)source
{
    NSString *s1 = [source stringByReplacingOccurrencesOfString:@"{PAGE}" withString:@""];
    NSString *s2 = [s1 stringByReplacingOccurrencesOfString:@"{/PAGE}" withString:@""];
    [s2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    id data = [s2 objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    return data;
}



+(BOOL)checkString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]] || string == nil || [string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

+(BOOL)checkNumber:(NSNumber *)number
{
    if ((NSNull *)number == [NSNull null] || number == nil) {
        return NO;
    }
    return YES;
}
+ (id) getResultDataByGet:(NSString *)url{
    
    NSString *cacheKey = url;
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if ([reachability currentReachabilityStatus] != NotReachable)
    {
        
        
        NSError *error;
        NSURLResponse *response;
        NSString *strUrl = [BASEURL_PUBLICs stringByAppendingString:url];
        NSURL *remoteUrl = [NSURL URLWithString:strUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
        [request setHTTPMethod:@"GET"];
        
        [request setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [[NSUserDefaults standardUserDefaults] setObject:res forKey:cacheKey];
        id result = [self toJson:res];
        if (![data length] == 0)
        {
            //  NSLog(@"res:%@",res);
        }
        else
        {
            // NSLog(@"there is no data!!!");
        }
        return result;
        
    }
    else
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:cacheKey])
        {
            NSString *res = [[NSUserDefaults standardUserDefaults] objectForKey:cacheKey];
            id result = [self toJson:res];
            return result;
            
        }
        else
        {
            return nil;
        }
    }
}

+ (id) getResultDataByPost:(NSString *)url param:(NSMutableDictionary *)params
{
    NSString *postString = [self createPostString:params];
    
    NSData* postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSURLResponse *response;
    NSString *strUrl = [BASEURL_PUBLIC stringByAppendingString:url];
    //   NSLog(strUrl);
    NSURL *remoteUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [request setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id result = [self toJson:res];
    if (![data length] == 0)
    {
        NSLog(@"res:%@",res);
    }
    else
    {
        NSLog(@"there is no data!!!");
    }
    return result;
}


+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [RPBase64 decodeString:cipherText];
    unsigned char buffer[16384];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          16384,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


+ (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[16384];
    NSLog(@"%lu",(unsigned long)data.length);
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          16384,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [RPBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}

+ (id) getCloudAlbumUrl:(NSString *)urlStr{
    NSError *error;
    NSURLResponse *response;
    NSLog(@"integratedUrl===========>%@",urlStr);
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    NSLog(@"%@" , encodedString);
    NSURL *remoteUrl =[NSURL URLWithString:encodedString];
    //    NSURL *remoteUrl = [NSURL URLWithString:integratedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    [request setHTTPMethod:@"GET"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id result = [res objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if (![data length] == 0){
        NSLog(@"res:%@",res);
    }else{
        // NSLog(@"there is no data");
    }
    return result;
}


@end
