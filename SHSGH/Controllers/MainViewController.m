//
//  MainViewController.m
//  SZGH
//
//  Created by lihongliang on 15/1/14.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "MainViewController.h"
#import "ReuseView.h"
#import "homeBtn.h"
#import "SUNTextFieldDemoViewController.h"
#import "SUNLeftMenuViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "AppDelegate.h"
#import "SearchJobViewController.h"
#import "dynamicViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MainImage.h"
#import "EGOImageView.h"

@interface MainViewController ()<ReuseViewDelegate,EGOImageViewDelegate,ImageScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)NSMutableArray *bigArray;

@property(nonatomic,strong)EGOImageView *bigView;

@property(nonatomic,strong)UIButton *clickBtn;

@property(nonatomic,strong)ReuseView *reuseScrollView;

@end

@implementation MainViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bigView = [[EGOImageView alloc]init];
    _clickBtn = [[UIButton alloc]init];
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadImageDate];
    [self initAndLayoutUI];

}

-(void)setupCustomView
{
    //创建topView
    UIButton *topView = [[UIButton alloc]init];
    topView.backgroundColor = sColor(217, 217, 217, 1.0);
    UIImageView *logoV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    logoV.frame = CGRectMake(14, 24, mainScreenW * 0.9, logoV.frame.size.height);
    [topView addSubview:logoV];
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = mainScreenW;
    CGFloat topViewH = 60;
    //适配4s
    if (mainScreenH <= 480) {
        topViewH = 60;
    }
    topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    CGFloat scrollViewH = 110;
    if (mainScreenH <= 480) {
        scrollViewH = 80;
    }
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,topViewY + topViewH + CostumViewMargin, mainScreenW, scrollViewH) array:_imageArray];
    CGFloat scrollViewY = topViewY + topViewH + CostumViewMargin;
    scrollView.reuseDelegate = self;
    self.reuseScrollView = scrollView;
    [self.view addSubview:scrollView];
    
    //创建底部的工具按钮
    UIButton *bottomView = [[UIButton alloc]init];
    [bottomView setBackgroundImage:[UIImage imageNamed:@"bottomBg"] forState:UIControlStateNormal];
    [bottomView setBackgroundImage:[UIImage imageNamed:@"bottomBg"] forState:UIControlStateHighlighted];
    bottomView.backgroundColor = [UIColor clearColor];
    CGFloat bottomViewX = 0;
    CGFloat bottomViewH = 76;
    CGFloat bottomViewY = [UIScreen mainScreen].bounds.size.height - bottomViewH;
    CGFloat bottomViewW = mainScreenW;
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"logo1"];
    CGFloat imageViewW = mainScreenW / 10;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = mainScreenW / 2 - imageViewW / 2 + CostumViewMargin - 1;
    CGFloat imageViewY = CostumViewMargin * 2;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [bottomView addSubview:imageView];
    
    UILabel *bottomL = [[UILabel alloc]init];
    bottomL.backgroundColor = [UIColor clearColor];
    bottomL.textAlignment = NSTextAlignmentCenter;
    bottomL.font = [UIFont boldSystemFontOfSize:17];
    bottomL.text = @"首页";
    bottomL.textColor = sColor(154, 12, 2, 1.0);
    CGFloat bottomLW = imageViewW + 10;
    CGFloat bottomLH = imageViewH;
    CGFloat bottomLX = imageViewX - 5;
    CGFloat bottomLY = imageViewY + imageViewH - CostumViewMargin;
    if (mainScreenH <= 480) {
        bottomLY = imageViewY + imageViewH - CostumViewMargin - 5;
    }
    bottomL.frame = CGRectMake(bottomLX, bottomLY, bottomLW, bottomLH);
    [bottomView addSubview:bottomL];
    
    [self.view addSubview:bottomView];
    
    
    //创建中间的两排方格
    CGFloat centerViewW = (mainScreenW - 4 * CostumViewMargin)/3;
    CGFloat centerViewH = (mainScreenH - (topViewH - 20 + scrollViewH + statusBarH + 4 * CostumViewMargin)  - bottomViewH + 16)/3;
    for (int index = 0; index < 6; index++) {
        homeBtn *centerView = [[homeBtn alloc]initWithtarget:self action:@selector(btnClick:) BtnType:homeBtnTypeLittle];
//        centerView.backgroundColor = HHZRandomColor;
        int row = index / liltleColumnCount;
        int col = index % liltleColumnCount;
        centerView.clickBtn.tag = index;
        CGFloat centerViewX = CostumViewMargin + col * (centerViewW + CostumViewMargin);
        CGFloat centerViewY = (scrollViewY + scrollViewH + CostumViewMargin) + row * (centerViewH + CostumViewMargin);
        centerView.frame = CGRectMake(centerViewX, centerViewY, centerViewW, centerViewH);
        switch (centerView.clickBtn.tag) {
            case 0:
                centerView.backgroundColor = HHZColor(216, 111, 187);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn1"];
                centerView.btnLabel.text = @"最新动态";
                break;
            case 1:
                centerView.backgroundColor = HHZColor(153, 107, 243);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn2"];
                centerView.btnLabel.text = @"维权登记";
                break;
            case 2:
                centerView.backgroundColor = HHZColor(242, 104, 16);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn3"];
                centerView.btnLabel.text = @"机构查询";
                break;
            case 3:
                centerView.backgroundColor = HHZColor(77, 156, 219);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn4"];
                centerView.btnLabel.text = @"岗位查询";
                break;
            case 4:
                centerView.backgroundColor = HHZColor(80, 199, 170);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn5"];
                centerView.btnLabel.text = @"商户查询";
                break;
            case 5:
                centerView.backgroundColor = HHZColor(124, 189, 82);
                centerView.imageV.image = [UIImage imageNamed:@"home_btn6"];
                centerView.btnLabel.text = @"健康服务";
                break;
            default:
                break;
        }
        [self.view addSubview:centerView];
    }
    
    
    //创建下面的一排方格
    CGFloat downViewW = (mainScreenW - 3 * CostumViewMargin)/2;
    CGFloat downViewH = centerViewH;
    homeBtn *downViewL = [[homeBtn alloc]initWithtarget:self action:@selector(btnClick:) BtnType:homeBtnTypeBig];
    downViewL.imageV.image = [UIImage imageNamed:@"home_btn7"];
    downViewL.backgroundColor = HHZColor(235, 130, 51);
    downViewL.btnLabel.text = @"相关查询";
    downViewL.clickBtn.tag = 6;
    CGFloat downViewLX = CostumViewMargin;
    CGFloat downViewLY = scrollViewY + scrollViewH + 3 * CostumViewMargin + 2 * centerViewH;
    
    downViewL.frame = CGRectMake(downViewLX, downViewLY, downViewW, downViewH);
    
    [self.view addSubview:downViewL];
    
    homeBtn *downViewR = [[homeBtn alloc]initWithtarget:self action:@selector(btnClick:) BtnType:homeBtnTypeBig];
    downViewR.imageV.image = [UIImage imageNamed:@"home_btn8"];
    downViewR.backgroundColor = HHZColor(229, 50, 98);
    downViewR.btnLabel.text = @"相关下载";
    downViewR.clickBtn.tag = 7;
    CGFloat downViewRX = downViewW + 2 * CostumViewMargin;
    CGFloat downViewRY = downViewLY;
    
    downViewR.frame = CGRectMake(downViewRX, downViewRY, downViewW, downViewH);
    [self.view addSubview:downViewR];
    [self.view bringSubviewToFront:bottomView];
}

