//
//  navbarView.h
//  SZGH
//
//  Created by lihongliang on 15/1/17.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    navbarViewTypeLeft = 1,
    navbarViewTypeRight = 2,
    navbarViewTypeDoctor = 3,
}navbarViewType;


@interface navbarView : UIView

@property(nonatomic,weak)UIImageView *arrowImage;

@property(nonatomic,weak)UIButton *navButton;

@property(nonatomic,assign)navbarViewType navType;

- (id)initWithNavType:(navbarViewType)navType;

@end
