//
//  HHZCommonViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/22.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "HHZCommonViewController.h"

@interface HHZCommonViewController ()
@property (nonatomic,strong) NSMutableArray *groups;
@end

@implementation HHZCommonViewController

-(NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

//屏蔽tableView的样式
-(id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的属性
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    //方法2：调整tableView上部很大的空隙   （方法1在Cell里）
    self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HHZCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHZCommonCell *cell = [HHZCommonCell cellWithTableView:tableView];
    HHZCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    HHZCommonGroup *group = self.groups[section];
    return group.footer;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HHZCommonGroup *group = self.groups[section];
    return group.header;
}


#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.取出这行对应的item模型
    HHZCommonGroup *group = self.groups[indexPath.section];
    HHZCommonItem *item = group.items[indexPath.row];
    
    //2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc]init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    //3.判断有无需要执行的操作
    if (item.operation) {
        item.operation();
    }
}

@end
