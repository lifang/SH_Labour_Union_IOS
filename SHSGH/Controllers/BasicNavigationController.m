//
//  BasicNavigationController.m
//  SZGH
//
//  Created by lihongliang on 15/1/17.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "BasicNavigationController.h"

@implementation BasicNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
   
        viewController.navigationItem.leftBarButtonItem = [self costomLeftBackButton];
}

-(UIBarButtonItem *)costomLeftBackButton
{
    UIImage *image = [UIImage imageNamed:@"详细01"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 12, 22);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    return backItem;
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

@end
