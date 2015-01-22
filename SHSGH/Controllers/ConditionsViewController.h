//
//  ConditionsViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^aBlock)(NSString *hangyestring);
@interface ConditionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Conditionstable;
//    UIImageView*seariamgeview;
    NSMutableArray*imagearry;
    
       NSArray*namearry;
    
}
@property(nonatomic,strong)NSString*conditionsname;
@property (nonatomic, copy)aBlock block;
@end
