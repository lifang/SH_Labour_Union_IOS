//
//  DituViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface DituViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* _mapView;
    BMKRouteSearch*_searcher;

    double per_lon;
    double per_lat;
    BMKLocationService*_locService;
    NSMutableArray*_linebusarry;
    CLLocationCoordinate2D corld;
    UIButton*addrbutton;
    MBProgressHUD*HUD;
    
    BMKGeoCodeSearch*_searchers;
    
}
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,assign)NSInteger  awhichway;
@property(nonatomic,assign)NSInteger  bline;
@end
