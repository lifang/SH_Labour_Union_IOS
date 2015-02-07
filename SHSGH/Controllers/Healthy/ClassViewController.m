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
#import "HaobaiHealthyController.h"

@interface ClassViewController ()

@property(nonatomic,strong)NSMutableArray *classArray;

@property(nonatomic,strong)NSMutableArray *loadMoreArray;

@property(nonatomic,assign)int page;

@end

@implementation ClassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStyle];
    [self setupRefresh];
    [self setNavBar];
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

-(void)setStyle
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
}

-(void)loadMoreStatuses
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        _page++;
        NSString *pages = [NSString stringWithFormat:@"%d",_page];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findSection?phone=%@&offset=%@&cpid=%@&hospitalid=%@",account.phoneNum,pages,[NSString stringWithFormat:@"%@",_cpid],_hospitalid];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                SLog(@"%@",result);
                _loadMoreArray = [NSMutableArray array];
                NSArray *classesArray = [result objectForKey:@"result"];
                for (int i = 0; i < classesArray.count; i++) {
                    ClassStatus *classes = [[ClassStatus alloc]init];
                    classes.cpid = [[classesArray objectAtIndex:i] objectForKey:@"cpid"];
                    classes.deptid = [[classesArray objectAtIndex:i] objectForKey:@"deptid"];
                    classes.deptnum = [[classesArray objectAtIndex:i] objectForKey:@"deptnum"];
                    classes.deptname = [[classesArray objectAtIndex:i] objectForKey:@"deptname"];
                    [_loadMoreArray addObject:classes];
                }
                [_classArray addObjectsFromArray:_loadMoreArray];
                [self.tableView reloadData];
                [self.tableView footerEndRefreshing];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });

}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findSection?phone=%@&offset=%@&cpid=%@&hospitalid=%@",account.phoneNum,@"0",[NSString stringWithFormat:@"%@",_cpid],_hospitalid];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                SLog(@"%@",result);
                _classArray = [NSMutableArray array];
                NSArray *classesArray = [result objectForKey:@"result"];
                for (int i = 0; i < classesArray.count; i++) {
                    ClassStatus *classes = [[ClassStatus alloc]init];
                    classes.cpid = [[classesArray objectAtIndex:i] objectForKey:@"cpid"];
                    classes.deptid = [[classesArray objectAtIndex:i] objectForKey:@"deptid"];
                    classes.deptnum = [[classesArray objectAtIndex:i] objectForKey:@"deptnum"];
                    classes.deptname = [[classesArray objectAtIndex:i] objectForKey:@"deptname"];
                    [self.classArray addObject:classes];
                }
               [self.tableView reloadData];
               [self.tableView headerEndRefreshing];
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
    self.title = @"科室列表";
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
    if (self.selected == NO) {
        HaobaiHealthyController *haobaiVC = [[HaobaiHealthyController alloc]init];
        [self.navigationController pushViewController:haobaiVC animated:YES];
    }
    else{
    ClassStatus *class = [_classArray objectAtIndex:indexPath.row];
    [self.delegate sendClass:class.deptname WithDeptid:class.deptid];
    [self.navigationController popViewControllerAnimated:YES];
    }
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
