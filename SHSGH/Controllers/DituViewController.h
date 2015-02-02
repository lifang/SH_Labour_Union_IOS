//
//  DituViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface DituViewController : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView;
    
    double per_lon;
    double per_lat;
    BMKGeoCodeSearch*_searcher;
    
}
@property(nonatomic,strong)CLGeocoder *geocoder;
@end
