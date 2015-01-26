//
//  PersonalManagerViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "PersonalManagerViewController.h"
#import "HHZCommonGroup.h"
#import "HHZCommonItem.h"
#import "HHZCommonCell.h"
#import "HHZCommonArrowItem.h"
#import "HHZCommonSwitchItem.h"
#import "HHZCommonLabelItem.h"
#import "navbarView.h"
#import "HHZNoArrowItem.h"
#import "PersonalEditedViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangePasswordViewController.h"

@interface PersonalManagerViewController ()

@end

@implementation PersonalManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupGroups];
}

-(void)setNavBar
{
    self.title = @"个人中心";
    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setTitle:@"编辑" forState:UIControlStateNormal];
    [buttonR.navButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)edit
{
    PersonalEditedViewController *personalEditedVC = [[PersonalEditedViewController alloc]init];
    [self.navigationController pushViewController:personalEditedVC animated:YES];
    SLog(@"点击了编辑!");
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

-(void)setupGroup0
{
    //1创建组
    HHZCommonGroup *group0 = [HHZCommonGroup group];
    [self.groups addObject:group0];
    
    //2.设置组所有行的数据
    HHZNoArrowItem *userName = [HHZNoArrowItem itemWithTitle:@"会员名"];
    userName.subtitle = @"苏晓天";
    
    HHZNoArrowItem *emailNum = [HHZNoArrowItem itemWithTitle:@"Email"];
    emailNum.subtitle = @"suxiaon@126.com";
    
    HHZNoArrowItem *exitUser = [HHZNoArrowItem itemWithTitle:@"工会会员号"];
    exitUser.subtitle = @"2055254445125559596";
    
    group0.items = @[userName,emailNum,exitUser];
    
}

-(void)setupGroup1
{
    //1创建组
    HHZCommonGroup *group1 = [HHZCommonGroup group];
    [self.groups addObject:group1];
    
    //2.设置组所有行的数据
    HHZCommonArrowItem *aboutUs = [HHZCommonArrowItem itemWithTitle:@"修改密码"];
    aboutUs.subtitle = @"********";
    
    HHZCommonArrowItem *versionsUp = [HHZCommonArrowItem itemWithTitle:@"绑定手机"];
    versionsUp.subtitle = @"158****5241";
    
    group1.items = @[aboutUs,versionsUp];
    
}


#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            ChangePhoneViewController *changePhoneVC = [[ChangePhoneViewController alloc]init];
            [self.navigationController pushViewController:changePhoneVC animated:YES];
        }
        if (indexPath.row == 0) {
            ChangePasswordViewController *changgePasswordVC = [[ChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:changgePasswordVC animated:YES];
        }

    }
}

@end
