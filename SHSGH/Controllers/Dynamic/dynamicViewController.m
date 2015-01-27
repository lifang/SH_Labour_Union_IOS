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
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "PersonalViewController.h"
#import "DynamicChildViewController.h"
#import "MJRefresh.h"
#import "DynamicImage.h"


@interface dynamicViewController ()<ReuseViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation dynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupRefresh];
    [self loadImageDate];
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

-(void)loadImageDate
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"1" forKey:@"offset"];

        NSString *urls =@"/api/news/findTopNews";
        id result = [KRHttpUtil getResultDataByPost:urls param:params];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                NSArray *imageeArray = [result objectForKey:@"result"];
                _imageArray = [NSMutableArray array];
                for (int i = 0; i < imageeArray.count; i++) {
                    DynamicImage *dynamicImg = [[DynamicImage alloc]init];
                    dynamicImg.title = [[imageeArray objectAtIndex:i]objectForKey:@"bigImg"];
                    dynamicImg.ids = [[[imageeArray objectAtIndex:i]objectForKey:@"id"] intValue];
                    dynamicImg.imgPath = [[imageeArray objectAtIndex:i]objectForKey:@"imgPath"];
                    dynamicImg.time = [[imageeArray objectAtIndex:i]objectForKey:@"time"];
                    [_imageArray addObject:dynamicImg.imgPath];
                }
                SLog(@"%@",_imageArray);
                [self setScrollView];
            }
            if ([[result objectForKey:@"code"] boolValue]) {
                SLog(@"请求失败!");
                [self setScrollView];
            }
        });
    });
}

//下拉刷新加载更多微博数据
-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView headerEndRefreshing];
    });
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView footerEndRefreshing];
        
    });}


-(void)setNavBar
{
     self.title = @"区县新闻";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
 
    [buttonL.navButton setImage:[UIImage imageNamed:@"left_barbutton"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setImage:[UIImage imageNamed:@"user_white"]forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(toUser) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)toUser
{
    PersonalViewController *personVC = [[PersonalViewController alloc]init];
    self.dynamicNav = [AppDelegate shareDynamicController];
    [self.dynamicNav pushViewController:personVC animated:YES];
    SLog(@"toUser");
}


-(void)setScrollView
{
    CGFloat scrollViewH = 140;
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,0, mainScreenW, scrollViewH) array:_imageArray];
    scrollView.reuseDelegate = self;
    
    self.tableView.tableHeaderView = scrollView;
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
    DynamicChildViewController *dynamicVC = [[DynamicChildViewController alloc]init];
    [self.navigationController pushViewController:dynamicVC animated:YES];
    SLog(@"点击了第%ld行",indexPath.row);
}
 #pragma mark - ScrollView didSelect
 -(void)handleTop:(UITapGestureRecognizer *)imageView
 {
      SLog(@"点击了%@",imageView);
 }

@end
