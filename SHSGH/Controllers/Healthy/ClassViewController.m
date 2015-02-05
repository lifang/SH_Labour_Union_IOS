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
#import "UserTool.h"
#import "ClassStatus.h"

@interface ClassViewController ()

@property(nonatomic,strong)NSMutableArray *classArray;

@end

@implementation ClassViewController

-(NSMutableArray *)classArray
{
    if (!_classArray) {
        _classArray = [NSMutableArray array];
    }
    return _classArray;
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
        NSString *urls =[NSString stringWithFormat:@"/api/health/findSection?phone=%@&offset=%@&cpid=%@&hospitalid=%@",account.phoneNum,@"0",[NSString stringWithFormat:@"%d",_cpid],_hospitalid];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                SLog(@"%@",result);
                NSArray *classesArray = [result objectForKey:@"result"];
                for (int i = 0; i < classesArray.count; i++) {
                    ClassStatus *classes = [[ClassStatus alloc]init];
                    classes.cpid = (int)[[classesArray objectAtIndex:i] objectForKey:@"cpid"];
                    classes.deptid = [[classesArray objectAtIndex:i] objectForKey:@"deptid"];
                    classes.deptnum = [[classesArray objectAtIndex:i] objectForKey:@"deptnum"];
                    classes.deptname = [[classesArray objectAtIndex:i] objectForKey:@"deptname"];
                    [self.classArray addObject:classes];
                }
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
    
    return _classArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalCell *cell = [HospitalCell cellWithTableView:tableView];
    ClassStatus *class = [_classArray objectAtIndex:indexPath.row];
    NSString *str = class.deptnum;
    cell.textLabel.text = class.deptname;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@人",str];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassStatus *class = [_classArray objectAtIndex:indexPath.row];
    [self.delegate sendClass:class.deptname WithDeptid:class.deptid];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
