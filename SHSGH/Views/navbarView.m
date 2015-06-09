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
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    arrowImage.image = [UIImage imageNamed:@"left_barArrow"];
    [self addSubview:arrowImage];
    self.arrowImage = arrowImage;
    
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
    
    self.frame = CGRectMake(0, 0, 46, 46);
    
    switch (self.navType) {
            case navbarViewTypeLeft:
            self.navButton.frame = CGRectMake(-10, -5, 56, 56);
            break;
            case navbarViewTypeRight:
            self.navButton.frame = CGRectMake(10, -5, 56, 56);
            break;
            case navbarViewTypeDoctor:
            self.navButton.frame = CGRectMake(-10, -5, 56, 56);
            self.arrowImage.frame = CGRectMake(CGRectGetMaxX(_navButton.frame), 20, 13, 10);
        default:
            break;
    }
}

@end
