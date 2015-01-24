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
#import "HHZLoadMoreFooter.h"
#import "DynamicChildViewController.h"


@interface dynamicViewController ()<ReuseViewDelegate>

@property (nonatomic,weak)UIRefreshControl *refreshControl;

@property (nonatomic,weak)HHZLoadMoreFooter *footer;

@end

@implementation dynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setScrollView];
    [self setupRefresh];
}

-(void)setupRefresh
{
    //1。添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    //2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    //3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    //4.加载数据
    [self refreshControlStateChange:refreshControl];
    
    //5.添加上拉刷新更多控件
    HHZLoadMoreFooter *footer = [HHZLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;

}

//当下拉刷新控件进入刷新状态时候自动调用
-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}
//下拉刷新加载更多微博数据
-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.footer endRefreshing];
    });}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.leftViewBtn.tag = 1000;
}

-(void)setNavBar
{
     self.title = @"区县新闻";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"head_bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(21, 0, 21, 0)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
 
    [buttonL.navButton setImage:[UIImage imageNamed:@"left_barbutton"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    self.leftViewBtn = buttonL.navButton;
//    self.leftViewBtn.tag = 1000;
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
//    self.leftViewBtn.tag++;
//    SLog(@"%ld",self.leftViewBtn.tag);
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
//    if (self.leftViewBtn.tag % 2 == 0) {
//        [delegate.DrawerController closeDrawerAnimated:YES completion:nil];
//    }
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
    //创建ScrollView
    NSString *url1 = @"http://www.sim.ac.cn/xwzx/ttxw/201002/W020100202431472644949.jpg";
    NSString *url2 = @"http://picapi.ooopic.com/10/58/70/26b1OOOPIC32.jpg";
    NSString *url3 = @"http://pic15.nipic.com/20110708/7921523_163228302177_2.jpg";
    NSString *url4 = @"http://www.zhituad.com/photo2/10/55/23/14b1OOOPIC34.jpg";
    NSMutableArray *picArray = [NSMutableArray arrayWithObjects:url1,url2,url3,url4, nil];
    CGFloat scrollViewH = 140;
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,0, mainScreenW, scrollViewH) array:picArray];
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

//上拉刷新的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (self.statusFrames.count <= 0 || self.footer.isRefreshing) return;
    if (self.footer.isRefreshing) return;
    //1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    //刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    //2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        //进入上拉刷新状态
        [self.footer beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadMoreStatuses];
        });
    }
}

@end
