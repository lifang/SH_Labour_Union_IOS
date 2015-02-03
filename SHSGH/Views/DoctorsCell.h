//
//  DoctorsCell.h
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorsCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
//右边收藏按钮
@property (strong, nonatomic) UIButton *rightBtn;
//职位
@property (strong, nonatomic) UILabel *positionLabel;
//医院
@property (strong, nonatomic) UILabel *hospitalLabel;
//科室
@property (strong, nonatomic) UILabel *classLabel;

@property(nonatomic,assign)BOOL btnStatus;
@end
