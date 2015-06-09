//
//  DetalsocialViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DetalsocialViewController.h"
#import "navbarView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@interface DetalsocialViewController ()

@end

@implementation DetalsocialViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
   
    
}

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
    
    if(self.a==5)
    {
    
        
        
     
        NSURL *url = [NSURL URLWithString:@"http://www.sh12351.org"];
//        NSString *str1 = [NSString stringWithFormat:@"<h4 align='left'>%@</h4><hr />",_topLabelStr];
//        NSString *str2 = [NSString stringWithFormat:@"%@%@",str1,_contentStr];
//        [webView loadHTMLString:str2 baseURL:url];
//        
        
        
        
        
        
        
        
        
        
        
        UIWebView*requirecontent=[[UIWebView alloc]init];
        requirecontent.backgroundColor=[UIColor whiteColor];
        
        [requirecontent loadHTMLString:self.contentstring baseURL:url];
        
        //        simpleintroducetlable.numberOfLines=0;
        [requirecontent sizeToFit];
        
      
            requirecontent.frame=CGRectMake(0, 0, SCREEN_WIDTH-0, SCREEN_HEIGHT-64);
            
       
        [self.view addSubview:requirecontent];
        //    requirecontent.text=self.contentstring;
        
        
        
        [requirecontent sizeToFit];

    
    
    }
    else
    {
        
        UIScrollView*imagescro=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        
        [self.view addSubview:imagescro];
//        NSInteger imageheight;
        
//        if(SCREEN_HEIGHT>480)
//        {
//            imageheight=20;
//            
//        
//        }
//        else
//        {
//            imageheight=20;
//
//        
//        
//        }
        UIImage*sizeimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.contentstring]]];
        

        UIImageView*iamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sizeimage.size.height)];
        
        imagescro.contentSize=CGSizeMake(SCREEN_WIDTH, sizeimage.size.height+60);

        iamge.center=CGPointMake(SCREEN_WIDTH/2, sizeimage.size.height/2);
        
        [imagescro addSubview:iamge];
       iamge.contentMode = UIViewContentModeScaleAspectFit;
//        NSLog(@"%@",self.contentstring);
        
        [iamge  sd_setImageWithURL:[NSURL URLWithString:self.contentstring] placeholderImage:[UIImage imageNamed:@"餐饮(1)"]];
        

    
    
    }
    
    
    [ self setnavBar];
    [ self setNavBar];
}
 -(void)setNavBar
    {
        
        navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
        [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
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
