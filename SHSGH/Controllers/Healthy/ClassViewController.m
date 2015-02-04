//
//  ClassViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ClassViewController.h"
#import "navbarView.h"
#import "HospitalCell.h"

@interface ClassViewController ()

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
}

-(void)setNavBar
{
    self.title = @"医院列表";
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
    HospitalCell *cell = [HospitalCell cellWithTableView:tableView];
    cell.textLabel.text = @"普外一科";
    _className = cell.textLabel.text;
    cell.detailTextLabel.text = @"5人";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate sendClass:_className];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
