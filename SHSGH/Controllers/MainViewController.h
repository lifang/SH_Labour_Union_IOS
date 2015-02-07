//
//  MainViewController.h
//  SZGH
//
//  Created by lihongliang on 15/1/14.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNViewController.h"
#import "dynamicViewController.h"
#import "ImageScrollView.h"

static float topSpace = 15.f;
static float leftSpace = 15.f;
static float rightSpace = 15.f;
static float imageScale = 0.59f;  //图片高宽比

@interface MainViewController : UIViewController

@property(nonatomic,strong)SUNViewController *drawerController;
//点击看大图
@property (nonatomic, strong) UIScrollView *imagesScrollView;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UIView *scrollPanel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, strong) UILabel *pageLabel;

- (void)initAndLayoutUI;

- (void)addImageScrollViewForController:(UIViewController *)controller;

- (void)setOriginFrame:(ImageScrollView *)sender;
@end