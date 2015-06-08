//
//  DynamicChildViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DynamicChildViewController.h"
#import "navbarView.h"
#import "EGOImageView.h"
#import "DynamicContent.h"

@interface DynamicChildViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)NSString *topLabelStr;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *contentStr;


@end

@implementation DynamicChildViewController

-(NSString *)topLabelStr
{
    if (_topLabelStr == nil) {
        _topLabelStr = [[NSString alloc]init];
    }
    return _topLabelStr;
}

-(NSString *)timeStr
{
    if (_timeStr == nil) {
        _timeStr = [[NSString alloc]init];
    }
    return _timeStr;
}

-(NSString *)contentStr
{
    if (_contentStr == nil) {
        _contentStr = [[NSString alloc]init];
    }
    return _contentStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self loadData];
    
}


-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *urls = [NSString stringWithFormat:@"/api/news/findById?id=%d",self.page];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSDictionary *contentDic = [result objectForKey:@"result"];
                SLog(@"***************%@",contentDic);
                NSString *titleS = [contentDic objectForKey:@"title"];
                _topLabelStr = titleS;
                NSString *timeS = [contentDic objectForKey:@"time"];
                _timeStr = timeS;
                NSString *contentS = [contentDic objectForKey:@"content"];
                _contentStr = contentS;

//                [self setupContentView];
                [self setupWebView];
            }
            //请求失败
            else
            {
                SLog(@"请求失败!");
//                [self setupContentView];
                [self setupWebView];
            }
        });
    });
}

-(void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = CGRectMake(0, 0, mainScreenW,mainScreenH-60);
    if (mainScreenH<=480) {
        webView.frame = CGRectMake(0, 0, mainScreenW,mainScreenH-68);
    }
    NSURL *url = [NSURL URLWithString:@"http://www.sh12351.org"];
    SLog(@"%@",_contentStr);
    NSString *str1 = [NSString stringWithFormat:@"<h4 align='left'>%@</h4><hr />",_topLabelStr];
    NSString *str2 = [NSString stringWithFormat:@"%@%@",str1,_contentStr];
    [webView loadHTMLString:str2 baseURL:url];
    self.webView = webView;
    [self.view addSubview:webView];
    
    //创建回到顶部
    UIImageView *backTopView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_top"]];
    backTopView.userInteractionEnabled = YES;
    backTopView.frame = CGRectMake(mainScreenW - 60, mainScreenH - 140, 40, 40);
    UIButton *backTopBtn = [[UIButton alloc]init];
    backTopBtn.backgroundColor = [UIColor clearColor];
    backTopBtn.frame = backTopView.bounds;
    [backTopBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    [backTopView addSubview:backTopBtn];
    [webView addSubview:backTopView];

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    webView.scrollView.contentSize = CGSizeMake(0, webView.scrollView.contentSize.height);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.scrollView.contentSize = CGSizeMake(0, webView.scrollView.contentSize.height);
}


-(void)setupContentView
{
    CGFloat topMargin = 16;
    CGFloat leftMargin = 16;
    
    //创建主view
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = mainScreenColor;
    //创建标题Label
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.textColor = [UIColor blackColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont systemFontOfSize:15];
    NSString *topLabelStr = @"市总工会启动2015年工会保障工作重点研讨";
    topLabel.text = _topLabelStr;
    CGSize topLabelSize = {0,0};
    topLabelSize = [_topLabelStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200.0, 5000)];
    topLabel.numberOfLines = 0;
    topLabel.frame = CGRectMake(leftMargin, topMargin, mainScreenW * 0.9, topLabelSize.height);
    [contentView addSubview:topLabel];
    //创建时间Label
    UILabel *timeLabel = [[UILabel alloc]init];
    NSString *timeStr = @"2014-10-12 10:08";
    timeLabel.text = _timeStr;
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = sColor(107, 107, 107, 1.0);
    timeLabel.frame = CGRectMake(topLabel.frame.origin.x, CGRectGetMaxY(topLabel.frame) + CostumViewMargin, 100, 20);
    [contentView addSubview:timeLabel];
    //创建分隔线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = sColor(215, 215, 215, 1.0);
    lineView.frame = CGRectMake(leftMargin, CGRectGetMaxY(timeLabel.frame) + CostumViewMargin * 2, topLabel.frame.size.width, 1);
    [contentView addSubview:lineView];
    //创建图片
    EGOImageView *imageView = [[EGOImageView alloc]init];
    NSURL *imageUrl = [NSURL URLWithString:@"http://www.audit.suzhou.gov.cn/news/sjj/2011/3/7/16-30-54-2347-1.jpg"];
    imageView.imageURL = imageUrl;
    imageView.frame = CGRectMake(leftMargin, CGRectGetMaxY(lineView.frame) + CostumViewMargin * 2, lineView.frame.size.width, 200);
    [contentView addSubview:imageView];
    //创建正文Label
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = sColor(81, 81, 81, 1.0);
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.text = _contentStr;
    CGSize textLabelSize = {0,0};
    textLabelSize = [_contentStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenW * 0.9, 5000)];
    textLabel.numberOfLines = 0;
    textLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(imageView.frame) + CostumViewMargin * 3, mainScreenW * 0.9, textLabelSize.height);
    [contentView addSubview:textLabel];
    [self.view addSubview:contentView];
    contentView.contentSize = CGSizeMake(mainScreenW, CGRectGetMaxY(textLabel.frame) + 70);
    self.contentView = contentView;
    //创建回到顶部
    UIImageView *backTopView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_top"]];
    backTopView.userInteractionEnabled = YES;
    backTopView.frame = CGRectMake(mainScreenW - 60, mainScreenH - 140, 40, 40);
    UIButton *backTopBtn = [[UIButton alloc]init];
    backTopBtn.backgroundColor = [UIColor clearColor];
    backTopBtn.frame = backTopView.bounds;
    [backTopBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    [backTopView addSubview:backTopBtn];
    [self.view addSubview:backTopView];
}

-(void)backTop
{
    [UIView animateWithDuration:0.3 animations:^{
//        _webView.contentScaleFactor = CGPointMake(0, 0);
        _webView.scrollView.contentOffset = CGPointMake(0, 0);
    }];
    SLog(@"back");
}

-(void)setNavBar
{
    self.title = @"新闻详情";
    self.view.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoDynamic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoDynamic
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
