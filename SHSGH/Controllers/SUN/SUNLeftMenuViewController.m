//
//  SUNLeftMenuViewController.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNLeftMenuViewController.h"
#import "SUNTextFieldDemoViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "SUNSlideSwitchView.h"
#import "MainViewController.h"
#import "RelatedViewController.h"
#import "AppDelegate.h"
#import "SearchJobViewController.h"
#import "dynamicViewController.h"
#import "MaintainViewController.h"
#import "TradeViewController.h"
#import "OrganizationViewController.h"
#import "RelatedDownloadViewController.h"
@interface SUNLeftMenuViewController ()

@end

@implementation SUNLeftMenuViewController

#pragma mark - 控制器初始化方法

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)setupUI
{
    self.tableViewLeft.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc]init];
    self.tableViewLeft.tableFooterView = view;

}

#pragma mark - 控制器方法

#pragma mark - 视图加载方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - 表格视图数据源代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int section = indexPath.section;
    NSString *LeftSideCellId = @"LeftSideCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftSideCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LeftSideCellId];
    }
    if (section == 0) {
        if (row == 0) {
            cell.textLabel.text = @"首页";
            cell.imageView.image = [UIImage resizedImage:@"left_btn1"];
        }
        else if (row == 1) {
            cell.textLabel.text = @"最新动态";
            cell.imageView.image = [UIImage resizedImage:@"left_btn2"];
        }
        else if (row == 2) {
            cell.textLabel.text = @"维权登记";
            cell.imageView.image = [UIImage resizedImage:@"left_btn3"];
        }
        else if (row == 3) {
            cell.textLabel.text = @"机构查询";
            cell.imageView.image = [UIImage resizedImage:@"left_btn4"];
        }
        else if (row == 4) {
            cell.textLabel.text = @"岗位查询";
            cell.imageView.image = [UIImage resizedImage:@"left_btn5"];
        }
        else if (row == 5) {
            cell.textLabel.text = @"商户查询";
            cell.imageView.image = [UIImage resizedImage:@"left_btn6"];
        }
        else if (row == 6) {
            cell.textLabel.text = @"健康服务";
            cell.imageView.image = [UIImage resizedImage:@"left_btn7"];
        }
        else if (row == 7) {
            cell.textLabel.text = @"相关查询";
            cell.imageView.image = [UIImage resizedImage:@"left_btn8"];
        }
        else if (row == 8) {
            cell.textLabel.text = @"相关下载";
            cell.imageView.image = [UIImage resizedImage:@"left_btn9"];
        }
        
        
    }
    
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    int row = indexPath.row;
    if (section == 0) {
        if (row == 0) { //滑动切换视图
              NSLog(@"点击返回首页");;
            if (!self.navMainViewVC) {
                self.navMainViewVC = [AppDelegate shareMainController];
            }
            [self.mm_drawerController setCenterViewController:self.navMainViewVC
                                           withCloseAnimation:YES completion:nil];
        }
        
        else if (row == 1)
        
        { //通用自定义控件
            
            if (!self.navCommonComponentVC)
            
            {
                NSLog(@"点击最新动态");
                self.navCommonComponentVC = [AppDelegate shareDynamicController];
            }
            [self.mm_drawerController setCenterViewController:self.navCommonComponentVC
                                           withCloseAnimation:YES completion:nil];
        }else if (row == 2) { //维权记录
            if (!self.navMaintainViewVC)
            {
            self.navMaintainViewVC = [AppDelegate shareMaintainController];
            }
            [self.mm_drawerController setCenterViewController:self.navMaintainViewVC
                                           withCloseAnimation:YES completion:nil];
        }
        else if (row == 3)
        { 
            
            
            OrganizationViewController *slideSwitchWVC = [[OrganizationViewController alloc]init];
            
            
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            
            
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];

          
            
        }
        else if (row == 4) { //维权记录
            NSLog(@"点击了岗位查询");
            SearchJobViewController *slideSwitchWVC = [[SearchJobViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
//            slideSwitchWVC.sign = row;
            
        }
        else if (row == 5) { //维权记录
            NSLog(@"点击了商户查询");
            TradeViewController *slideSwitchWVC = [[TradeViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];

        }
        else if (row == 6) { //健康服务
            if (!_navHealhyViewVC) {
                self.navHealhyViewVC = [AppDelegate shareHealthtController];
            }
            [self.mm_drawerController setCenterViewController:self.navHealhyViewVC
                                           withCloseAnimation:YES completion:nil];
        }
        else if (row == 7) { //维权记录
            NSLog(@"点击了相关查询");

            RelatedViewController *slideSwitchWVC = [[RelatedViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
//            slideSwitchWVC.sign = row;

            
        }
        else if (row == 8) { //维权记录
            NSLog(@"点击了相关下载");
            RelatedDownloadViewController *relateVC = [[RelatedDownloadViewController alloc]init];
            self.navDownloadViewVC = [[UINavigationController alloc]initWithRootViewController:relateVC];
        
            [self.mm_drawerController setCenterViewController:self.navDownloadViewVC
                                           withCloseAnimation:YES completion:nil];

            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 销毁内存方法

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
