//
//  OrganizationdetalViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface OrganizationdetalViewController : UIViewController<UIScrollViewDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>


{
    BMKGeoCodeSearch*_searchers;
    NSString*per_lon;
    NSString*per_lat;
    NSString*city;
    
    CLLocationManager* _locationManager;
    UIScrollView*_scrool;
    UIPageControl *_page;
    UIScrollView*bigscroll;
    NSInteger          _move;
    NSTimer      *_scrollcententtimer;
}


@property(nonatomic,strong)NSString*time;

@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*tel;

@end
