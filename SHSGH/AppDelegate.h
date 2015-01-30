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
#import "BMapKit.h"
#import "OrganizationViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
    
    
}
@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)SUNLeftMenuViewController *leftVC;

@property(nonatomic,strong)SUNViewController *DrawerController;

@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *labourUnionCode;
@property(nonatomic,strong)NSString *phoneCode;


+ (AppDelegate *)shareAppDelegate;

- (SUNLeftMenuViewController *)leftVC;
+(UINavigationController *)shareDynamicController4;

+ (UINavigationController *)shareMainController;
+ (UINavigationController *)shareMaintainController;
+(UINavigationController *)shareDynamicController2;

+ (UINavigationController *)shareDynamicController;
+ (UINavigationController *)shareDynamicController3;
+ (UINavigationController *)shareDynamicController6;

-(void)clearLoginInfo;

@end

