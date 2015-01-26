//
//  AppDelegate.h
//  SHSGH
//
//  Created by lihongliang on 15/1/19.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNLeftMenuViewController.h"
#import "SUNViewController.h"
#import "MMDrawerVisualState.h"
#import "MainViewController.h"
#import "dynamicViewController.h"
#import "SearchJobViewController.h"
#import "RelatedViewController.h"
#import "MaintainViewController.h"
#import "TradeViewController.h"

#import "OrganizationViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)SUNLeftMenuViewController *leftVC;

@property(nonatomic,strong)SUNViewController *DrawerController;

+ (AppDelegate *)shareAppDelegate;

- (SUNLeftMenuViewController *)leftVC;
+(UINavigationController *)shareDynamicController4;

+ (UINavigationController *)shareMainController;
+ (UINavigationController *)shareMaintainController;
+(UINavigationController *)shareDynamicController2;

+ (UINavigationController *)shareDynamicController;
+ (UINavigationController *)shareDynamicController3;
+ (UINavigationController *)shareDynamicController6;

@end

