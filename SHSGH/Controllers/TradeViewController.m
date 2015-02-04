//
//  TradeViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "TradeViewController.h"
#import "DetalsocialViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "NSString+FontAwesome.h"
#import "PersonalViewController.h"
#import "TradedetalViewController.h"
#import "QipaoTableViewCell.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "people.h"
#import "EGOImageView.h"

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    firstA=1002;
    
    _isReloadingAllData = YES;

    self.title=@"商户信息";
    [self setnavBar];
    [self createui];
    [self left];
    [self date];
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
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    _isReloadingAllData=YES;
    [_allarry removeAllObjects];

    [self date];
    
        
//    });
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    _isReloadingAllData=NO;
    
    if(_allarry.count<totalCount)
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
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    segmentedControl=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20,5,SCREEN_WIDTH-40,30) items:@[               @{@"text":@"系统商户",@"":@""},
                                                                                                                               @{@"text":@"团购商户",@"":@""}
                                                                                                                               ]
                                                       iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex)
                      
                      {
                          
                          if(segmentIndex==0)
                          {
                              [_allarry removeAllObjects];
                              firstA=1002;
                              _isReloadingAllData = YES;

                              
                              [self date];
                              
                              
                          }
                          
                          else
                          {
                              firstA=1003;

                              _isReloadingAllData = YES;
                              [_allarry removeAllObjects];
                              
                              
                              
                              [self date];
                              
                          }
                          
                          
                      }];
    
  
    
    
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
    
    
    
    
    segmentedControl.color=[UIColor whiteColor];
    segmentedControl.borderWidth=0.5;
    segmentedControl.borderColor=[UIColor grayColor];
    segmentedControl.selectedColor=[UIColor colorWithRed:160.0/255 green:30.0/255 blue:30.0/255 alpha:1];
    segmentedControl.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                      NSForegroundColorAttributeName:[UIColor blackColor]};
    segmentedControl.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                              NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmentedControl];
    
    
    
    
    
    
    //    segmentedControl.tintColor= [UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
    //    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    //    [segmentedControl setSelectedSegmentIndex:0];
    //    segmentedControl.selectedItemColor   = [UIColor whiteColor];
    //    segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStyleGrouped];
    

    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
//    _Seatchtable.rowHeight=40;
    
    _Seatchtable.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allarry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_flagArray[section])
    {
        return 1;
    }
    else
    {
        return 0;
    }

    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    QipaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[QipaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.namelable.textColor=[UIColor grayColor];
    people*peop=[_allarry objectAtIndex:indexPath.section];
    
    cell.namelable.text=peop.about_detail;
    cell.namelable.numberOfLines=0;
    
    [cell.namelable sizeToFit];
    
   
   
    cell.logoImageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, cell.namelable.frame.size.height+20);
    
    
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel*templabel =[[UILabel alloc]initWithFrame:CGRectMake(80, 230, 210, 55)];
    templabel.numberOfLines=0;
    people*peop=[_allarry objectAtIndex:indexPath.section];

    templabel.text =peop.about_detail;
    
    templabel.font=[UIFont systemFontOfSize:12];
    [templabel sizeToFit];
    
    
        return templabel.frame.size.height+30;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    rootimageview.userInteractionEnabled=YES;
    