-(void)btnClick:(homeBtn *)centerView
{
    
    switch (centerView.tag) {
        case 0:
            [self setDynamicController];
            break;
        case 1:
            [self setmiantainController];
            break;
        case 2:
            [self Organization];
            break;
        case 3:
            [self job];
            break;
        case 4:
            [self Tradesearch];
            break;
        case 5:
            [self setHealthyController];
            break;
        case 6:
            [self related];
            break;
        default:
            break;
    }
}

-(void)setHealthyController
{
    UINavigationController *healthyNav = [AppDelegate shareHealthtController];
    
    [self.mm_drawerController setCenterViewController:healthyNav withCloseAnimation:YES completion:nil];
}
// 相关查询
-(void)related
{
    UINavigationController *dynamicNav = [AppDelegate shareDynamicController6];
    
    [self.mm_drawerController setCenterViewController:dynamicNav withCloseAnimation:YES completion:nil];
    
    
    //    SearchJobViewController*job=[[SearchJobViewController alloc]init];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    [window setRootViewController:job];
    
}
// 商户查询
-(void)Tradesearch
{
    UINavigationController *dynamicNav = [AppDelegate shareDynamicController4];
    
    [self.mm_drawerController setCenterViewController:dynamicNav withCloseAnimation:YES completion:nil];
    
    
    //    SearchJobViewController*job=[[SearchJobViewController alloc]init];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    [window setRootViewController:job];
    
}
// 机构查询
-(void)Organization
{
    UINavigationController *dynamicNav = [AppDelegate shareDynamicController2];
    
    [self.mm_drawerController setCenterViewController:dynamicNav withCloseAnimation:YES completion:nil];
    
    
    //    SearchJobViewController*job=[[SearchJobViewController alloc]init];
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    [window setRootViewController:job];
    
}
// 岗位查询
-(void)job
{
    
    
    UINavigationController *dynamicNav = [AppDelegate shareDynamicController3];
    
    [self.mm_drawerController setCenterViewController:dynamicNav withCloseAnimation:YES completion:nil];
    
    
//    SearchJobViewController*job=[[SearchJobViewController alloc]init];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window setRootViewController:job];

}

