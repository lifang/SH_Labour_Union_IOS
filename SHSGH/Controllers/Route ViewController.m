//
//  Route ViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "Route ViewController.h"
#import "navbarView.h"

@interface Route_ViewController ()

@end

@implementation Route_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"查看路线";
    _gryarry=[NSArray arrayWithObjects:@"bus_Gray",@"taxi_Gray",@"walk_Gray", nil];
    _hightarry=[NSArray arrayWithObjects:@"bus-1",@"taxi",@"walk", nil];

    // Do any additional setup after loading the view.
    [ self setnavBar];
    [ self setNavBar];
    [self createui];
    
}



-(void)createui
{
       UIView*backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    backview.backgroundColor=[UIColor whiteColor];
    
    
    [self.view addSubview:backview];
    
    UIImageView *logoimageview1 = [[UIImageView alloc]init];
    
    logoimageview1.frame = CGRectMake(10, 5, 20, 20);
    logoimageview1.image=[UIImage imageNamed:@"location"];
    
    [backview addSubview:logoimageview1];
    
    UIImageView *logoimageview2 = [[UIImageView alloc]init];
    
    logoimageview2.frame = CGRectMake(18, 31, 5, 26);
    logoimageview2.image=[UIImage imageNamed:@"roadLine"];
    
    [backview addSubview:logoimageview2];
    
    
    
    
    UIImageView *rightimage = [[UIImageView alloc]init];
    
    rightimage.frame = CGRectMake(SCREEN_WIDTH-40, 30, 20, 30);
    rightimage.image=[UIImage imageNamed:@"luxian"];
    
    [backview addSubview:rightimage];

    
    UIImageView *logoimageview3 = [[UIImageView alloc]init];
    
    logoimageview3.frame = CGRectMake(13, 68, 15, 15);
    logoimageview3.image=[UIImage imageNamed:@"cicle"];
    
    [backview addSubview:logoimageview3];
    
    
    
    UILabel*namelab=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 30)];
    [backview addSubview:namelab];
    namelab.text=@"我的位置";
    namelab.font=[UIFont systemFontOfSize:15];
    
    UIImageView *myimage = [[UIImageView alloc]init];
    
    myimage.frame = CGRectMake(110, 10, 16, 10);
    myimage.image=[UIImage imageNamed:@"unwind_Gray"];
    
    [backview addSubview:myimage];
    
    
    
    
    UILabel*addresslab=[[UILabel alloc]initWithFrame:CGRectMake(40, 60, 140, 30)];
    [backview addSubview:addresslab];
    
    addresslab.text=@"学而好机构";
    addresslab.textColor=[UIColor grayColor];
    addresslab.font=[UIFont systemFontOfSize:15];

    
    _seletedIndex=1;
    
    
    for(NSInteger i=0;i<3;i++)
    {
    
        UIButton*addrbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        addrbutton.tag=i+1;
        
        if(i==0)
        {
            [addrbutton setImage:[UIImage imageNamed:[_hightarry objectAtIndex:0]] forState:UIControlStateNormal];

        
        }
        else
        {
            [addrbutton setImage:[UIImage imageNamed:[_gryarry objectAtIndex:i]] forState:UIControlStateNormal];

        }
        addrbutton.frame=CGRectMake((i+1)*SCREEN_WIDTH/4-15,90 ,30, 30);
        
        

//         [addrbutton setBackgroundImage:[UIImage imageNamed:[_gryarry objectAtIndex:i]] forState:UIControlStateNormal];
        [addrbutton addTarget:self action:@selector(luxianclicks:) forControlEvents:UIControlEventTouchUpInside];
        
        [backview addSubview:addrbutton];
        
        
       
      

    
    
    }
    
}
-(void)luxianclicks:(UIButton*)send
{
    
    NSInteger current=send.tag;
    
    if (_seletedIndex == current) return;
    UIButton *previousButton = (UIButton *)[self.view viewWithTag:_seletedIndex ];

    [previousButton setImage:[UIImage imageNamed:[_gryarry objectAtIndex:_seletedIndex-1]] forState:UIControlStateNormal];
    _seletedIndex=current;
    UIButton *currentButton = (UIButton *)[self.view viewWithTag:(current )];
    [currentButton setImage:[UIImage imageNamed:[_hightarry objectAtIndex:current-1]] forState:UIControlStateNormal];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
