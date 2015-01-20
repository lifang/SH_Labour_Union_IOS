//
//  RootViewController.m
//  SZGH
//
//  Created by lihongliang on 15/1/14.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "RootViewController.h"
#import "loginViewController.h"
#import "MainViewController.h"
#import "BasicNavigationController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self showMainViewController];
}


-(void)showLoginViewController
{
    if (!_loginNav) {
    loginViewController *loginC = [[loginViewController alloc]init];
    _loginNav = [[UINavigationController alloc]initWithRootViewController:loginC];
    _loginNav.view.frame = self.view.bounds;
    [_loginNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"head_bg01"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:_loginNav.view];
    
    NSDictionary *textDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIColor blackColor],NSForegroundColorAttributeName,
                              nil];
    _loginNav.navigationBar.titleTextAttributes = textDict;
    _loginNav.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    loginC.navigationItem.backBarButtonItem = backItem;
    }
    [UIView animateWithDuration:.5 animations:^{
        if (_mainNav) {
            [_mainNav.view removeFromSuperview];
            _mainNav = nil;
        }
        [self.view bringSubviewToFront:_loginNav.view];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    }];
}

-(void)showMainViewController{
    if (!_mainNav) {
        SLog(@"showMainViewController");
        MainViewController *mainC = [[MainViewController alloc]init];
        _mainNav = [[UINavigationController alloc]initWithRootViewController:mainC];
        _mainNav.view.frame = self.view.bounds;
        [_mainNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"head_bg"] forBarMetrics:UIBarMetricsDefault];
        [self.view addSubview:_mainNav.view];
    }

    if (_loginNav) {
        [_loginNav.view removeFromSuperview];
        _loginNav = nil;
    }
    [self.view bringSubviewToFront:_mainNav.view];
}


@end
