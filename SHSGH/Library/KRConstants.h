//
//  KRConstants.h
//  TongXueLu
//
//  Created by wes on 12-11-9.
//  Copyright (c) 2012年 wes. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ImageLoader.h"
#import "KRHttpUtil.h"
#define BUG_REPORT_ENABLE 1
#define EXCEPTION_SAVE          @"exception/save"


@interface KRConstants : NSObject
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define BASEURL_PUBLIC            @"http://192.168.0.250:7070/shanghaiunion"
// #define BASEURL_PUBLIC            @"http://180.166.148.170:8080"

//#define BASEURL_PUBLIC            @"http://192.168.1.116:8080/hotelclient"


#define BASEURL_PUBLICs @ "http://data.i-xiangce.com:8088/clientServer/mobile/"
#define CLOUD_ALBUM_DOWNLOAD_URL  @"http://admin.i-xitie.com:8088/cloudalbum/website/checkvision/"
//#define BASEURL_PUBLIC           @"http://58.211.5.34:8080/clientServer/mobile/"
//#define BASEURL_PUBLIC          @"http://192.168.1.116:8080/clientServer/mobile/"
//#define BASEURL_PUBLIC           @"http://app.i-xiangben.com:8088/clientServer/mobile/"
#define BASEURL_PUBLIC2           @"http://58.211.5.34:8080/studioms/mobile/"
//#define BASEURL_PUBLIC3           @"http://192.168.1.116:8080/cloudalbum/website/"
#define BASEURL_PUBLIC3           @"http://i-request.i-xiangce.com/website/"
#define ALBUM_UPLOAD            @"album/upload"
#define ADVICE_SAVE             @"advice/save"
#define IMGBASEURL_PUBLIC3           @"http://115.29.238.222/ccx/staticmedia/images/"
#define ALBUM_START             @"albums/start"
#define APP_ID                  @"32454"
#define COSTOM_ID               @"32454"
#define SITE_ID                 @"1"
#define APP_NAME                @"真爱新婚会馆"
#define ALBUMS_APP              @"albums/app"

#define IMAGE_START             @"albums/image"
#define LOAD_ABOUTLIST          @"albums/aboutlist"
#define ALBUM_SITEINFO          @"albums/siteinfo"
#define POST_INTERACTIONINFO    @"actys/save"
#define DOWN_URL                [NSString stringWithFormat:@"http://download.i-xiangce.com/%@" , APP_ID]
#define ALBUM_ACTY              @"albums/acty"
#define STUDIO_LIST             @"studiopublish/list"
#define ADVERT_LIST             @"query/agentadvert"
#define WEI_XIN_APP_ID          @"wx2552c44b95ae51a4"
#define PLATFORM                @"0"
#define ADVERTISE_SAVE          @"advert/save"
#define SHAREDATA_SAVE          @"share/save"
#define ALBUMS_APP              @"albums/app"


#define kAppKey             @"2209558643"
#define kAppSecret          @"387b13cf6d788070858211bc693f9ce0"
#define kAppRedirectURI     @"http://www.sz.js.cn"

#define WiressSDKDemoAppKey     @"801213517"
#define WiressSDKDemoAppSecret  @"9819935c0ad171df934d0ffb340a3c2d"
#define REDIRECTURI             @"http://www.ying7wang7.com"
#define PUSH_CIRCLE             @"query/pushcircle"
@end
