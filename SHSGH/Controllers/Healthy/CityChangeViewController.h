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
-(void)sendCity:(NSString *)city WithArea_id:(NSString *)area_id;
@end

@interface CityChangeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,weak)id<sendCity> delegate;

@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *downtown;
@property(nonatomic,strong)NSString *cityZero;

@property(nonatomic,strong)NSMutableArray *provinceArray;

@property(nonatomic,strong)NSMutableArray *downtownArray;

@end