-(void)setDynamicController
{
    UINavigationController *dynamicNav = [AppDelegate shareDynamicController];
    
    [self.mm_drawerController setCenterViewController:dynamicNav withCloseAnimation:YES completion:nil];
}

-(void)setmiantainController
{
    UINavigationController *miantainNav = [AppDelegate shareMaintainController];
    
    [self.mm_drawerController setCenterViewController:miantainNav withCloseAnimation:YES completion:nil];

}

-(void)loadImageDate
{
    [self setupCustomView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/activity/findAll";
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *imageeArray = [result objectForKey:@"result"];
                _imageArray = [NSMutableArray array];
                _bigArray = [NSMutableArray array];
                for (int i = 0; i < imageeArray.count; i++) {
                    MainImage *mainImg = [[MainImage alloc]init];
                    mainImg.bigImg = [[imageeArray objectAtIndex:i]objectForKey:@"bigImg"];
                    mainImg.ids = [[[imageeArray objectAtIndex:i]objectForKey:@"id"] intValue];
                    mainImg.smallImg = [[imageeArray objectAtIndex:i]objectForKey:@"smallImg"];                [_imageArray addObject:mainImg.smallImg];
                    [_bigArray addObject:mainImg.bigImg];
                }
                 [self setupCustomView];
            }
            else {
                SLog(@"请求失败!");
                [self setupCustomView];
            }
        });
    });
}

