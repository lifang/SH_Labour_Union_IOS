//
//  RelatedViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "RelatedViewController.h"
#import "DetalsocialViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "NSString+FontAwesome.h"
#import "JObpp.h"
#import "PersonalViewController.h"
#import "PersonalDoneViewController.h"

@interface RelatedViewController ()

@end

@implementation RelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    changeint=798;
    ff=5;

    _isReloadingAllData = YES;
    _newallarry=[[NSMutableArray alloc]initWithCapacity:0];
 urls =@"/api/news/findLaws";
//    [self date];
    
    // Do any additional setup after loading the view.
    
    self.title=@"相关查询";
    [self setnavBar];
    [self createui];
    [self left];
    
    
    
    [self setupRefresh];
}

-(void)setupRefresh
{
    //下拉
    
    [_Seatchtable addHeaderWithTarget:self action:@selector(loadNewStatuses:) dateKey:@"table"];
    [_Seatchtable headerBeginRefreshing];
    //上拉
    [_Seatchtable addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _Seatchtable.headerPullToRefreshText = @"下拉可以刷新了";
    _Seatchtable.headerReleaseToRefreshText = @"松开马上刷新了";
    _Seatchtable.headerRefreshingText = @">.< 正在努力加载中!";
    
    _Seatchtable.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _Seatchtable.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _Seatchtable.footerRefreshingText = @">.< 正在努力加载中!";
    
}

//下拉刷新加载更多微博数据
-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    
    
    [_newallarry removeAllObjects];

    if( changeint==798)
    {
        
        
        urls =[NSString stringWithFormat:@"/api/news/findLaws?offset=%u",_newallarry.count/10+1];
        
    }
    
   else if(changeint==7980)
        
    {
        
        NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSString* urlsgg =[NSString stringWithFormat:@"/api/news/findLaws?title=%@&offset=%d",strUrll1,_newallarry.count/10+1];
        
        
        urls = [urlsgg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
    }
   else   if(changeint==7970)
   {
       NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];
       
       NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
       
       urls =[NSString stringWithFormat:@"/api/mutualAid/search?type=%ld&name=%@&offset=%d",(long)tuizaiA,strUrll1,_newallarry.count/10+1];
       
       
       
   }

    else
    {
    
     urls =[NSString stringWithFormat:@"/api/mutualAid/findAll?offset=%u",_newallarry.count/10+1];
    
    }

    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    _isReloadingAllData=YES;
    [self date];
    
    
    //    });
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    
    
    if( changeint==798)
    {
      
        
        urls =[NSString stringWithFormat:@"/api/news/findLaws?offset=%d",_newallarry.count/10+1];
    
    }
  else  if(changeint==7980)
      
    {
    
        NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
        NSString* urlsgg =[NSString stringWithFormat:@"/api/news/findLaws?title=%@&offset=%d",strUrll1,_newallarry.count/10+1];
        
        
        urls = [urlsgg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    
    
    }
 else   if(changeint==7970)
    {
        
        NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        

    
        urls =[NSString stringWithFormat:@"/api/mutualAid/search?type=%ld&name=%@&offset=%d",(long)tuizaiA,strUrll1,_newallarry.count/10+1];

    
    
    }
    else
    {
     urls =[NSString stringWithFormat:@"/api/mutualAid/findAll?offset=%u",_newallarry.count/10+1];
    
    
    }
    
    
    _isReloadingAllData=NO;
    
    if(_newallarry.count==totalCount)
    {
        [self showMessage:@"已经为您加载了全部数据亲" viewHeight:SCREEN_HEIGHT/2-80];
        [_Seatchtable footerEndRefreshing];
        [_helptable footerEndRefreshing];

        return;
        
    }

    
    if(_newallarry.count<totalCount)
    {
        [self date];
        
    }
    
  
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [_Seatchtable footerEndRefreshing];
    //
    //    });
}

-(void)createui
{
     //初始化UISegmentedControl 使用第三方 PPiFlatSegmentedControl
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStyleGrouped];
    
    _helptable=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStyleGrouped];
    [self.view addSubview:_helptable];
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=40;
    
    lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 30)];
    [self.view addSubview:lab];
    lab.text=@"暂无问卷";

    _helptable.delegate=self;
    _helptable.dataSource=self;
    _helptable.rowHeight=40;
    _helptable.hidden=YES;
    _Seatchtable.hidden=NO;
    lab.hidden=YES;

    lab.backgroundColor=[UIColor clearColor];
    lab.textAlignment=NSTextAlignmentCenter;
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];

        [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
         segmentedControl=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20,5,SCREEN_WIDTH-40,30) items:@[               @{@"text":@"法规查询",@"":@""},
                                                                                                                                                             @{@"text":@"互助保障",@"":@""},
                                                                                                                                                             @{@"text":@"问卷调查",@"":@""}
                                                                                                                                                             ]
                                                                                    iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex)
                                                   
                                                   {
                                                     
                                                       if(segmentIndex==0)
                                                       {
                                                           str4textfield=@"";
                                                           
                                                           changeint=798;
                                                           ff=5;
                                                           [_newallarry removeAllObjects];

                                                           urls =[NSString stringWithFormat:@"/api/news/findLaws?offset=%u",_newallarry.count/10+1];

                                                           
                                                           
                                                           _isReloadingAllData = YES;
                                                           
                                                           
                                                           [self date];

                                                           _Seatchtable.hidden=NO;
                                                           lab.hidden=YES;

                                                           _helptable.hidden=YES;

                                                       }
                                                       else if(segmentIndex==1)
                                                       {ff=9;
                                                           
                                                           str4textfield=@"";

                                                           
                                                           [_newallarry removeAllObjects];

                                                                changeint=790;
                                                           urls =[NSString stringWithFormat:@"/api/mutualAid/findAll?offset=%u",_newallarry.count/10+1];

                                                           
                                                           _isReloadingAllData = YES;
                                                           
                                                           [self   setupRefreshs];
                                                           
                                                           lab.hidden=YES;


                                                           _Seatchtable.hidden=YES;
                                                           _helptable.hidden=NO;

                                                       }
                                                       else
                                                       {
                                                           lab.hidden=NO;

                                                           
                                                           
                                                           _Seatchtable.hidden=YES;
                                                           _helptable.hidden=YES;

                                                           
                                                       }
                                                       

                                                   }];
        
    
    

   
    segmentedControl.color=[UIColor whiteColor];
    segmentedControl.borderWidth=0.5;
    segmentedControl.borderColor=[UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
    segmentedControl.selectedColor=[UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
    segmentedControl.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1]};
    segmentedControl.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmentedControl];
    
  
    

    
    
