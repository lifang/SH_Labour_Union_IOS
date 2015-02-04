//
//  CityChangeViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendCity <NSObject>

@optional
-(void)sendCity:(NSString *)city;
@end

@interface CityChangeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,weak)id<sendCity> delegate;

@end
