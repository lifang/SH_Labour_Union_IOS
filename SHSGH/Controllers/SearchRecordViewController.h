//
//  SearchRecordViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Conditionstable;
    NSInteger changeA;
    NSMutableArray*_newallarry;

    
}

@property(nonatomic,strong)NSArray*recortarry;
@end
