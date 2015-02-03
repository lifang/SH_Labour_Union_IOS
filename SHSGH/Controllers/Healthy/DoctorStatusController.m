//
//  DoctorStatusController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DoctorStatusController.h"
#import "navbarView.h"
#import "DoctorsCell.h"
#import "HospitalCell.h"
#import "ClassMessageCell.h"
#import "DoctorIntroCell.h"

@interface DoctorStatusController ()

@end

@implementation DoctorStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupHeader];
    
}

-(void)setupHeader
{
    DoctorsCell *cell = [DoctorsCell cellWithTableView:self.tableView];
    cell.imageView.image = [UIImage imageNamed:@"doctor_ placeholder"];
    cell.textLabel.text = @"胡志前";
    cell.detailTextLabel.text = @"上海长征医院";
    cell.positionLabel.text = @"主任医师";
    cell.hospitalLabel.text = @"上海长征医院";
    cell.classLabel.text = @"普外一科";
    cell.height = 100;
    cell.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = cell;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)setNavBar
{
    self.title = @"医生详情";
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ClassMessageCell *cell = [ClassMessageCell cellWithTableView:tableView];
        cell.textLabel.text = @"2014-10-28";
        cell.timeLabel.text = @"星期二上午";
        cell.detailTextLabel.text = @"$15.0";
        return cell;
    }else{
    DoctorIntroCell *cell = [DoctorIntroCell cellWithTableView:tableView];
    cell.contentLabel.text = @"刘晓红，消化内科教授、主任医师，医学博士、理学博士，硕士导师，内科副主任。1982年毕业于北京医科大学医疗系，1990年北京医科大学第三医院消化科获医学博士学位，1995年日本九州大学医学部第三内科获理学博士学位（Ph.D）。 从事消化内科临床工作已25年，曾任国际医疗部主任2年，目前负责老年医";
        return cell;
    }
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    UIView *fengeV = [[UIView alloc]init];
    fengeV.backgroundColor = mainScreenColor;
    fengeV.frame = CGRectMake(0, 0, mainScreenW, 10);
    [headerV addSubview:fengeV];
    UILabel *classLabel = [[UILabel alloc]init];
     classLabel.text = @"排班信息";
    if (section == 1) {
         classLabel.text = @"医生简介";
    }
   
    classLabel.textColor = [UIColor blackColor];
    classLabel.font = [UIFont boldSystemFontOfSize:16];
    classLabel.frame = CGRectMake(10, 15, 90, 30);
    [headerV addSubview:classLabel];
    headerV.backgroundColor = [UIColor whiteColor];
    headerV.frame = CGRectMake(0, 0, mainScreenW, 40);
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = sColor(60, 153, 131, 1.0);
    leftView.frame = CGRectMake(0, CGRectGetMaxY(classLabel.frame) + CostumViewMargin, mainScreenW * 0.3, 2);
    [headerV addSubview:leftView];
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = sColor(208, 208, 208, 1.0);
    rightView.frame = CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMaxY(classLabel.frame) + CostumViewMargin, mainScreenW * 0.7, 2);
    [headerV addSubview:rightView];
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }
    if (indexPath.section == 1) {
        return 100;
    }else
    {
        return 10;
    }
}

@end
