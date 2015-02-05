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

@property(nonatomic,strong)NSMutableArray *loadMoreArray;

@property(nonatomic,assign)int page;

@end

@implementation ChoiceHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStyle];
    [self setNavBar];
    [self setupRefresh];
}

-(void)setupRefresh
{
    //下拉
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses:) dateKey:@"table"];
    [self.tableView headerBeginRefreshing];
    //上拉
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @">.< 正在努力加载中!";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @">.< 正在努力加载中!";
    
}

-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    [self loadData];
     self.page = 0;
}

-(void)loadMoreStatuses
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        _page ++;
        NSString *pages = [NSString stringWithFormat:@"%d",_page];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findHospital?phone=%@&offset=%@",account.phoneNum,pages];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                _loadMoreArray = [NSMutableArray array];
                NSArray *hospitalArray = [result objectForKey:@"result"];
                for (int i = 0; i < hospitalArray.count; i++) {
                    HospitalStatus *status = [[HospitalStatus alloc]init];
                    status.cpid = (int)[[hospitalArray objectAtIndex:i] objectForKey:@"cpid"];
                    status.hospitalid =[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"];
                    status.hospitalleve = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalleve"];
                    status.hospitalname = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalname"];
                    [_loadMoreArray addObject:status];
                }
                [_hospitalStatusArray addObjectsFromArray:_loadMoreArray];
                [self.tableView footerEndRefreshing];
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


-(void)setStyle
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
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
                _hospitalStatusArray = [NSMutableArray array];
                NSArray *hospitalArray = [result objectForKey:@"result"];
                for (int i = 0; i < hospitalArray.count; i++) {
                    HospitalStatus *status = [[HospitalStatus alloc]init];
                    status.cpid = (int)[[hospitalArray objectAtIndex:i] objectForKey:@"cpid"];
                    status.hospitalid =[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"];
                    status.hospitalleve = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalleve"];
                    status.hospitalname = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalname"];
                    [self.hospitalStatusArray addObject:status];
                }
                [self.tableView headerEndRefreshing];
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
