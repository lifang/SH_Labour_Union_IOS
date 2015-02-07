//
//  DoctorListViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorListViewController : UITableViewController

@property(nonatomic,strong)NSString *cpid;
@property(nonatomic,strong)NSString *deptid;
@property(nonatomic,strong)NSString *hospitalid;

@property(nonatomic,strong)NSString *hospitalname;
@property(nonatomic,strong)NSString *classname;

@end
