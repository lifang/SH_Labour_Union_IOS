//
//  OtherjobViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherjobViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Conditionstable;
    NSMutableArray*_newallarry;
    NSString*getids;

    
}
@property(nonatomic,strong)NSString*otherids;


@end
