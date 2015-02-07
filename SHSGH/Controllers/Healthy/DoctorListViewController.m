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
#import "UserTool.h"
#import "DoctorStatus.h"
#import "HaobaiHealthyController.h"

@interface DoctorListViewController ()

@property(nonatomic,strong)UIImage *btnImg1;
@property(nonatomic,strong)UIImage *btnImg2;
@property(nonatomic,assign)BOOL btnStatus;

@property(nonatomic,strong)NSMutableArray *doctorArray;

@end

@implementation DoctorListViewController

-(NSMutableArray *)doctorArray
{
    if (!_doctorArray) {
        _doctorArray = [NSMutableArray array];
    }
    return _doctorArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
    
    [self setNavBar];
    
    [self loadData];
    
}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        NSString *str = [NSString stringWithFormat:@"%@",_cpid];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findDoctorByDeptId?phone=%@&offset=%@&cpid=%@&hospitalid=%@&deptid=%@",account.phoneNum,@"0",str,_hospitalid,_deptid];
        NSString *urlss =[NSString stringWithFormat:@"/api/health/findDoctorByDeptId?phone=%@&offset=%@&cpid=%@&hospitalid=%@&deptid=%@",account.phoneNum,@"0",@"2",@"22808",@"53453"];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                SLog(@"%@",result);
                NSArray *doctorsArray = [result objectForKey:@"result"];
                for (int i = 0; i < doctorsArray.count; i++) {
                    DoctorStatus *doctors = [[DoctorStatus alloc]init];
                    doctors.cpid = (int)[[doctorsArray objectAtIndex:i] objectForKey:@"cpid"];
                    doctors.docid = (int)[[doctorsArray objectAtIndex:i] objectForKey:@"docid"];
                    doctors.docimageurl = [[doctorsArray objectAtIndex:i] objectForKey:@"docimageurl"];
                    doctors.doclevel = [[doctorsArray objectAtIndex:i] objectForKey:@"doclevel"];
                    doctors.docname = [[doctorsArray objectAtIndex:i] objectForKey:@"docname"];
                    [self.doctorArray addObject:doctors];
                }
                SLog(@"%@",_doctorArray);
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
    
    return _doctorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorsCell *cell = [DoctorsCell cellWithTableView:tableView];
    DoctorStatus *doctors = [_doctorArray objectAtIndex:indexPath.row];
    cell.textLabel.text = doctors.docname;
    cell.positionLabel.text = doctors.doclevel;
    cell.classLabel.text = _classname;
    cell.detailTextLabel.text = _hospitalname;
    cell.imageView.image = [UIImage imageNamed:@"doctor_ placeholder"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaobaiHealthyController *haobaiVC = [[HaobaiHealthyController alloc]init];
    [self.navigationController pushViewController:haobaiVC animated:YES];
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
