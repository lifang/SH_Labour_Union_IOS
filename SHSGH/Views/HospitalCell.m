//
//  HospitalCell.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "HospitalCell.h"

@implementation HospitalCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"city";
    HospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HospitalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.textLabel.textColor = sColor(51, 51, 51, 1.0);
        self.detailTextLabel.textColor = sColor(124, 124, 124, 1.0);
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"right_view"];
        self.accessoryView = imageV;
        
        //取出cell默认的背景颜色
//        self.backgroundColor = sColor(220, 220, 220, 1.0);
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        self.selectedBackgroundView = view;
    }
    return self;
}
#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(20, 0, mainViewW * 0.4, self.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + CostumViewMargin, 0, mainViewW * 0.3, self.frame.size.height);
    self.accessoryView.frame = CGRectMake(CGRectGetMaxX(self.detailTextLabel.frame) + 8 * CostumViewMargin, 8, 28,28 );
}


@end
