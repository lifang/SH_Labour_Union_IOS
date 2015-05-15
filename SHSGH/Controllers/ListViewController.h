//
//  ListViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "DituViewController.h"

@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,BMKGeoCodeSearchDelegate>
{
    
    UITableView*_Seatchtable;
    NSArray*namearry;
    NSMutableArray*_allarry;
    BMKGeoCodeSearch*_searchers;
    DituViewController*ditu;
    UIButton *shoppingButtons;
    
    UITextField*_searchfield;
    NSString*urls;
    BOOL _isReloadingAllData;
    NSInteger totalCount;
    NSInteger changeA;
    NSInteger firstA;
    NSString*per_lon;
    NSString*per_lat;
    NSString*city;
    NSMutableArray*retearry;
    NSString*cityid;

    CLLocationManager* _locationManager;

    
}
@property(nonatomic,strong)NSString*ids;


@end
