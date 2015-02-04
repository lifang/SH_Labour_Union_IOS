//
//  ClassMessageCell.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ClassMessageCell.h"

@implementation ClassMessageCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"city";
    ClassMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ClassMessageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.textLabel.textColor = sColor(125, 125, 125, 1.0);
        self.detailTextLabel.textColor = sColor(63, 166, 144, 1.0);
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"right_ArrowGreen"];
        self.accessoryView = imageV;
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont boldSystemFontOfSize:14];
        timeLabel.textColor = sColor(125, 125, 125, 1.0);
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
    }
    return self;
}
#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(10, 0, 80, self.frame.size.height);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + 6 *CostumViewMargin, 0, 70, self.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) +6 * CostumViewMargin, 0, 40, self.frame.size.height);
    self.accessoryView.frame = CGRectMake(mainScreenW - 10 * CostumViewMargin, 8, 11,20 );
}


@end
