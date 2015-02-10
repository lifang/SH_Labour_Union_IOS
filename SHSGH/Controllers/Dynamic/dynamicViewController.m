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
#import "DynamicStatus.h"
#import "DynamicCell.h"
#import "IDModel.h"
#import "DynamicChildViewController.h"
#import "UserModel.h"
#import "UserTool.h"
#import "PersonalDoneViewController.h"


@interface dynamicViewController ()<ReuseViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)NSMutableArray *listArray;

@property(nonatomic,strong)NSMutableArray *loadMoreArray;

@property(nonatomic,strong)NSMutableArray *idArray;

@property(nonatomic,assign)int page;

@property(nonatomic,strong)ReuseView *reuseViewscrollView;

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
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *imageeArray = [result objectForKey:@"result"];
                SLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~%ld",imageeArray.count);
                _imageArray = [NSMutableArray array];
                _idArray = [NSMutableArray array];
                for (int i = 0; i < imageeArray.count; i++) {
                    DynamicImage *dynamicImg = [[DynamicImage alloc]init];
                    dynamicImg.title = [[imageeArray objectAtIndex:i]objectForKey:@"bigImg"];
                    dynamicImg.ids = [[[imageeArray objectAtIndex:i]objectForKey:@"id"] intValue];
                    dynamicImg.imgPath = [[imageeArray objectAtIndex:i]objectForKey:@"imgPath"];
                    dynamicImg.time = [[imageeArray objectAtIndex:i]objectForKey:@"time"];
                    
                    IDModel *idModel = [[IDModel alloc]init];
                    idModel.ids = [[imageeArray objectAtIndex:i]objectForKey:@"id"];
                    [_idArray addObject:idModel.ids];
                    [_imageArray addObject:dynamicImg.imgPath];
                }
                SLog(@"%@",_imageArray);
                [self setScrollView];
            }
            else {
                [self setScrollView];
            }
        });
    });
}

//下拉刷新数据
-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    self.page = 1;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"0" forKey:@"offset"];
        NSString *urls =@"/api/news/findNews?offset=1";
        id result = [KRHttpUtil getResultDataByPost:urls param:params];
        SLog(@"&*************************%@",result);
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *imageeArray = [result objectForKey:@"result"];
                _listArray = [NSMutableArray array];
                for (int i = 0; i < imageeArray.count; i++) {
                    DynamicImage *dynamicImg = [[DynamicImage alloc]init];
                    dynamicImg.title = [[imageeArray objectAtIndex:i]objectForKey:@"title"];
                    dynamicImg.ids = [[[imageeArray objectAtIndex:i]objectForKey:@"id"] intValue];
                    dynamicImg.time = [[imageeArray objectAtIndex:i]objectForKey:@"time"];
                    [_listArray addObject:dynamicImg];
                }
//                SLog(@"-----------%@",_listArray);
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
            }
            //请求失败
            else {
                SLog(@"请求失败!");
                [self.tableView headerEndRefreshing];
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"网络连接失败,请检查网络!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        });
    });
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.page++;
        NSString *pages = [NSString stringWithFormat:@"%d",self.page];
        SLog(@"%@",pages);
        NSString *urls =[NSString stringWithFormat:@"/api/news/findNews?offset=%@",pages];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *imageeArray = [result objectForKey:@"result"];
                _loadMoreArray = [NSMutableArray array];
                for (int i = 0; i < imageeArray.count; i++) {
                    DynamicImage *dynamicImg = [[DynamicImage alloc]init];
                    dynamicImg.title = [[imageeArray objectAtIndex:i]objectForKey:@"title"];
                    dynamicImg.ids = [[[imageeArray objectAtIndex:i]objectForKey:@"id"] intValue];
                    dynamicImg.time = [[imageeArray objectAtIndex:i]objectForKey:@"time"];
                    [_loadMoreArray addObject:dynamicImg];
                }
                                SLog(@"-----------loadmore%@",_loadMoreArray);
                [_listArray addObjectsFromArray:_loadMoreArray];
                [self.tableView footerEndRefreshing];
                [self.tableView reloadData];
            }
            //请求失败
            else {
                SLog(@"请求失败!");
                [self.tableView footerEndRefreshing];
            }
        });
    });

}


-(void)setNavBar
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    UserModel *account = [UserTool userModel];
    SLog(@"~~~~~~~~~~~~~~~~~~~~~~~~%@",account.password);
    if (account.password) {
        PersonalDoneViewController *personDoneVC = [[PersonalDoneViewController alloc]init];
        personDoneVC.userName = account.username;
        personDoneVC.userPasswd = account.password;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.username = account.username;
        delegate.password = account.password;
        delegate.phone = account.phoneNum;
        delegate.email = account.email;
        delegate.labourUnionCode = account.LabourUnion;
        self.dynamicNav = [AppDelegate shareDynamicController];
        [_dynamicNav pushViewController:personDoneVC animated:YES];
    }else{
    PersonalViewController *personVC = [[PersonalViewController alloc]init];
    self.dynamicNav = [AppDelegate shareDynamicController];
    [_dynamicNav pushViewController:personVC animated:YES];
    }
}


-(void)setScrollView
{
    CGFloat scrollViewH = 140;
//    [_imageArray removeLastObject];
    ReuseView *reuseViewscrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,0, mainScreenW, scrollViewH) array:_imageArray];
    reuseViewscrollView.reuseDelegate = self;
    self.tableView.tableHeaderView = reuseViewscrollView;
    self.reuseViewscrollView = reuseViewscrollView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DynamicCell *cell =[DynamicCell cellWithTableView:tableView];
    DynamicStatus *status = [_listArray objectAtIndex:indexPath.row];
    cell.textLabel.text = status.title;
    cell.detailTextLabel.text = status.time;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicStatus *status = [_listArray objectAtIndex:indexPath.row];
    DynamicChildViewController *dynamicVC = [[DynamicChildViewController alloc]init];
    dynamicVC.page =  status.ids;
    [self.navigationController pushViewController:dynamicVC animated:YES];
    SLog(@"点击了第%ld行",indexPath.row);
}
 #pragma mark - ScrollView didSelect
 -(void)handleTop:(UITapGestureRecognizer *)imageView
 {
     int ids = (int)imageView.view.tag - 101;
     int imageId = [_idArray[ids] intValue];
     DynamicChildViewController *dynamicChildVC = [[DynamicChildViewController alloc]init];
     dynamicChildVC.page = imageId;
     [self.navigationController pushViewController:dynamicChildVC animated:YES];
     SLog(@"图片的ID-----------%d",imageId);
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
