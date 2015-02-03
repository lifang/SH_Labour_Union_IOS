//
//  cellBtn.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "cellBtn.h"

@implementation cellBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIImageView *leftImg = [[UIImageView alloc]init];
    _leftImg = leftImg;
    [self addSubview:leftImg];
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = sColor(144, 144, 144, 1.0);
    contentLabel.font = [UIFont boldSystemFontOfSize:18];
    _contentLabel = contentLabel;
    [self addSubview:contentLabel];
    UIImageView *rightImg = [[UIImageView alloc]init];
    rightImg.image = [UIImage imageNamed:@"doctor_RightArrow"];
    // 22 40
    _rightImg = rightImg;
    [self addSubview:rightImg];
    UIButton *clickBtn = [[UIButton alloc]init];
    clickBtn.backgroundColor = [UIColor clearColor];
    _clickBtn = clickBtn;
    [self addSubview:clickBtn];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _leftImg.frame = CGRectMake(CostumViewMargin * 3, 10, 33, 33);
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_leftImg.frame) + 3 * CostumViewMargin, 14, 90, 30);
    _rightImg.frame = CGRectMake(mainViewW - 22 - 2 * CostumViewMargin, 12, 16, 30);
    _clickBtn.frame = self.bounds;
}

@end
