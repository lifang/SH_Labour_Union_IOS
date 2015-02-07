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

@interface MainViewController : UIViewController
{NSTimer*_scrollcententtimer;
    
    
    UILabel*lab;
    UILabel*lab1;
    UILabel*lab2;
    int k;  int j;
    int m;
    int n;
    
    int w;
    UIImageView*vieiamge;
    
    int i;
    
}
@property(nonatomic,strong)SUNViewController *drawerController;

@end