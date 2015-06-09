//
//  RelatedDownloadViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/9.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "RelatedDownloadViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"

@interface RelatedDownloadViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)MBProgressHUD *mbprogressHUD;

@end

@implementation RelatedDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setWebView];
}

-(void)setWebView
{
    _mbprogressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _mbprogressHUD.labelText = @"正在加载中!";
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = CGRectMake(0, 0, mainScreenW, mainScreenH - 64);
    NSString *str = [NSString stringWithFormat:@"http://114.215.149.242:999/union/api/download/ioslist"];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requset];
    [self.view addSubview:webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_mbprogressHUD setHidden:YES];
}

-(void)setNavBar
{
    self.title = @"相关下载";
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
    
}

-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
