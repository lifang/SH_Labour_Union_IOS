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
    headerV.backgroundColor = sColor(236, 236, 236, 1.0);
    headerV.frame = CGRectMake(0, 0, mainScreenW, 100);
    
    UIButton *loadBtn = [[UIButton alloc]init];
    [loadBtn addTarget:self action:@selector(loadVC) forControlEvents:UIControlEventTouchUpInside];
    [loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loadBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    loadBtn.backgroundColor = [UIColor clearColor];
    loadBtn.frame = CGRectMake(0, 4, mainScreenW / 2, 100);
    
    UILabel *loadLabel = [[UILabel alloc]init];
    loadLabel.backgroundColor = [UIColor clearColor];
    loadLabel.textAlignment =  NSTextAlignmentCenter;
    loadLabel.textColor = [UIColor lightGrayColor];
    loadLabel.font = [UIFont systemFontOfSize:15];
    loadLabel.text = @"可管理个人信息等";
    loadLabel.frame = CGRectMake(0, 68, mainScreenW / 2, 26);
    [headerV addSubview:loadLabel];
    [headerV addSubview:loadBtn];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.frame = CGRectMake(mainScreenW / 2, 8, mainScreenW / 2, 100);
    [headerV addSubview:registerBtn];
    
    self.tableView.tableHeaderView = headerV;
}

-(void)loadVC
{
    loginViewController *loginVC = [[loginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)setNavBar
{
    self.title = @"个人中心";
    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
