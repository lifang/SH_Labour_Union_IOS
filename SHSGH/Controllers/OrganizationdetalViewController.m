//
//  OrganizationdetalViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "OrganizationdetalViewController.h"
#import "navbarView.h"
@interface OrganizationdetalViewController ()

@end

@implementation OrganizationdetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"机构详情";
    [self   createui];
    
    _scrollcententtimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollcententtimerhandle) userInfo:nil repeats:YES];

    
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
    
    [ self setnavBar];
    [ self setNavBar];
}
-(void)createui
{
  
        bigscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    [self.view addSubview:bigscroll];
    


    _scrool=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [bigscroll addSubview:_scrool];
    _scrool.contentSize=CGSizeMake(3*SCREEN_WIDTH, 0);
    
    _scrool.alwaysBounceHorizontal=YES;
    _scrool.showsHorizontalScrollIndicator=NO;
    _scrool.pagingEnabled=YES;
    _move = _scrool.frame.size.width;
    
    _scrool.contentOffset = CGPointMake(0, 0);
    
    _scrool.delegate = self;
    
    
    for (int i = 0 ; i < 3 ; i ++ )
    {
        UIImageView *imageview = [[UIImageView alloc]init];
//        NSString*urlstring= [NSString stringWithFormat:@"%@%@",myimages, [arrry objectAtIndex:i]];
//        [imageview sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"餐饮(1)"]];
//        //
        
        [imageview setContentMode:UIViewContentModeScaleAspectFill];
        
       imageview.image=[UIImage imageNamed:@"btn-l"];
        
        imageview.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 200);
        
        [_scrool addSubview:imageview];
        
        
        
    }
    
    
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30,162, 60, 30)];
    
    _page.currentPageIndicatorTintColor=[UIColor redColor];
