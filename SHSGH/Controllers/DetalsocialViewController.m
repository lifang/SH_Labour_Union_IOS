//
//  DetalsocialViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DetalsocialViewController.h"

@interface DetalsocialViewController ()

@end

@implementation DetalsocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"《社会保障法》";
    
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(99, 27, 28);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(99, 27, 28);
        
        
    }

    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    
    
    gobackbut.bounds = CGRectMake(0, 0, 20, 25);
    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
    
    self.navigationItem.leftBarButtonItem = leftItem;

    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel*conlable=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:conlable];
    [ self setnavBar];
    
    
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
