//
//  ListViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    
    UITableView*_Seatchtable;
    NSArray*namearry;
    NSMutableArray*_allarry;
    
    UITextField*_searchfield;
    NSString*urls;
    BOOL _isReloadingAllData;
    NSInteger totalCount;
    NSInteger changeA;
    NSInteger firstA;
    NSString*per_lon;
    NSString*per_lat;

    CLLocationManager* _locationManager;

    
}
@property(nonatomic,strong)NSString*ids;


@end
