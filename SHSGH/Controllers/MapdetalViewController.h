//
//  MapdetalViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface MapdetalViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* _mapViews;
    BMKRouteSearch*_searcher;
    
    double per_lon;
    double per_lat;
    BMKLocationService*_locService;
    NSMutableArray*_linebusarry;
    CLLocationCoordinate2D corld;
    
    BMKGeoCodeSearch*_searchers;
    
}
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *name;

@property(nonatomic,assign)CLLocationCoordinate2D coreld;
@property(nonatomic,assign)NSInteger  awhichway;
@property(nonatomic,assign)NSInteger  bline;
@end
