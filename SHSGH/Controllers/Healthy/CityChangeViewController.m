//
//  CityChangeViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "CityChangeViewController.h"
#import "navbarView.h"
#import "CityCell.h"

@interface CityChangeViewController ()

@end

@implementation CityChangeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavBar];
    [self initUI];
}

-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]init];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]init];
    }
    return _rightTableView;
}

-(void)initUI
{
    self.leftTableView.frame = CGRectMake(0, 0, mainScreenW * 0.6, mainScreenH);
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.tag = 1001;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTableView];
    self.rightTableView.frame = CGRectMake(mainScreenW * 0.6, 0, mainScreenW * 0.4, mainScreenH);
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.tag = 1002;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rightTableView];
    
}

-(void)setupNavBar
{
    self.title = @"城市切换";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"doctor_back"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backNavBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;

}

-(void)backNavBar
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1001) {
        return 10;
    }
    else{
    return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [CityCell cellWithTableView:tableView];
    if (tableView.tag == 1001) {
        cell.textLabel.text = @"江苏";
    }
    if (tableView.tag == 1002) {
        cell.textLabel.text = @"苏州市";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1002) {
        SLog(@"点击了右边!");
    }
    else{
        SLog(@"点击了左边!");
    }
}


@end
