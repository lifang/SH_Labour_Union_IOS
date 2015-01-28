//
//  DetalsocialViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DetalsocialViewController.h"
#import "navbarView.h"
@interface DetalsocialViewController ()

@end

@implementation DetalsocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=self.titles;
    
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(110, 0, 0);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(110, 0, 0);
        
        
    }

    

    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView*requirecontent=[[UIWebView alloc]init];
    
    [requirecontent loadHTMLString:self.contentstring baseURL:nil];
    
    //        simpleintroducetlable.numberOfLines=0;
    [requirecontent sizeToFit];
    
    if(iOS7)
    {
        requirecontent.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT-80);
        
    }
    else
    {
        requirecontent.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT);
        

    
    }
//    requirecontent.textColor=[UIColor grayColor];
    [self.view addSubview:requirecontent];
//    requirecontent.text=self.contentstring;
    NSLog(@"=======%@",self.contentstring);
//    requirecontent.numberOfLines=0;

    
    
   [requirecontent sizeToFit];
    
    
    [ self setnavBar];
    [ self setNavBar];
}
 -(void)setNavBar
    {
        
        navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
        [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
        [buttonL.navButton addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
        self.navigationItem.leftBarButtonItem = leftItem;
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
