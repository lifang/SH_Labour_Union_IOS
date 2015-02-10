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
#import "AppDelegate.h"
#import "UserModel.h"
#import "UserTool.h"

@interface PersonalManagerViewController ()

@end

@implementation PersonalManagerViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setNavBar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupGroups];
}

-(void)setNavBar
{
    if (mainScreenH<=480) {
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    self.title = @"个人中心";
    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
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
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    PersonalEditedViewController *personalEditedVC = [[PersonalEditedViewController alloc]init];
    personalEditedVC.name = delegate.userIDName;
    personalEditedVC.email = delegate.email;
    personalEditedVC.labourUnion = delegate.labourUnionCode;
    delegate.userIDName = nil;
    delegate.email = nil;
    delegate.labourUnionCode = nil;
    [self.navigationController pushViewController:personalEditedVC animated:YES];
    [self.groups removeAllObjects];
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
    UserModel *account = [UserTool userModel];
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    SLog(@"%@",account.userIDName);
    SLog(@"%@",delegate.userIDName);
    //1创建组
    HHZCommonGroup *group0 = [HHZCommonGroup group];
    [self.groups addObject:group0];
    
    //2.设置组所有行的数据
    HHZNoArrowItem *userName = [HHZNoArrowItem itemWithTitle:@"会员名"];
    if ([account.userIDName isKindOfClass:[NSNull class]] || account.userIDName == nil||delegate.userIDName == nil) {
         userName.subtitle = @"请完善";
        if (![account.userIDName isKindOfClass:[NSNull class]]&&account.userIDName!=nil) {
            if ([account.userIDName isEqualToString:@"(null)"]) {
                userName.subtitle = @"请完善";
            }else{
            userName.subtitle = account.userIDName;
            }
        }
    }else{
        if ([delegate.userIDName isEqualToString:@"(null)"]) {
            userName.subtitle = @"请完善";
        }else{
        userName.subtitle = delegate.userIDName;
        }
    }
    
    HHZNoArrowItem *emailNum = [HHZNoArrowItem itemWithTitle:@"Email"];
    if ([account.email isKindOfClass:[NSNull class]] || account.email == nil||delegate.email == nil||![delegate.email isKindOfClass:[NSNull class]]) {
        emailNum.subtitle = @"请完善";
        if (![account.email isKindOfClass:[NSNull class]]&&account.email!=nil) {
            if ([account.email isEqualToString:@"(null)"]) {
                emailNum.subtitle = @"请完善";
            }else{
            emailNum.subtitle = account.email;
            }
        }
    }else{
        if ([delegate.email isEqualToString:@"(null)"]) {
            delegate.email = @"请完善";
        }else{
        emailNum.subtitle = delegate.email;
        }
    }
    
    HHZNoArrowItem *LabourUnion = [HHZNoArrowItem itemWithTitle:@"工会会员号"];
    if ([account.LabourUnion isKindOfClass:[NSNull class]] || account.LabourUnion == nil||delegate.labourUnionCode == nil) {
        LabourUnion.subtitle = @"请完善";
        if (![account.LabourUnion isKindOfClass:[NSNull class]]&&account.LabourUnion!=nil) {
            if ([account.LabourUnion isEqualToString:@"(null)"]) {
                LabourUnion.subtitle = @"请完善";
            }else{
            LabourUnion.subtitle = account.LabourUnion;
            }
        }
    }else{
        if ([delegate.labourUnionCode isEqualToString:@"(null)"]) {
            LabourUnion.subtitle = @"请完善";
        }else {
            SLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%@",delegate.labourUnionCode);
        LabourUnion.subtitle = delegate.labourUnionCode;
        }
    }
    
    
    group0.items = @[userName,emailNum,LabourUnion];
    [self.tableView reloadData];
}

-(void)setupGroup1
{
    //1创建组
    HHZCommonGroup *group1 = [HHZCommonGroup group];
    [self.groups addObject:group1];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UserModel *account = [UserTool userModel];
    //2.设置组所有行的数据
    HHZCommonArrowItem *aboutUs = [HHZCommonArrowItem itemWithTitle:@"修改密码"];
    NSMutableString *password = (NSMutableString *)account.password;
    if (delegate.password) {
        password = (NSMutableString *)delegate.password;
    }
    NSMutableString *star = [[NSMutableString alloc]init];
    for (int i = 0; i < password.length; i++) {
        [star appendString:@"*"];
    }
    NSString *passwordStr = [password stringByReplacingCharactersInRange:NSMakeRange(0, password.length) withString:star];
    aboutUs.subtitle = passwordStr;
    
    HHZCommonArrowItem *versionsUp = [HHZCommonArrowItem itemWithTitle:@"绑定手机"];
    NSMutableString *phone = (NSMutableString *)account.phoneNum;
    if (delegate.phone) {
        phone = (NSMutableString *)delegate.phone;
    }
    NSString *stars = @"****";
     NSString *phoneStr = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:stars];
    versionsUp.subtitle = phoneStr;
    
    group1.items = @[aboutUs,versionsUp];
    [self.tableView reloadData];
}


#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            ChangePhoneViewController *changePhoneVC = [[ChangePhoneViewController alloc]init];
            changePhoneVC.phoneNum = delegate.phone;
               delegate.phone = nil;
            [self.groups removeAllObjects];
            [self.navigationController pushViewController:changePhoneVC animated:YES];
        }
        if (indexPath.row == 0) {
            ChangePasswordViewController *changgePasswordVC = [[ChangePasswordViewController alloc]init];
            changgePasswordVC.passWD = delegate.password;
            delegate.password = nil;
            [self.groups removeAllObjects];
            [self.navigationController pushViewController:changgePasswordVC animated:YES];
        }

    }
}


@end
