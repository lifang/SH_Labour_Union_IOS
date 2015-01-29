//
//  TradedetalViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface TradedetalViewController : UIViewController<UIScrollViewDelegate,BMKMapViewDelegate,CLLocationManagerDelegate>


{
    UIScrollView*_scrool;
    UIPageControl *_page;
    UIScrollView*bigscroll;
    NSInteger          _move;
    NSTimer      *_scrollcententtimer;
        BMKMapView* _mapView;
    CLLocationManager* _locationManager;

}


@property(nonatomic,strong)NSString*ids;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*tel;
@property(nonatomic,strong)NSString*about;

@end
