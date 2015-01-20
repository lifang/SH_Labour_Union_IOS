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
    clickBtn.backgroundColor = [UIColor clearColor];
    [clickBtn addTarget:_target action:_action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickBtn];
    self.clickBtn = clickBtn;
    
    UILabel *btnLabel = [[UILabel alloc]init];
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.font = [UIFont systemFontOfSize:18];
    btnLabel.textColor = [UIColor whiteColor];
    btnLabel.text = @"haha";
    [self addSubview:btnLabel];
    self.btnLabel = btnLabel;
}

//-(void)initWithtarget:(id)target action:(SEL)action
//{
//    _target = target;
//    _action = action;
//    [self initUI];
//}

- (id)initWithtarget:(id)target action:(SEL)action {
    if (self = [super init]) {
        _target = target;
        _action = action;
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
    
    CGFloat btnLabelX = 0;
    CGFloat btnLabelY = 0;
    CGFloat btnLabelW = self.frame.size.width;
    CGFloat btnLabelH = self.frame.size.height;
    
    self.btnLabel.frame = CGRectMake(btnLabelX, btnLabelY, btnLabelW, btnLabelH);
    
}

@end
