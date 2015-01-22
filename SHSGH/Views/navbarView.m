//
//  navbarView.m
//  SZGH
//
//  Created by lihongliang on 15/1/17.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "navbarView.h"

@implementation navbarView

-(void)initUI
{
    
    UIButton *navButton = [[UIButton alloc]init];
    navButton.backgroundColor = [UIColor clearColor];
    navButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:navButton];
    self.navButton = navButton;
    
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.image = [UIImage imageNamed:@"red_division"];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    [self layoutIfNeeded];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (id)initWithNavType:(navbarViewType)navType
{
    if (self = [super init]) {
         _navType = navType;
        [self initUI];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, 60, 60);
    
    switch (self.navType) {
            case navbarViewTypeLeft:
            self.navButton.frame = CGRectMake(-4, 7, 40, 40);
            self.lineView.frame = CGRectMake(47, -12, 2, 64);
            break;
            case navbarViewTypeRight:
            self.navButton.frame = CGRectMake(28, 7, 40, 40);
            self.lineView.frame = CGRectMake(15, -12, 2, 64);
            break;
        default:
            break;
    }
    
}

@end
