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
 
   }

@property(nonatomic,strong)NSString*conditionsname;
@end
