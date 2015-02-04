//
//  HealthyHomeViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface HealthyHomeViewController : UIViewController<CLLocationManagerDelegate,BMKGeoCodeSearchDelegate>
{
    NSMutableArray*_allarry;
    BMKGeoCodeSearch*_searchers;
    NSString*cityLocateName;
    NSString*provinceLocateName;
    CLLocationManager* _locationManager;
    NSString*per_lon;
    NSString*per_lat;
}

@end
