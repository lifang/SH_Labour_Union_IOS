//
//  dynamicViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "dynamicViewController.h"
#import "ReuseView.h"
#import "navbarView.h"

@interface dynamicViewController ()<ReuseViewDelegate>

@end

@implementation dynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setScrollView];
}

-(void)setNavBar
{
     self.title = @"最新动态";
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont systemFontOfSize:25],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"详细01"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setTitle:@"注册" forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;

}

-(void)setScrollView
{
    //创建ScrollView
    NSString *url1 = @"http://picapi.ooopic.com/10/50/15/28b1OOOPICca.jpg";
    NSString *url2 = @"http://picapi.ooopic.com/10/58/70/26b1OOOPIC32.jpg";
    NSString *url3 = @"http://pic15.nipic.com/20110708/7921523_163228302177_2.jpg";
    NSString *url4 = @"http://www.zhituad.com/photo2/10/55/23/14b1OOOPIC34.jpg";
    NSMutableArray *picArray = [NSMutableArray arrayWithObjects:url1,url2,url3,url4, nil];
    CGFloat scrollViewH = 100;
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,0, mainScreenW, scrollViewH) array:picArray];
    scrollView.reuseDelegate = self;
    
    self.tableView.tableHeaderView = scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = indexPath.row;
    NSString *ListViewCellId = @"ListViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListViewCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ListViewCellId];
    }
    //数据方法
    cell.textLabel.text = @"市总工会召开本市单位......";
    cell.detailTextLabel.text = @"2015-1-17";
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLog(@"点击了第%ld行",indexPath.row);
    
}
 #pragma mark - ScrollView didSelect
 -(void)handleTop:(UITapGestureRecognizer *)imageView
 {
      SLog(@"点击了%@",imageView);
 }

@end
