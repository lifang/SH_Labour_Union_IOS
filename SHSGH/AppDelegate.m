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
static SearchJobViewController  *searchController = nil;

static RelatedViewController  *relatedController = nil;
static UINavigationController *dynamicNavController = nil;
static UINavigationController *searchNavController = nil;
static UINavigationController *relatedNavController = nil;
@interface AppDelegate ()

@end

@implementation AppDelegate

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

//动态

+(UINavigationController *)shareDynamicController6{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        relatedController = [[RelatedViewController alloc] init];
        relatedNavController = [[UINavigationController alloc] initWithRootViewController:relatedController];
    });
    return relatedNavController;
}


+(UINavigationController *)shareDynamicController3{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        searchController = [[SearchJobViewController alloc] init];
        searchNavController = [[UINavigationController alloc] initWithRootViewController:searchController];
    });
    return searchNavController;
}
+(UINavigationController *)shareDynamicController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dynamicController = [[dynamicViewController alloc] init];
        dynamicNavController = [[UINavigationController alloc] initWithRootViewController:dynamicController];
    });
    return dynamicNavController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
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
