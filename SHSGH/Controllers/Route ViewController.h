//
//  Route ViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface Route_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Seatchtable;


    NSArray*_gryarry;
    NSArray*_hightarry;
    NSInteger     _seletedIndex;
    BOOL _flagArray[100];


}
@property(nonatomic,strong)NSArray*linarry;
@property(nonatomic,assign)CLLocationCoordinate2D coreld;
@property(nonatomic,strong)NSString *city;

@end
