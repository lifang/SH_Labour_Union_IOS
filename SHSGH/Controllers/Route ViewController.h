//
//  Route ViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Route_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Seatchtable;


    NSArray*_gryarry;
    NSArray*_hightarry;
    NSInteger     _seletedIndex;
    BOOL _flagArray[100];


}

@end
