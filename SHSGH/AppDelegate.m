//
//  AppDelegate.m
//  SHSGH
//
//  Created by lihongliang on 15/1/19.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "AppDelegate.h"

static MainViewController  *mainController = nil;
static UINavigationController *mainNavController = nil;

static dynamicViewController  *dynamicController = nil;
static UINavigationController *dynamicNavController = nil;

static SearchJobViewController  *searchController = nil;
static UINavigationController *searchNavController = nil;

static RelatedViewController  *relatedController = nil;
static UINavigationController *relatedNavController = nil;


static  OrganizationViewController *OrganizationController = nil;
static UINavigationController *OrganizationNavController = nil;

static  TradeViewController *TradeController = nil;
static UINavigationController *TradeNavController = nil;


static MaintainViewController  *maintainController = nil;
static UINavigationController *maintainNavController = nil;

static HealthyHomeViewController  *healthyController = nil;
static UINavigationController *healthyNayController = nil;

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)dealloc
{
    if (mainNavController) {
        mainNavController = nil;
        mainController = nil;
    }
    
    if (dynamicNavController) {
        dynamicNavController = nil;
        dynamicController = nil;
    }
    
    if (searchNavController) {
        searchNavController = nil;
        searchController = nil;
    }
    
    if (relatedNavController) {
        relatedNavController = nil;
        relatedController = nil;
    }
    
    if (maintainNavController) {
        maintainNavController = nil;
        maintainController = nil;
    }
}

+ (AppDelegate *)shareAppDelegate;
{
    return [UIApplication sharedApplication].delegate;
    
}

-(SUNLeftMenuViewController *)leftVC
{
    return _leftVC;
}

//首页
+(UINavigationController *)shareMainController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainController = [[MainViewController alloc] init];
        mainNavController = [[UINavigationController alloc] initWithRootViewController:mainController];
    });
    return mainNavController;
}

// 相关查询
+(UINavigationController *)shareDynamicController6{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        relatedController = [[RelatedViewController alloc] init];
        relatedNavController = [[UINavigationController alloc] initWithRootViewController:relatedController];
    });
    return relatedNavController;
}
// 机构查询

+(UINavigationController *)shareDynamicController2{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        OrganizationController = [[OrganizationViewController alloc] init];
        OrganizationNavController = [[UINavigationController alloc] initWithRootViewController:OrganizationController];
    });
    return OrganizationNavController;
}

// 商户查询

+(UINavigationController *)shareDynamicController4{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TradeController = [[TradeViewController alloc] init];
        TradeNavController = [[UINavigationController alloc] initWithRootViewController:TradeController];
    });
    return TradeNavController;
}
// 岗位查询

+(UINavigationController *)shareDynamicController3{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        searchController = [[SearchJobViewController alloc] init];
        searchNavController = [[UINavigationController alloc] initWithRootViewController:searchController];
    });
    return searchNavController;
}

//动态
+(UINavigationController *)shareDynamicController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dynamicController = [[dynamicViewController alloc] init];
        dynamicNavController = [[UINavigationController alloc] initWithRootViewController:dynamicController];
    });
    return dynamicNavController;
}
//维权
+(UINavigationController *)shareMaintainController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        maintainController = [[MaintainViewController alloc] init];
        maintainNavController = [[UINavigationController alloc] initWithRootViewController:maintainController];
    });
    return maintainNavController;
}
//健康
+(UINavigationController *)shareHealthtController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        healthyController = [[HealthyHomeViewController alloc] init];
        healthyNayController = [[UINavigationController alloc] initWithRootViewController:healthyController];
    });
    return healthyNayController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"uMViGm2ikM1DaHXlGnR8bQze"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    SUNLeftMenuViewController *leftVC = [[SUNLeftMenuViewController alloc]initWithNibName:@"SUNLeftMenuViewController" bundle:nil];
    UINavigationController *mainViewController = [[self class] shareMainController];
    SUNViewController *drawerController = [[SUNViewController alloc]initWithCenterViewController:mainViewController leftDrawerViewController:leftVC rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController,drawerSide,percentVisible);
    }];
    
    
    
    self.window.rootViewController = drawerController;
    self.DrawerController = drawerController;
    [self.window makeKeyAndVisible];
    NSLog(@"%@",NSHomeDirectory());
    return YES;
}

-(void)clearLoginInfo
{
    self.userId = nil;
    self.username = nil;
    self.password = nil;
    self.userId = nil;
    self.labourUnionCode = nil;
    self.email = nil;
    self.phoneCode = nil;
    self.userIDName = nil;
    self.token = nil;
    UserModel *user = [UserTool userModel];
    user.password = nil;
    user.token = nil;
    [UserTool save:user];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
