//
//  SUNSlideSwitchDemoViewController.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNSlideSwitchDemoViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "SUNListViewController.h"
#import "SUNSlideSwitchView.h"
#import "navbarView.h"
#import "MainViewController.h"

@interface SUNSlideSwitchDemoViewController ()

@end

@implementation SUNSlideSwitchDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //设置导航栏
    [self setnavBar];

    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    self.vc1 = [[SUNListViewController alloc] init];
    self.vc1.title = @"最新动态";
    
    self.vc2 = [[SUNListViewController alloc] init];
    self.vc2.title = @"维权查询";
    
    self.vc3 = [[SUNListViewController alloc] init];
    self.vc3.title = @"机构查询";
    
    self.vc4 = [[SUNListViewController alloc] init];
    self.vc4.title = @"岗位查询";
    
    self.vc5 = [[SUNListViewController alloc] init];
    self.vc5.title = @"商户查询";
    
    self.vc6 = [[SUNListViewController alloc] init];
    self.vc6.title = @"健康服务";
    
    self.vc7 = [[SUNListViewController alloc] init];
    self.vc7.title = @"相关查询";
    
    self.vc8 = [[SUNListViewController alloc] init];
    self.vc8.title = @"相关下载";
    
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    [self.slideSwitchView buildUI];
    
    [self pushTopbar];
    
}

-(void)setnavBar
{
    self.title = @"首页";
    //设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"head_bg01"] forBarMetrics:UIBarMetricsDefault];
    
    //设置左边按钮
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setBackgroundImage:[UIImage imageNamed:@"搜索记录"] forState:UIControlStateNormal];
   [leftView.navButton addTarget:self action:@selector(leftViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    navbarView *rightView = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [rightView.navButton setBackgroundImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    [self.navigationItem setLeftBarButtonItem:leftBarbutton];
    [self.navigationItem setRightBarButtonItem:rightBarbutton];
}

-(void)leftViewClick
{
    SLog(@"leftViewClick---------");
    MainViewController *mainVC = [[MainViewController alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setRootViewController:mainVC];
    [window makeKeyAndVisible];
}

-(void)pushTopbar
{
    switch (self.sign) {
        case 2:
        {
        UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 3:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 4:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 5:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 6:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 7:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        case 8:
        {
            UIButton *button = (UIButton *)self.slideSwitchView.topScrollView.subviews[self.sign];
            [UIView animateWithDuration:0.4 animations:^{
                [self.slideSwitchView selectNameButton:button];
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 8;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    } else if (number == 6) {
        return self.vc7;
    } else if (number == 7) {
        return self.vc8;
    } else {
        return nil;
    }
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    [drawerController panGestureCallback:panParam];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    SUNListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    } else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
    } else if (number == 4) {
        vc = self.vc5;
    } else if (number == 5) {
        vc = self.vc6;
    }else if (number == 6) {
        vc = self.vc7;
    } else if (number == 7) {
        vc =  self.vc8;
    }
    [vc viewDidCurrentView];
}

#pragma mark - 内存报警

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
