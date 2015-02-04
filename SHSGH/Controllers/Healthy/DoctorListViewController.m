//
//  DoctorListViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DoctorListViewController.h"
#import "navbarView.h"
#import "DoctorsCell.h"
#import "DoctorStatusController.h"

@interface DoctorListViewController ()

@property(nonatomic,strong)UIImage *btnImg1;
@property(nonatomic,strong)UIImage *btnImg2;
@property(nonatomic,assign)BOOL btnStatus;

@end

@implementation DoctorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
}

-(void)setNavBar
{
    self.title = @"医生列表";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"doctor_back"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)backtoHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorsCell *cell = [DoctorsCell cellWithTableView:tableView];
    cell.imageView.image = [UIImage imageNamed:@"doctor_ placeholder"];
    cell.textLabel.text = @"胡志前";
    cell.detailTextLabel.text = @"上海长征医院";
    cell.positionLabel.text = @"主任医师";
    cell.hospitalLabel.text = @"上海长征医院";
    cell.classLabel.text = @"普外一科";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorStatusController *doctorVC = [[DoctorStatusController alloc]init];
    [self.navigationController pushViewController:doctorVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

@end
