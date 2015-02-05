//
//  ChoiceHospitalViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ChoiceHospitalViewController.h"
#import "HospitalCell.h"
#import "navbarView.h"
#import "UserTool.h"
#import "HospitalStatus.h"

@interface ChoiceHospitalViewController ()

@property(nonatomic,strong)NSMutableArray *hospitalStatusArray;

@end

@implementation ChoiceHospitalViewController

-(NSMutableArray *)hospitalStatusArray
{
    if (!_hospitalStatusArray) {
        _hospitalStatusArray = [NSMutableArray array];
    }
    return _hospitalStatusArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self loadData];
}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findHospital?phone=%@&offset=%@",account.phoneNum,@"0"];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                NSArray *hospitalArray = [result objectForKey:@"result"];
                for (int i = 0; i < hospitalArray.count; i++) {
                    HospitalStatus *status = [[HospitalStatus alloc]init];
                    status.cpid = (int)[[hospitalArray objectAtIndex:i] objectForKey:@"cpid"];
                    status.hospitalid =[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"];
                    status.hospitalleve = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalleve"];
                    status.hospitalname = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalname"];
                    [self.hospitalStatusArray addObject:status];
                }
                SLog(@"%@",_hospitalStatusArray);
                [self.tableView reloadData];
           }
            else {
            
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });

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

    return _hospitalStatusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalCell *cell = [HospitalCell cellWithTableView:tableView];
    HospitalStatus *status = [_hospitalStatusArray objectAtIndex:indexPath.row];
    cell.textLabel.text = status.hospitalname;
    cell.detailTextLabel.text = status.hospitalleve;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HospitalStatus *status = [_hospitalStatusArray objectAtIndex:indexPath.row];
    [self.delegate sendHospital:status.hospitalname WithCpid:status.cpid WithHospitalid:status.hospitalid];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
