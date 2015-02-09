//
//  Constants.h
//  SHSGH
//
//  Created by lihongliang on 15/1/19.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

//NSLog宏
#ifdef DEBUG //测试状态,打开LOG功能
#define SLog(...) NSLog(__VA_ARGS__)
#else //发布状态，关闭LOG功能
#define SLog(...)
#endif

#define MAIN_URL @"http://192.168.0.250:7070/shanghaiunion"
#define mainFont [UIFont systemFontOfSize:15]
//机器的版本号
#define sDeviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//调R.G.B色
#define sColor(r,g,b,a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

//颜色
#define HHZColor(r, g ,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define mainScreenColor sColor(236,236,236,1.0)

//随机色
#define RandomColor sColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1.0)

//屏幕的宽度
#define mainScreenW [UIScreen mainScreen].bounds.size.width

//屏幕的高度
#define mainScreenH [UIScreen mainScreen].bounds.size.height

//view的宽度
#define mainViewW self.bounds.size.width

//view的高度
#define mainViewH self.bounds.size.height

//状态栏的高度
#define statusBarH 20

//自定义View间距
#define CostumViewMargin 4

//中间模块列数
#define liltleColumnCount 3

//下方模块列数
#define bigColumnCount 2

//左边侧边栏宽度
#define kPublicLeftMenuWidth 180.0f