//    segmentedControl.tintColor= [UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
//    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
//    [segmentedControl setSelectedSegmentIndex:0];
//    segmentedControl.selectedItemColor   = [UIColor whiteColor];
//    segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
   
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
-(void)setupRefreshs
{
    //下拉
    
    [_helptable addHeaderWithTarget:self action:@selector(loadNewStatuses:) dateKey:@"table"];
    [_helptable headerBeginRefreshing];
    //上拉
    [_helptable addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _helptable.headerPullToRefreshText = @"下拉可以刷新了";
    _helptable.headerReleaseToRefreshText = @"松开马上刷新了";
    _helptable.headerRefreshingText = @">.< 正在努力加载中!";
    
    _helptable.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _helptable.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _helptable.footerRefreshingText = @">.< 正在努力加载中!";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSLog(@"tttt%d",_newallarry.count);
         return _newallarry.count;
  
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(_newallarry.count!=0)
    {
   
        JObpp*jobp=[_newallarry objectAtIndex:indexPath.row];
        
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@",jobp.jobname];
        

    
    }
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   if(tableView==_Seatchtable)
   {
    UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-80, 35)];
    [rootimageview addSubview:searchrootview];
    
    if(iOS7)
    {
        _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-120, 33)];
    }
    else
    {
        _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-120, 33)];
        
    }
    searchrootview.layer.cornerRadius=18;
    
    _searchfield.placeholder=@"请输入关键字 ";
       _searchfield.text= str4textfield;
    _searchfield.delegate=self;
    CALayer *layer=[searchrootview layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    
    //设置边框线的宽
    //
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
    [searchrootview addSubview:_searchfield];
    
    UIImageView*seariamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 25, 25)];
    [searchrootview addSubview: seariamgeview];
    seariamgeview.image=[UIImage imageNamed:@"search"];
    
    
    UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 8, 40, 30)];
    
    [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [searchButton setTitleColor:HHZColor(99, 27, 28) forState:UIControlStateNormal];
    searchButton.layer.cornerRadius=5;
    searchButton.layer.cornerRadius=5;
    
    [rootimageview addSubview:searchButton];
    
    CALayer *layers=[searchButton layer];
    //是否设置边框以及是否可见
    [layers setMasksToBounds:YES];
    //设置边框圆角的弧度
    
    //设置边框线的宽
    //
    [layers setBorderWidth:1];
    //设置边框线的颜色
    [layers setBorderColor:[[UIColor grayColor] CGColor]];
    searchButton.userInteractionEnabled=YES;
    
    [searchButton addTarget:self action:@selector(searchButtonclick) forControlEvents:UIControlEventTouchUpInside];
    return rootimageview;
    
   }
    else
    {
    
        UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        
        UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 35)];
        [rootimageview addSubview:searchrootview];
        
        if(iOS7)
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-80, 33)];
        }
        else
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-80, 33)];
            
        }
        searchrootview.layer.cornerRadius=18;
        _searchfield.text= str4textfield;

        _searchfield.placeholder=@"请输入关键字 ";
        _searchfield.delegate=self;
        CALayer *layer=[searchrootview layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        
        //设置边框线的宽
        //
        [layer setBorderWidth:1];
        //设置边框线的颜色
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        [searchrootview addSubview:_searchfield];
        
        UIImageView*seariamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 25, 25)];
        [searchrootview addSubview: seariamgeview];
        seariamgeview.image=[UIImage imageNamed:@"search"];
        
        
        UIButton*TuixiuButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-15, 50, 30, 30)];
        if(changeimage==YES)
        {
         [TuixiuButton setImage:[UIImage imageNamed:@"tuixiu"] forState:UIControlStateNormal];
        }
       else
       {
           [TuixiuButton setImage:[UIImage imageNamed:@"zaizhi"] forState:UIControlStateNormal];

       
       }
        
        
        [rootimageview addSubview:TuixiuButton];
        
        UILabel*tuixiulable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4+15, 50, 50, 30)];
        [rootimageview addSubview:tuixiulable];
        tuixiulable.backgroundColor=[UIColor clearColor];

 tuixiulable.text=@"退休";

        //        CALayer *layers=[searchButton layer];
        //        //是否设置边框以及是否可见
        //        [layers setMasksToBounds:YES];
        //        //设置边框圆角的弧度
        //
        //        //设置边框线的宽
        //        //
        //        [layers setBorderWidth:1];
        //        //设置边框线的颜色
        //        [layers setBorderColor:[[UIColor grayColor] CGColor]];
        TuixiuButton.userInteractionEnabled=YES;
        
        [TuixiuButton addTarget:self action:@selector(tuixiuButtonclick) forControlEvents:UIControlEventTouchUpInside];

        UIButton*zaizhiButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-SCREEN_WIDTH/4, 50, 30, 30)];
        
        if(changeimage==NO)
        {
            [zaizhiButton setImage:[UIImage imageNamed:@"tuixiu"] forState:UIControlStateNormal];
        }
        else
        {
            [zaizhiButton setImage:[UIImage imageNamed:@"zaizhi"] forState:UIControlStateNormal];
            
            
        }
        
        
        
        [rootimageview addSubview:zaizhiButton];
        UILabel*zaizhilable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30-SCREEN_WIDTH/4, 50, 40, 30)];
        [rootimageview addSubview:zaizhilable];
        zaizhilable.text=@"在职";
        zaizhilable.backgroundColor=[UIColor clearColor];

        //        CALayer *layers=[searchButton layer];
        //        //是否设置边框以及是否可见
        //        [layers setMasksToBounds:YES];
        //        //设置边框圆角的弧度
        //
        //        //设置边框线的宽
        //        //
        //        [layers setBorderWidth:1];
        //        //设置边框线的颜色
        //        [layers setBorderColor:[[UIColor grayColor] CGColor]];
        zaizhiButton.userInteractionEnabled=YES;
        
        [zaizhiButton addTarget:self action:@selector(zaizhiButtonclick) forControlEvents:UIControlEventTouchUpInside];
        

        
        
        
        
        
        
        UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH-40, 30)];
        
        [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
        
        searchButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        searchButton.backgroundColor=HHZColor(143, 20, 4);
        
        searchButton.layer.cornerRadius=5;
        
        [rootimageview addSubview:searchButton];
        
//        CALayer *layers=[searchButton layer];
//        //是否设置边框以及是否可见
//        [layers setMasksToBounds:YES];
//        //设置边框圆角的弧度
//        
//        //设置边框线的宽
//        //
//        [layers setBorderWidth:1];
//        //设置边框线的颜色
//        [layers setBorderColor:[[UIColor grayColor] CGColor]];
        searchButton.userInteractionEnabled=YES;
        
        [searchButton addTarget:self action:@selector(helpButtonclick) forControlEvents:UIControlEventTouchUpInside];
        return rootimageview;
    
    }

}
-(void)tuixiuButtonclick
{
    
    tuizaiA=0;
    changeimage=NO;
    [_helptable reloadData];
    
}
-(void)zaizhiButtonclick
{
    
    tuizaiA=1;
    changeimage=YES;
    [_helptable reloadData];

}
-(void)left
{
    
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"left_barbutton"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setImage:[UIImage imageNamed:@"user_white"]forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(toUser) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)toUser
{
    UserModel *account = [UserTool userModel];
    SLog(@"~~~~~~~~~~~~~~~~~~~~~~~~%@",account.password);
    if (account.password) {
        PersonalDoneViewController *personDoneVC = [[PersonalDoneViewController alloc]init];
        personDoneVC.userName = account.username;
        personDoneVC.userPasswd = account.password;
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.username = account.username;
        delegate.password = account.password;
        delegate.phone = account.phoneNum;
        delegate.email = account.email;
        delegate.labourUnionCode = account.LabourUnion;
        [self.navigationController pushViewController:personDoneVC animated:YES];
    }else{
        PersonalViewController *personVC = [[PersonalViewController alloc]init];
        //        self.dynamicNav = [AppDelegate shareDynamicController];
        [self.navigationController pushViewController:personVC animated:YES];
    }
}


