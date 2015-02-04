//
//  DoctorIntroCell.h
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorIntroCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel *contentLabel;
@end
