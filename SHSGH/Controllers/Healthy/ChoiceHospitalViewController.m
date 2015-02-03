//
//  ChoiceHospitalViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ChoiceHospitalViewController.h"
#import "HospitalCell.h"

@interface ChoiceHospitalViewController ()

@end

@implementation ChoiceHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
}

-(void)setNavBar
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalCell *cell = [HospitalCell cellWithTableView:tableView];
    cell.textLabel.text = @"上海长征医院";
    cell.detailTextLabel.text = @"三级甲等";
    return cell;
}

@end
