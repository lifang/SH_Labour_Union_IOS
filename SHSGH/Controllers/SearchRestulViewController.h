//
//  SearchRestulViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRestulViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_getresulttable;
    NSMutableArray*_allarry;
    NSMutableArray*_newallarry;
    NSMutableArray*_jobarry;
    
    NSString*getids;
    
   }

@property(nonatomic,strong)NSString*conditionsname;

@property(nonatomic,strong)NSString*stri1;
@property(nonatomic,strong)NSString*stri2;
@property(nonatomic,strong)NSString*stri3;
@property(nonatomic,strong)NSString*str4;

@property(nonatomic,strong)NSArray*jobarry;

@end
