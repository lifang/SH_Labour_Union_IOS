//
//  RootViewController.h
//  SZGH
//
//  Created by lihongliang on 15/1/14.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BasicNavigationController;
@interface RootViewController : UIViewController

@property (nonatomic, strong) UINavigationController *loginNav;

@property (nonatomic, strong) UINavigationController *mainNav;

-(void)showMainViewController;

@end