#pragma mark - ScrollView didSelect
-(void)handleTop:(UITapGestureRecognizer *)imageView
{
//    UIButton *mainClick = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainScreenW, mainScreenH)];
//    [mainClick addTarget:self action:@selector(clickedBtn) forControlEvents:UIControlEventTouchUpInside];
//    [mainClick becomeFirstResponder];
//    self.clickBtn = mainClick;
//    
    int ids = (int)imageView.view.tag - 101;
    EGOImageView *bigV = [[EGOImageView alloc]init];
    bigV.userInteractionEnabled = YES;
    bigV.delegate = self;
    bigV.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_bigArray[ids]]];
    bigV.backgroundColor = [UIColor clearColor];
    self.bigView = bigV;
    
    [self.view bringSubviewToFront:self.scrollPanel];
    self.scrollPanel.alpha = 1.0;
    
    UIImageView *imageViews = (UIImageView *)[imageView view];
    self.currentIndex = imageViews.tag;
    
    CGRect convertRect = [[imageViews superview] convertRect:imageViews.frame toView:self.view];
    CGPoint contentOffset = self.imagesScrollView.contentOffset;
    contentOffset.x = (self.currentIndex - 1) * self.view.bounds.size.width;
    self.imagesScrollView.contentOffset = contentOffset;
    
    [self addImageScrollViewForController:self];
    
    ImageScrollView *imagescroll = [[ImageScrollView alloc] initWithFrame:(CGRect){contentOffset,self.imagesScrollView.bounds.size}];
    [imagescroll setContentWithFrame:convertRect];
    [imagescroll setImage:_bigView.image];
    [self.imagesScrollView addSubview:imagescroll];
    imagescroll.tapDelegate = self;
    [self performSelector:@selector(setOriginFrame:) withObject:imagescroll afterDelay:0.1f];
}

-(void)clickedBtn
{
    [self.bigView removeFromSuperview];
    [self.clickBtn removeFromSuperview];
}

- (void)showMessage:(NSString*)message viewHeight:(float)height;
{
    if(self)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        //        hud.dimBackground = YES;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.yOffset = height;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

#pragma mark -
- (void)imageViewLoadedImage:(EGOImageView*)imageView {
    NSLog(@"%@",NSStringFromCGSize(imageView.image.size));
}

#pragma mark - 图片放大
#pragma mark - UI

- (void)initAndLayoutUI {
    _scrollPanel = [[UIView alloc] initWithFrame:self.view.bounds];
    _scrollPanel.backgroundColor = [UIColor clearColor];
    _scrollPanel.alpha = 0;
    [self.view addSubview:_scrollPanel];
    
    CGRect rect = _scrollPanel.bounds;
    rect.origin.y = -64;
    rect.size.height += 64;
    _markView = [[UIView alloc] initWithFrame:rect];
    _markView.backgroundColor = [UIColor blackColor];
    _markView.alpha = 0.0;
    [_scrollPanel addSubview:_markView];
    
    _imagesScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollPanel addSubview:_imagesScrollView];
    _imagesScrollView.pagingEnabled = YES;
    _imagesScrollView.delegate = self;
}

#pragma mark - 大图

- (void)addImageScrollViewForController:(UIViewController *)controller {
    [self.imagesScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 1; i <= self.totalPage; i++) {
        if (i == self.currentIndex) {
            continue;
        }
        UIImageView *imageView = (UIImageView *)[_reuseScrollView viewWithTag:i];
        CGRect convertRect = [[imageView superview] convertRect:imageView.frame toView:self.view];
        ImageScrollView *imagescroll = [[ImageScrollView alloc] initWithFrame:(CGRect){(i - 1) * self.imagesScrollView.bounds.size.width,0,self.imagesScrollView.bounds.size}];
        [imagescroll setContentWithFrame:convertRect];
        [imagescroll setImage:imageView.image];
        [self.imagesScrollView addSubview:imagescroll];
        imagescroll.tapDelegate = (id<ImageScrollViewDelegate>)controller;
        [imagescroll setAnimationRect];
    }
}

- (void)setOriginFrame:(ImageScrollView *)sender {
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentIndex,self.totalPage];
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        self.markView.alpha = 1.0;
    }];
}

#pragma mark - ImageScrollViewDelegate

- (void)tapImageViewWithObject:(ImageScrollView *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.markView.alpha = 0;
        [sender rechangeInitRdct];
    } completion:^(BOOL finished) {
        self.scrollPanel.alpha = 0;
    }];
}


@end
