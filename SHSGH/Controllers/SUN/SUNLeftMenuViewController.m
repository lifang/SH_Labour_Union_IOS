//
//  SUNLeftMenuViewController.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNLeftMenuViewController.h"
#import "SUNSlideSwitchDemoViewController.h"
#import "SUNTextFieldDemoViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "SUNSlideSwitchDemoViewController.h"
#import "SUNSlideSwitchView.h"
#import "MainViewController.h"

@interface SUNLeftMenuViewController ()

@end

@implementation SUNLeftMenuViewController

#pragma mark - 控制器初始化方法

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        SUNSlideSwitchDemoViewController *slideSwitchVC = [[SUNSlideSwitchDemoViewController alloc] init];
        
        self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchVC];
        
    }
    return self;
}

- (void)setupUI
{

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
    return 8;
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
        }
        else if (row == 1) {
            cell.textLabel.text = @"最新动态";
        }
        else if (row == 2) {
            cell.textLabel.text = @"维权查询";
        }
        else if (row == 3) {
            cell.textLabel.text = @"机构查询";
        }
        else if (row == 4) {
            cell.textLabel.text = @"岗位查询";
        }
        else if (row == 5) {
            cell.textLabel.text = @"商户查询";
        }
        else if (row == 6) {
            cell.textLabel.text = @"健康服务";
        }
        else if (row == 7) {
            cell.textLabel.text = @"相关查询";
        }
        else if (row == 7) {
            cell.textLabel.text = @"相关下载";
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
              NSLog(@"点击返回首页");
            if (!self.navMainViewVC) {
                MainViewController *mainVC = [[MainViewController alloc] init];
                self.navMainViewVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
            }
            [self.mm_drawerController setCenterViewController:self.navMainViewVC
                                           withCloseAnimation:YES completion:nil];
        } else if (row == 1) { //通用自定义控件
            
            if (!self.navCommonComponentVC) {
                NSLog(@"点击最新动态");
                SUNTextFieldDemoViewController *textFieldDemoVC = [[SUNTextFieldDemoViewController alloc] init];
                
                self.navCommonComponentVC = [[UINavigationController alloc] initWithRootViewController:textFieldDemoVC];
            }
            
            [self.mm_drawerController setCenterViewController:self.navCommonComponentVC
                                           withCloseAnimation:YES completion:nil];
        }else if (row == 2) { //维权记录
            NSLog(@"点击了维权登记");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 3) { //维权记录
            NSLog(@"点击了机构查询");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 4) { //维权记录
            NSLog(@"点击了岗位查询");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 5) { //维权记录
            NSLog(@"点击了商户查询");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 6) { //维权记录
            NSLog(@"点击了健康服务");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 7) { //维权记录
            NSLog(@"点击了相关查询");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
        else if (row == 8) { //维权记录
            NSLog(@"点击了相关下载");
            SUNSlideSwitchDemoViewController *slideSwitchWVC = [[SUNSlideSwitchDemoViewController alloc]init];
            self.navSlideSwitchVC = [[UINavigationController alloc] initWithRootViewController:slideSwitchWVC];
            [self.mm_drawerController setCenterViewController:self.navSlideSwitchVC
                                           withCloseAnimation:YES completion:nil];
            slideSwitchWVC.sign = row;
            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 销毁内存方法

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end