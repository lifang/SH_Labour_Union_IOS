//
//  homeBtn.h
//  SZGH
//
//  Created by lihongliang on 15/1/16.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeBtn : UIView

@property (nonatomic,weak) UILabel *btnLabel;

@property (nonatomic,weak) UIButton *clickBtn;

@property(nonatomic,weak)UIView *checkView;

@property (nonatomic, weak) id target;

@property (nonatomic) SEL action;

//- (void)initWithtarget:(id)target action:(SEL)action;

- (id)initWithtarget:(id)target action:(SEL)action;

@end
