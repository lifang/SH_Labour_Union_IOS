//
//  ConditionsViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Conditionstable;
//    UIImageView*seariamgeview;
    NSMutableArray*imagearry;
    
       NSArray*namearry;
    
}
@property(nonatomic,strong)NSString*conditionsname;

@end
