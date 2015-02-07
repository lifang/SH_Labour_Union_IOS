//
//  homeBtn.m
//  SZGH
//
//  Created by lihongliang on 15/1/16.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "homeBtn.h"


@interface homeBtn()

@end

@implementation homeBtn

-(void)initUI
{
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn addTarget:_target action:_action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickBtn];
    self.clickBtn = clickBtn;
    
    UILabel *btnLabel = [[UILabel alloc]init];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont systemFontOfSize:17];
    btnLabel.textColor = [UIColor whiteColor];
    btnLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:btnLabel];
    self.btnLabel = btnLabel;
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor clearColor];
    [self addSubview:imageV];
    self.imageV = imageV;
}


- (id)initWithtarget:(id)target action:(SEL)action BtnType:(homeBtnType)btnType {
    if (self = [super init]) {
        _target = target;
        _action = action;
        _btnType = btnType;
        [self initUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.clickBtn.frame = self.bounds;
    
    switch (self.btnType) {
        case homeBtnTypeLittle:
            [self setLittleBtn];
            break;
        case homeBtnTypeBig:
            [self setBigBtn];
            break;
        default:
            break;
    }
}

-(void)setLittleBtn
{
    CGFloat imageVW = mainViewW / 2.2;
    CGFloat imageVH = imageVW;
    CGFloat imageVX = mainViewW / 4;
    CGFloat imageVY = mainViewH / 4 - 2 * CostumViewMargin;
    self.imageV.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
    
    CGFloat btnLabelX = imageVX - imageVW / 2;
    CGFloat btnLabelY = imageVY + imageVH + 2 * CostumViewMargin;
    if (mainScreenH <= 480) {
        btnLabelY = imageVY  + imageVH;
    }
    CGFloat btnLabelW = imageVW * 2;
    CGFloat btnLabelH = 20;
    
    self.btnLabel.frame = CGRectMake(btnLabelX, btnLabelY, btnLabelW, btnLabelH);
}

-(void)setBigBtn
{
    CGFloat imageVW = mainViewW / 3;
    CGFloat imageVH = imageVW;
    CGFloat imageVX = mainViewW / 3;
    CGFloat imageVY = mainViewH / 4 - 2 * CostumViewMargin;
    self.imageV.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
    
    CGFloat btnLabelX = imageVX - imageVW / 2;
    CGFloat btnLabelY = imageVY + imageVH + 2 * CostumViewMargin;
    if (mainScreenH <= 480) {
        btnLabelY = imageVY  + imageVH;
    }
    CGFloat btnLabelW = imageVW * 2;
    CGFloat btnLabelH = 20;
    
    self.btnLabel.frame = CGRectMake(btnLabelX, btnLabelY, btnLabelW, btnLabelH);
}

@end
