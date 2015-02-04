//
//  ClassViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendClass <NSObject>

@optional
-(void)sendClass:(NSString *)className WithDeptid:(NSString *)deptid;

@end

@interface ClassViewController : UITableViewController
@property(nonatomic,weak)id<sendClass> delegate;

@property(nonatomic,strong)NSString *className;
@property(nonatomic,assign)int cpid;
@property(nonatomic,strong)NSString *hospitalid;
@end
