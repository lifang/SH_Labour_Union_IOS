//
//  CityCell.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"city";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = sColor(51, 51, 51, 1.0);
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = view;
    }
    return self;
}

#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.height = 30;
    self.textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