//    _page.pageIndicatorTintColor=[UIColor whiteColor];
    _page.numberOfPages =3;
    
    [bigscroll addSubview:_page];
    UILabel*namelable=[[UILabel alloc]init];
    
    
    
    namelable.frame=CGRectMake(10, _scrool.frame.size.height+_scrool.frame.origin.y, SCREEN_WIDTH-20, 30);
    namelable.font=[UIFont systemFontOfSize:15];
    //    requirecontent.textColor=[UIColor grayColor];
    namelable.numberOfLines=0;
    [bigscroll addSubview:namelable];
    namelable.text=@"任职要求：都刚好合";
    
    
    UILabel*timelable=[[UILabel alloc]init];
     timelable.frame=CGRectMake(10, namelable.frame.size.height+namelable.frame.origin.y, SCREEN_WIDTH-20, 20);
    
    timelable.font=[UIFont systemFontOfSize:15];
    timelable.textColor=[UIColor grayColor];
    timelable.numberOfLines=0;
    [bigscroll addSubview:timelable];
    timelable.text=@"08:22-12:58";
    
   
    UILabel*phonelable=[[UILabel alloc]init];
    phonelable.frame=CGRectMake(10, timelable.frame.size.height+timelable.frame.origin.y, SCREEN_WIDTH-60, 20);
 
    phonelable.font=[UIFont systemFontOfSize:15];
    phonelable.textColor=[UIColor grayColor];
    phonelable.numberOfLines=0;
    [bigscroll addSubview:phonelable];
    phonelable.text=@"153124587944";

    UIButton*phonebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    phonebutton.frame=CGRectMake( SCREEN_WIDTH-60, timelable.frame.size.height+timelable.frame.origin.y-5,25, 25);
    [phonebutton setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
    [phonebutton addTarget:self action:@selector(callclick) forControlEvents:UIControlEventTouchUpInside];

   [bigscroll addSubview:phonebutton];
    
    
    

    UILabel*linelable1=[[UILabel alloc]init];
    linelable1.frame=CGRectMake(0, phonelable.frame.size.height+phonelable.frame.origin.y+6, SCREEN_WIDTH, 1);
    linelable1.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    [bigscroll addSubview:linelable1];
    
    
    
    UIButton*addressbutton=[[UIButton alloc] initWithFrame:CGRectMake(0, linelable1.frame.origin.y+10,SCREEN_WIDTH, 30)];
    
    [bigscroll addSubview:addressbutton];
    addressbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   [addressbutton setTitle:@"      大概IDG热的分割肉kjkli" forState:UIControlStateNormal];
    [addressbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
    UIImageView *nextimageview = [[UIImageView alloc]init];
    
    nextimageview.frame = CGRectMake(SCREEN_WIDTH-40, linelable1.frame.size.height+linelable1.frame.origin.y+13, 15, 20);
    nextimageview.image=[UIImage imageNamed:@"particular_Gray"];
    
    [bigscroll addSubview:nextimageview];
    

    
    
    UIImageView *dituimageview = [[UIImageView alloc]init];
    
    dituimageview.frame = CGRectMake(10, 0, 20, 20);
    dituimageview.image=[UIImage imageNamed:@"particular_Gray"];
    
    [addressbutton addSubview:dituimageview];

    
    
    UILabel*linelable2=[[UILabel alloc]init];
    linelable2.frame=CGRectMake(0, addressbutton.frame.size.height+addressbutton.frame.origin.y+10, SCREEN_WIDTH, 1);
    linelable2.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    [bigscroll addSubview:linelable2];
    

    
    
    UIImageView *llogoimageview = [[UIImageView alloc]init];
    
    llogoimageview.frame = CGRectMake(10, linelable2.frame.size.height+linelable2.frame.origin.y+10, 25, 20);
    llogoimageview.image=[UIImage imageNamed:@"structure"];
    
    [bigscroll addSubview:llogoimageview];
    

    
    
    
    UILabel*llogolable=[[UILabel alloc]init];
    llogolable.frame=CGRectMake(40, linelable2.frame.size.height+linelable2.frame.origin.y+5, SCREEN_WIDTH-50, 30);
    
    llogolable.font=[UIFont systemFontOfSize:15];
    //    requirecontent.textColor=[UIColor grayColor];
    llogolable.numberOfLines=0;
    [bigscroll addSubview:llogolable];
    llogolable.text=@"大概IDG热的分割肉";
    
    
    
    UILabel*linelable3=[[UILabel alloc]init];
    linelable3.frame=CGRectMake(0, llogolable.frame.size.height+llogolable.frame.origin.y+10, SCREEN_WIDTH, 1);
    linelable3.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    [bigscroll addSubview:linelable3];
    
    
    UILabel*requirecontent=[[UILabel alloc]init];
    requirecontent.frame=CGRectMake(10, linelable3.frame.size.height+linelable3.frame.origin.y+3, SCREEN_WIDTH-20, 30);
    requirecontent.font=[UIFont systemFontOfSize:15];
    requirecontent.textColor=[UIColor grayColor];
    requirecontent.numberOfLines=0;
    [bigscroll addSubview:requirecontent];
    requirecontent.text=@"任职要求：都刚好合适的话他还是身体是他说他是如何谁认识他是搞糊涂人士同时也会是符合人体还是事故发生突然";
    
    [requirecontent sizeToFit];
    


    bigscroll.contentSize=CGSizeMake(0, requirecontent.frame.size.height+requirecontent.frame.origin.y+50);



}
-(void)callclick
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    
    
    NSString*phone=@"110";
    
    
    
    
    
    NSString *telUrl = [NSString stringWithFormat:@"tel:%@",phone];
    
    
    
    
    NSURL *telURL =[NSURL URLWithString:telUrl];// 貌似tel:// 或者 tel: 都行
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    //记得添加到view上
    
    [self.view addSubview:callWebview];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int page;
    page = _scrool.contentOffset.x/_scrool.frame.size.width;
    _page.currentPage = page;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page;
    page = _scrool.contentOffset.x/_scrool.frame.size.width;
    _page.currentPage = page;
}
-(void)scrollcententtimerhandle
{
    
    if (_scrool.contentOffset.x >=( _scrool.frame.size.width*(3-1))) {
        [_scrool setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [_scrool setContentOffset:CGPointMake(_scrool.contentOffset.x + _move, 0) animated:YES];
    }
    int page;
    page = _scrool.contentOffset.x/_scrool.frame.size.width ;
    _page.currentPage = page;
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