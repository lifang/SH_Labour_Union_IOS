//
//  homeBtn.h
//  SZGH
//
//  Created by lihongliang on 15/1/16.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    homeBtnTypeLittle = 1,
    homeBtnTypeBig = 2,
}homeBtnType;

@interface homeBtn : UIView

@property (nonatomic,weak) UILabel *btnLabel;

@property (nonatomic,weak) UIButton *clickBtn;

@property (nonatomic,weak) UIImageView *imageV;

@property (nonatomic, weak) id target;

@property (nonatomic) SEL action;

@property(nonatomic,assign)homeBtnType btnType;

- (id)initWithtarget:(id)target action:(SEL)action BtnType:(homeBtnType)btnType;

@end
