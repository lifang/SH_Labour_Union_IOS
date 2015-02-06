//
//  HaobaiHealthyController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/5.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "HaobaiHealthyController.h"
#import "navbarView.h"

@interface HaobaiHealthyController ()

@end

@implementation HaobaiHealthyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initUI];
}


-(void)initUI
{
    //顶部view
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.frame = CGRectMake(0, 0, mainScreenW, mainScreenH * 0.22);
    //右边箭头
    UIImageView *rightArrow = [[UIImageView alloc] init];
    rightArrow.image = [UIImage imageNamed:@"doctorRArrow"];
    rightArrow.frame = CGRectMake(mainScreenW - 106, 10, 76, 40);
    [topView addSubview:rightArrow];
    //文字Label
    UILabel *topL = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenW / 6.4, topView.frame.size.height / 5, 100, 15)];
    topL.font = [UIFont boldSystemFontOfSize:17];
    topL.text = @"点击右上角";
    [topView addSubview:topL];
    UILabel *choose = [[UILabel alloc]init];
    choose.font = [UIFont boldSystemFontOfSize:17];
    choose.text = @"选择";
    choose.frame = CGRectMake(topL.frame.origin.x, CGRectGetMaxY(topL.frame) + 3 * CostumViewMargin, 40, 15);
    [topView addSubview:choose];
    UILabel *colorLabel = [[UILabel alloc]init];
    colorLabel.textColor = sColor(59, 151, 125, 1.0);
    colorLabel.text = @"在浏览器 (或Safari) 打开";
    colorLabel.font = [UIFont boldSystemFontOfSize:17];
    colorLabel.frame = CGRectMake(CGRectGetMaxX(choose.frame) -  2 * CostumViewMargin, CGRectGetMaxY(topL.frame) + 3 * CostumViewMargin, 200, 15);
    [topView addSubview:colorLabel];
    UILabel *downLoad = [[UILabel alloc]init];
    downLoad.text = @"即可下载!";
    downLoad.font = [UIFont boldSystemFontOfSize:17];
    downLoad.frame = CGRectMake(topL.frame.origin.x, CGRectGetMaxY(colorLabel.frame) + 3 * CostumViewMargin, topL.frame.size.width, 15);
    [topView addSubview:downLoad];
    
    [self.view addSubview:topView];
}


-(void)setNavBar
{
    self.title = @"号百健康管家";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"doctor_back"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    navbarView *rightView = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [rightView.navButton setImage:[UIImage imageNamed:@"doctorRightNav"] forState:UIControlStateNormal];
    [rightView.navButton addTarget:self action:@selector(rightViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)backtoHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightViewClick
{
    SLog(@"点击了右边Btn--------");
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",436957167];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
