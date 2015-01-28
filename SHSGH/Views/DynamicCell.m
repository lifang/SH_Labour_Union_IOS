//
//  DynamicCell.m
//  SHSGH
//
//  Created by lihongliang on 15/1/28.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DynamicCell.h"

@implementation DynamicCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"dynamic";
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DynamicCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        //取出cell默认的背景颜色
        self.backgroundColor = sColor(240, 240, 240, 1.0);
    }
    return self;
}

#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(10, 3, mainScreenW * 0.7, 40);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) - 5 * CostumViewMargin, 3, mainScreenW * 0.3, 40);
}

#pragma mark - 调整tableView头部间距
-(void)setFrame:(CGRect)frame
{
    frame.origin.y -= 0;
    [super setFrame:frame];
}


@end