//    UITapGestureRecognizer *singleTapss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    UIButton*touchclickimageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    touchclickimageview.tag=section;
    
    [rootimageview addSubview:touchclickimageview];
    
    [touchclickimageview addTarget:self action:@selector(handleSingleFingerEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
//       [ touchclickimageview addGestureRecognizer:singleTapss];
    EGOImageView *logoimageview = [[EGOImageView alloc]init];
    
    logoimageview.frame = CGRectMake(10, 10, 80, 100);
    

//    logoimageview.image=[UIImage imageNamed:@"structure"];
    
    [rootimageview addSubview:logoimageview];
    logoimageview.userInteractionEnabled=NO;
    people*peop=[_allarry objectAtIndex:section];
    
//    EGOImageView *imageView = [[EGOImageView alloc]init];
    
    
    NSURL *imageUrl = [NSURL URLWithString:peop.images];
    logoimageview.imageURL = imageUrl;
//    [logoimageview  sd_setImageWithURL:[NSURL URLWithString:peop.images] placeholderImage:[UIImage imageNamed:@"餐饮(1)"]];

    UILabel*namelable=[[UILabel alloc]init];
    namelable.frame=CGRectMake(95,10, SCREEN_WIDTH-100, 20);
    
    namelable.font=[UIFont systemFontOfSize:13];
//      requirecontent.textColor=[UIColor grayColor];
//    namelable.numberOfLines=0;
    [rootimageview addSubview:namelable];
    namelable.text=peop.namestring;
    namelable.userInteractionEnabled=NO;

    UILabel*addresslable=[[UILabel alloc]init];
    addresslable.frame=CGRectMake(95,30, SCREEN_WIDTH-100, 20);
    
    addresslable.font=[UIFont systemFontOfSize:15];
    addresslable.textColor=[UIColor grayColor];
    addresslable.numberOfLines=0;
    [rootimageview addSubview:addresslable];
    addresslable.text=peop.addrstring;
    
    addresslable.userInteractionEnabled=NO;

    UILabel*phonelable=[[UILabel alloc]init];
    phonelable.frame=CGRectMake(95,50, 120, 20);
    
    phonelable.font=[UIFont systemFontOfSize:15];
    phonelable.textColor=[UIColor grayColor];
    phonelable.numberOfLines=0;
    [rootimageview addSubview:phonelable];
    phonelable.text=peop.phone;
    
    phonelable.userInteractionEnabled=NO;

    UIButton*phonebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    phonebutton.tag=section;
    
    phonebutton.frame=CGRectMake( 220, 50,25, 25);
    [phonebutton setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
    [phonebutton addTarget:self action:@selector(callclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rootimageview addSubview:phonebutton];
    

    
    UILabel*contentlable=[[UILabel alloc]init];
    contentlable.frame=CGRectMake(95,70, SCREEN_WIDTH-140, 40);
    
    contentlable.font=[UIFont systemFontOfSize:12];
//    contentlable.textColor=[UIColor grayColor];
    contentlable.numberOfLines=0;
    
    [rootimageview addSubview:contentlable];
    contentlable.text=peop.about;
    
    contentlable.userInteractionEnabled=NO;

    
    
    UIButton*searchButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    searchButton.frame= CGRectMake(SCREEN_WIDTH-40, 80, 30, 30);

    
    if (_flagArray[section])
    {   [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:0.5];
        
        [searchButton setImage:[UIImage imageNamed:@"show2"] forState:UIControlStateNormal];

        [UIView commitAnimations];

       
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:0.5];
        
        [searchButton setImage:[UIImage imageNamed:@"show1"] forState:UIControlStateNormal];
        
        [UIView commitAnimations];
    }
    

    
    
    [rootimageview addSubview:searchButton];
    
   
//    searchButton.userInteractionEnabled=NO;
    
    [searchButton addTarget:self action:@selector(detalButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton.tag=1+section;
    return rootimageview;
    
    
    
}
- (void)handleSingleFingerEvent:(UIButton *)sender
{
    
    NSInteger tagA=sender.tag;
    
    people*pp=[_allarry objectAtIndex:tagA];
    changeA=pp.ids;
    
    [self detaldate];
    
    
    
    
    
    
    
}

-(void)callclick:(UIButton*)send
{
    
    UIWebView*callWebview =[[UIWebView alloc] init];
  people*pephone=  [_allarry objectAtIndex:send.tag];
    
    
    NSString*phone=pephone.phone;
    
    
    
    
    
    NSString *telUrl = [NSString stringWithFormat:@"tel:%@",phone];
    
    
    
    
    NSURL *telURL =[NSURL URLWithString:telUrl];// 貌似tel:// 或者 tel: 都行
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    //记得添加到view上
    
    [self.view addSubview:callWebview];
}

-(void)detalButtonclick:(UIButton*)send

{
    
    UIButton *button=(UIButton *)send;
    
    //根据按钮的tag值找到所找按钮所在的区
    int section=button.tag-1.0;
    
    //取反  如果布尔数组中的值是yes=>>no.no=>>yes
    _flagArray[section]=!_flagArray[section];
    
    //让表重新加载(刷新整个表)
    //[_tableView reloadData];
    
    //先根据要刷新的区号，创建一个索引集
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
    
    //刷新指定的区
    [_Seatchtable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 110;
    
    
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
    PersonalViewController *personVC = [[PersonalViewController alloc]init];
    
    [self.navigationController pushViewController:personVC animated:YES];
    SLog(@"toUser");
}

-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - 获取网络数据
-(void)detaldate
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString*changeurl=[NSString stringWithFormat:@"/api/merchant/findById?id=%ld",(long)changeA];
        
        id result = [KRHttpUtil getResultDataByPost:changeurl param:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            [_Seatchtable headerEndRefreshing];
            [_Seatchtable footerEndRefreshing];
            
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                //                NSArray*arry=[result objectForKey:@"result"] ;
                
                
                TradedetalViewController*detal=[[TradedetalViewController alloc]init];
                
                
                detal.ids=[NSString stringWithFormat:@"%d",changeA];
                
                
                
                detal.name=[[result objectForKey:@"result"]  objectForKey:@"name"];
                
                detal.tel=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"]  objectForKey:@"tel"]];
                detal.address=[[result objectForKey:@"result"]  objectForKey:@"addr"];
                detal.about=[[result objectForKey:@"result"]  objectForKey:@"about"];

                
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

-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        [params setObject:@"1" forKey:@"typeId"];
        
        
        if (firstA==1002)
        {
            urls =[NSString stringWithFormat:@"/api/merchant/findAll?typeId=1&offset=%d",_allarry.count/10+1];

        }
      
     else
        {
    urls =[NSString stringWithFormat:@"/api/merchant/findAll?typeId=2&offset=%d",_allarry.count/10+1];

        }
    
     
       

    
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
          

            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                if (_isReloadingAllData)
                    
                {
                    [_allarry removeAllObjects];
                }
               NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
              
                for(int i=0;i<arry.count;i++)
                {
                    
                    people*peo=[[people alloc]init];
                    if([[[arry objectAtIndex:i] objectForKey:@"about"] isKindOfClass:[NSNull class]])
                    {
                        peo.about=@"";
                        
                    peo.about_detail=@"";
                        
                    
                    }
                    else
                    {
                        peo.about=[[arry objectAtIndex:i] objectForKey:@"about"];
                        peo.about_detail=[[arry objectAtIndex:i] objectForKey:@"about_detail"];

                    
                    }
                    peo.images=[[arry objectAtIndex:i] objectForKey:@"logo"];

                    
                    peo.addrstring=[[arry objectAtIndex:i] objectForKey:@"addr"];
                    peo.ids=[[[arry objectAtIndex:i] objectForKey:@"id"] intValue];
                   
                    peo.namestring=[[arry objectAtIndex:i] objectForKey:@"name"];
                    peo.phone=[[arry objectAtIndex:i] objectForKey:@"tel"];

                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);

                    [_allarry addObject:peo];
                    
                }
                totalCount = [[result objectForKey:@"total"] integerValue];
                
                if (_allarry.count!=0)
                {
                    
                    [_Seatchtable reloadData];
                    [_Seatchtable headerEndRefreshing];
                    [_Seatchtable footerEndRefreshing];

                }
                if(_allarry.count==totalCount)
                {
                    [self showMessage:@"已经为您加载了全部数据亲" viewHeight:SCREEN_HEIGHT/2-80];
                    _Seatchtable.footerPullToRefreshText = @"已经为您加载了全部数据亲";
                    _Seatchtable.footerReleaseToRefreshText = @"已经为您加载了全部数据亲";
                    _Seatchtable.footerRefreshingText = @"已经为您加载了全部数据亲";
                    
                    [_Seatchtable footerEndRefreshing];
//                    _Seatchtable.footerHidden = YES;

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


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    DetalsocialViewController*detal=[[DetalsocialViewController alloc]init];
//    [self.navigationController pushViewController:detal animated:YES];
//    
//    
//}


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
