//
//  DoctorsCell.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DoctorsCell.h"

@interface DoctorsCell()
@property(nonatomic,strong)UIImage *btnImageOn;
@property(nonatomic,strong)UIImage *btnImageOff;
@end

@implementation DoctorsCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"city";
    DoctorsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DoctorsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = sColor(124, 124, 124, 1.0);
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
        self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        UIButton *rightBtn = [[UIButton alloc]init];
        self.btnStatus = YES;
        _btnImageOn = [UIImage imageNamed:@"doctor_bg_white"];
        _btnImageOff = [UIImage imageNamed:@"doctor_bg"];
        [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 2, 15);
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [rightBtn setImage:[UIImage imageNamed:@"btnImg"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"doctor_bg_white"] forState:UIControlStateNormal];
        [rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.accessoryView = rightBtn;
        self.rightBtn = rightBtn;
        UILabel *positionLabel = [[UILabel alloc]init];
        positionLabel.textColor = [UIColor grayColor];
        positionLabel.font = [UIFont boldSystemFontOfSize:13];
        self.positionLabel = positionLabel;
        [self addSubview:positionLabel];
        UILabel *classLabel = [[UILabel alloc]init];
        classLabel.textColor = [UIColor grayColor];
        classLabel.font = [UIFont boldSystemFontOfSize:13];
        self.classLabel = classLabel;
        [self addSubview:classLabel];
        
    }
    return self;
}

-(void)btnClick:(id)sender
{
    if (self.btnStatus == YES) {
        [self.rightBtn setImage:nil forState:UIControlStateNormal];
        [self.rightBtn setBackgroundImage:self.btnImageOff forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        [self.rightBtn setImage:[UIImage imageNamed:@"btnImg"] forState:UIControlStateNormal];
        [self.rightBtn setBackgroundImage:self.btnImageOn forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    self.btnStatus = !self.btnStatus;
}

#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) +3 * CostumViewMargin, self.imageView.frame.origin.y - 2 * CostumViewMargin, 50, 30);
    self.accessoryView.frame = CGRectMake(mainViewW - 70 - 6 *CostumViewMargin, CGRectGetMaxY(self.textLabel.frame) - 2 *CostumViewMargin, 70, 27);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 3 * CostumViewMargin, CGRectGetMaxY(self.textLabel.frame) - 2 * CostumViewMargin, 150, 28);
    self.positionLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + CostumViewMargin, self.textLabel.frame.origin.y + 2, 90, 28);
    self.classLabel.frame = CGRectMake(self.textLabel.frame.origin.x,CGRectGetMaxY(self.detailTextLabel.frame) - 2.5 * CostumViewMargin , 60, 28);
}


@end