-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)searchButtonclick
{
    
    
//    if([self isBlankString:_searchfield.text])
//    {
//        
//        [self showMessage:@"请填写关键字" viewHeight:SCREEN_HEIGHT/2-80];
//        
//        return;
//        
//        
//    }

    _isReloadingAllData = YES;
    changeint=7980;
    
    [_newallarry removeAllObjects];
    
    
    
    NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

   NSString* urlsgg =[NSString stringWithFormat:@"/api/news/findLaws?title=%@&offset=%d",strUrll1,_newallarry.count/10+1];
    
    
    urls = [urlsgg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    [self date];
    


}
-(void)helpButtonclick
{
    
    if([self isBlankString:_searchfield.text])
    {
    
        [self showMessage:@"请填写身份证号码" viewHeight:SCREEN_HEIGHT/2-80];

        return;
        
    
    }
     changeint=7970;
    [_newallarry removeAllObjects];
    _isReloadingAllData = YES;
    
    NSString*headerDatadgdgfgf= [str4textfield stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *strUrll1 = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    

       NSString* urlsgg =[NSString stringWithFormat:@"/api/mutualAid/search?type=%ld&name=%@&offset=%d",(long)tuizaiA,strUrll1,_newallarry.count/10+1];
    
    
    urls = [urlsgg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self date];
    
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;           // became first responder

{
    
    
    str4textfield=textField.text;
    
    
}
#pragma mark - 获取网络数据
-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
//        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        [params setObject:@"5" forKey:@"limit"];
        
//        if(changeint==798)
//        {
//
//            urls =[NSString stringWithFormat:@"/api/news/findLaws?offset=%u",1];
//
//        }
//        else
//        {
//            urls =[NSString stringWithFormat:@"/api/mutualAid/findAll?type=0?offset=%u",_newallarry.count/10+1];
//
//        }
        
//        NSString *strUrl = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        

        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
              NSLog(@"ppppppppp地对地导弹%@",result);
            [HUD removeFromSuperview];
            
            [_Seatchtable headerEndRefreshing];
            [_Seatchtable footerEndRefreshing];
            [_helptable headerEndRefreshing];
            [_helptable footerEndRefreshing];
            
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                if (_isReloadingAllData)
                    
                {
                    [_newallarry removeAllObjects];
                }
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    if(changeint==798||changeint==7980)
                    {peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"title"]];
                        NSLog(@"ppppppppp地对地导弹%@",peo.jobname);

                    
                    [_newallarry addObject:peo];
                    }else
                    {
                        peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                        peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"name"]];
                        
                        
                        [_newallarry addObject:peo];
                    
                    }
                    
                }
                totalCount = [[result  objectForKey:@"total"] integerValue];

                [_Seatchtable reloadData];
              
                [_helptable reloadData];
                
                if(_newallarry.count==totalCount)
                {
                    [self showMessage:@"已经为您加载了全部数据亲" viewHeight:SCREEN_HEIGHT/2-80];
                    
                    
                    
                }
                
            }
            else
            {
                NSString *reason = [result objectForKey:@"message"];
                if (![KRHttpUtil checkString:reason])
                {
                    reason = @"请求超时或者网络环境较差!";
                }

                    [self showMessage:reason viewHeight:SCREEN_HEIGHT/2-80];
               
              
                    [_Seatchtable reloadData];
                    
               
             
                    [_helptable reloadData];
                    
                    
            

                
            }
        });
    });
}
-(void)detaldate
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        //        [params setObject:@"5" forKey:@"limit"];
        if(changeint==798||changeint==7980)
        {
        detalstring=[NSString stringWithFormat:@"/api/news/findLawsById?id=%ld",(long)A];
        }
        else
        {
     
            detalstring=[NSString stringWithFormat:@"/api/mutualAid/findById?id=%ld",(long)A];

        }
        id result = [KRHttpUtil getResultDataByPost:detalstring param:nil];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"ppppppppp地对地导弹%@",result);
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                
                
                DetalsocialViewController*detal=[[DetalsocialViewController alloc]init];
                if(changeint==798||changeint==7980)
                {
                    detal.contentstring=[[result objectForKey:@"result"] objectForKey:@"content"];
                    detal.titles=[[result objectForKey:@"result"] objectForKey:@"title"];

                }
                else
                {
                    detal.contentstring=[[result objectForKey:@"result"] objectForKey:@"img"];
                    detal.titles=[[result objectForKey:@"result"] objectForKey:@"name"];

                }
                detal.a=ff;
                
                
                [self.navigationController pushViewController:detal animated:YES];
            }
            else
            {
                NSString *reason = [result objectForKey:@"message"];
                if (![KRHttpUtil checkString:reason])
                {
                    reason = @"请求超时或者网络环境较差!";
                }
                
                [self showMessage:reason viewHeight:SCREEN_HEIGHT/2-80];
                
                
                
            }
        });
    });
}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void)showMessage:(NSString*)message viewHeight:(float)height;
{
    if(self)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        //        hud.dimBackground = YES;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.yOffset = height;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    JObpp*jop=[_newallarry objectAtIndex:indexPath.row];
    
    A=[jop.jobid integerValue];
    [self detaldate];
    
   
 
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    str4textfield=textField.text;
    
    
    
    [textField resignFirstResponder];
    
    return YES;
}


//-(void)change:(MCSegmentedControl*)segmentedControl
//{
// if(segmentedControl.selectedSegmentIndex==0)
//      {
//_Seatchtable.hidden=NO;
//
//      }
//else if(segmentedControl.selectedSegmentIndex==1)
//      {
//        _Seatchtable.hidden=NO;
//        
//      }
//    else
//    {
//        
//        _Seatchtable.hidden=YES;
//        
//        [self showMessage:@"正在加紧制作中，，，" viewHeight:SCREEN_HEIGHT/2-80];
//    
//    }
//
//
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if(tableView==_Seatchtable)
   {
        return 50;
   }
    else
    {
        return 130;

    }
  
}

-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
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
