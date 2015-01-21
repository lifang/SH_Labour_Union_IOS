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
#import "SUNViewController.h"
#import "AppDelegate.h"
#import "dynamicViewController.h"

@interface MainViewController ()<ReuseViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建自定义布局
    [self setupCustomView];
}

-(void)setupCustomView
{
    //创建topView
    UIButton *topView = [[UIButton alloc]init];
    [topView setBackgroundImage:[UIImage imageNamed:@"topView"] forState:UIControlStateNormal];
    [topView setBackgroundImage:[UIImage imageNamed:@"topView"] forState:UIControlStateHighlighted];
    CGFloat topViewX = 0;
    CGFloat topViewY = statusBarH;
    CGFloat topViewW = self.view.frame.size.width;
    CGFloat topViewH = 60;
    //适配4s
    if (mainScreenH <= 480) {
        topViewH = 40;
    }
    topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    //创建ScrollView
    NSString *url1 = @"http://picapi.ooopic.com/10/50/15/28b1OOOPICca.jpg";
    NSString *url2 = @"http://picapi.ooopic.com/10/58/70/26b1OOOPIC32.jpg";
    NSString *url3 = @"http://pic15.nipic.com/20110708/7921523_163228302177_2.jpg";
    NSString *url4 = @"http://www.zhituad.com/photo2/10/55/23/14b1OOOPIC34.jpg";
    NSMutableArray *picArray = [NSMutableArray arrayWithObjects:url1,url2,url3,url4, nil];
    CGFloat scrollViewH = 100;
    if (mainScreenH <= 480) {
        scrollViewH = 80;
    }
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0,topViewY + topViewH + CostumViewMargin, mainScreenW, scrollViewH) array:picArray];
    CGFloat scrollViewY = topViewY + topViewH + CostumViewMargin;
    scrollView.reuseDelegate = self;
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
    CGFloat imageViewX = mainScreenW / 2 - imageViewW / 2 + CostumViewMargin;
    CGFloat imageViewY = CostumViewMargin * 2;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [bottomView addSubview:imageView];
    
    UILabel *bottomL = [[UILabel alloc]init];
    bottomL.textAlignment = NSTextAlignmentCenter;
    bottomL.font = [UIFont boldSystemFontOfSize:17];
    bottomL.text = @"首页";
    bottomL.textColor = sColor(154, 12, 2, 1.0);
    CGFloat bottomLW = imageViewW + 10;
    CGFloat bottomLH = imageViewH;
    CGFloat bottomLX = imageViewX - 5;
    CGFloat bottomLY = imageViewY + imageViewH - CostumViewMargin;
    bottomL.frame = CGRectMake(bottomLX, bottomLY, bottomLW, bottomLH);
    [bottomView addSubview:bottomL];
    
    [self.view addSubview:bottomView];
    
    
    //创建中间的两排方格
    CGFloat centerViewW = (mainScreenW - 4 * CostumViewMargin)/3;
    CGFloat centerViewH = (mainScreenH - (topViewH + scrollViewH + statusBarH + 4 * CostumViewMargin)  - bottomViewH + 16)/3;
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
    NSLog(@"%ld",centerView.tag);
    switch (centerView.tag) {
        case 0:
            NSLog(@"点击了第一个按钮!");
            [self setHomeController];
            break;
        case 3:
            NSLog(@"点击了第一个按钮!");
            [self setHomeController];
            break;
        default:
            break;
    }
}

-(void)setHomeController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SUNLeftMenuViewController *leftVC = [[SUNLeftMenuViewController alloc]initWithNibName:@"SUNLeftMenuViewController" bundle:nil];
    dynamicViewController *dynamicVC = [[dynamicViewController alloc]init];
    UINavigationController *dynamicNav = [[UINavigationController alloc]initWithRootViewController:dynamicVC];
    SUNViewController *drawerController = [[SUNViewController alloc]initWithCenterViewController:dynamicNav leftDrawerViewController:leftVC rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController,drawerSide,percentVisible);
    }];
    
    [window setRootViewController:drawerController];
    [window makeKeyAndVisible];
}

#pragma mark - ScrollView didSelect
-(void)handleTop:(UITapGestureRecognizer *)imageView
{
    NSLog(@"点击了%@",imageView);
}

@end
