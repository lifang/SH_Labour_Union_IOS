//
//  ConditionsViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^aBlock)(NSString *hangyestring,NSInteger A,NSInteger BS);
@interface ConditionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Conditionstable;
//    UIImageView*seariamgeview;
    NSMutableArray*imagearry;
    NSString *urls;
    NSMutableArray*_allarry;
    NSInteger B;
        NSInteger C ;
        NSInteger D;
    
    
    BOOL _isReloadingAllData;
//    MBProgressHUD*HUD;
}
@property(nonatomic,assign)NSInteger recordint;
@property(nonatomic,assign)NSInteger GG;

@property(nonatomic,strong)NSString*conditionsname;
@property (nonatomic, copy)aBlock block;
@end
