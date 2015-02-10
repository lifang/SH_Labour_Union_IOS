//
//  PersonalViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/22.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "PersonalViewController.h"
#import "HHZCommonGroup.h"
#import "HHZCommonItem.h"
#import "HHZCommonCell.h"
#import "HHZCommonArrowItem.h"
#import "HHZCommonSwitchItem.h"
#import "HHZCommonLabelItem.h"
#import "navbarView.h"
#import "loginViewController.h"
#import "registerViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupGroups];
    [self setHeadView];
}

-(void)setHeadView
{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = mainScreenColor;
    headerV.frame = CGRectMake(0, 0, mainScreenW, 100);
    
    UIButton *loadBtn = [[UIButton alloc]init];
    [loadBtn addTarget:self action:@selector(loginVC) forControlEvents:UIControlEventTouchUpInside];
    [loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loadBtn setTitleColor:sColor(224, 84, 0, 1.0) forState:UIControlStateNormal];
    loadBtn.backgroundColor = [UIColor clearColor];
    loadBtn.frame = CGRectMake(0, 4, mainScreenW / 2, 100);
    
    UILabel *loadLabel = [[UILabel alloc]init];
    loadLabel.backgroundColor = [UIColor clearColor];
    loadLabel.textAlignment =  NSTextAlignmentCenter;
    loadLabel.textColor = sColor(166, 166, 166, 1.0);
    loadLabel.font = [UIFont systemFontOfSize:14];
    loadLabel.text = @"可管理个人信息等";
    loadLabel.frame = CGRectMake(0, (loadBtn.frame.size.height / 2) + (CostumViewMargin * 3), mainScreenW / 2, 26);
    [headerV addSubview:loadLabel];
    [headerV addSubview:loadBtn];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn addTarget:self action:@selector(registerVC) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:sColor(224, 84, 0, 1.0) forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.frame = CGRectMake(mainScreenW / 2, 4, mainScreenW / 2, 100);
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.textAlignment =  NSTextAlignmentCenter;
    registerLabel.textColor = sColor(166, 166, 166, 1.0);
    registerLabel.font = [UIFont systemFontOfSize:14];
    registerLabel.text = @"可享受会员信息等";
    registerLabel.frame = CGRectMake(mainScreenW / 2, (loadBtn.frame.size.height / 2) + (CostumViewMargin * 3), mainScreenW / 2, 26);
    [headerV addSubview:registerLabel];
    [headerV addSubview:registerBtn];
    
    UIView *divisionLine = [[UIView alloc]init];
    divisionLine.backgroundColor = sColor(219, 219, 219, 1.0);
    divisionLine.frame = CGRectMake(mainScreenW / 2, 40, 1, 40);
    [headerV addSubview:divisionLine];
    
    self.tableView.tableHeaderView = headerV;
}

-(void)loginVC
{
    loginViewController *loginVC = [[loginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)registerVC
{
    registerViewController *registerVC = [[registerViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)setNavBar
{
    self.title = @"个人中心";
    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoDynamic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoDynamic
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setupGroups
{
    [self setupGroup0];
}

-(void)setupGroup0
{
    //1创建组
    HHZCommonGroup *group = [HHZCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组所有行的数据
    HHZCommonArrowItem *aboutUs = [HHZCommonArrowItem itemWithTitle:@"关于我们" icon:@"about_us"];
    
    HHZCommonArrowItem *versionsUp = [HHZCommonArrowItem itemWithTitle:@"版本升级" icon:@"upgrade"];
    versionsUp.subtitle = @"最新版本V1.2.0";
    
    group.items = @[aboutUs,versionsUp];

}
@end
