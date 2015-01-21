//
//  registerViewController.m
//  SZGH
//
//  Created by lihongliang on 15/1/17.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "registerViewController.h"
#import "navbarView.h"
#import "SearchJobViewController.h"
@interface registerViewController ()

@end

@implementation registerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"注册";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self setNavBar];
}
-(void)searchButtonclick
{

    SearchJobViewController*v=[[SearchJobViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
    

}

-(void)setNavBar
{
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"详细01"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backNavBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)backNavBar
{
    SLog(@"点击了返回按钮!");
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
