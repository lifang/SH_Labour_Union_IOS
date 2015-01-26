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

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"商户信息";
    [self setnavBar];
    [self createui];
    [self left];
    
    
    
}
-(void)createui
{
    //初始化UISegmentedControl 使用第三方 PPiFlatSegmentedControl
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"head_bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(21, 0, 21, 0)] forBarMetrics:UIBarMetricsDefault];
    segmentedControl=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20,5,SCREEN_WIDTH-40,30) items:@[               @{@"text":@"系统商户",@"":@""},
                                                                                                                               @{@"text":@"团购商户",@"":@""}
                                                                                                                               ]
                                                       iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex)
                      
                      {
                          
                          if(segmentIndex==0)
                          {
                              _Seatchtable.hidden=NO;
                              
                          }
                          
                          else
                          {
                              
                              _Seatchtable.hidden=YES;
                              
                              [self showMessage:@"正在加紧制作中，，，" viewHeight:SCREEN_HEIGHT/2-80];
                              
                          }
                          
                          
                      }];
    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStyleGrouped];
    
    
    
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
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=40;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=@"社会保障法";
    
    
    
    
    return cell;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    UIImageView *logoimageview = [[UIImageView alloc]init];
    
    logoimageview.frame = CGRectMake(10, 10, 80, 80);
    logoimageview.image=[UIImage imageNamed:@"structure"];
    
    [rootimageview addSubview:logoimageview];
    
    UILabel*namelable=[[UILabel alloc]init];
    namelable.frame=CGRectMake(95,10, SCREEN_WIDTH-100, 30);
    
    namelable.font=[UIFont systemFontOfSize:15];
    //    requirecontent.textColor=[UIColor grayColor];
    namelable.numberOfLines=0;
    [rootimageview addSubview:namelable];
    namelable.text=@"大概IDG热的分割肉";
    
    UILabel*addresslable=[[UILabel alloc]init];
    addresslable.frame=CGRectMake(95,40, SCREEN_WIDTH-100, 30);
    
    addresslable.font=[UIFont systemFontOfSize:15];
    addresslable.textColor=[UIColor grayColor];
    addresslable.numberOfLines=0;
    [rootimageview addSubview:addresslable];
    addresslable.text=@"大概IDG热的分割肉";
    
    
    UILabel*phonelable=[[UILabel alloc]init];
    phonelable.frame=CGRectMake(95,70, 120, 30);
    
    phonelable.font=[UIFont systemFontOfSize:15];
    phonelable.textColor=[UIColor grayColor];
    phonelable.numberOfLines=0;
    [rootimageview addSubview:phonelable];
    phonelable.text=@"大概IDG热的分割肉";
    
    
    UIButton*phonebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    phonebutton.frame=CGRectMake( 220, 70,25, 25);
    [phonebutton setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
    [phonebutton addTarget:self action:@selector(callclick) forControlEvents:UIControlEventTouchUpInside];
    
    [rootimageview addSubview:phonebutton];
    

    
    UILabel*contentlable=[[UILabel alloc]init];
    contentlable.frame=CGRectMake(95,100, SCREEN_WIDTH-100, 30);
    
    contentlable.font=[UIFont systemFontOfSize:15];
    contentlable.textColor=[UIColor grayColor];
    contentlable.numberOfLines=0;
    [rootimageview addSubview:contentlable];
    contentlable.text=@"大概IDG热的分割肉";
    
    
    
    
    UIButton*searchButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    searchButton.frame= CGRectMake(120, 10, 90, 30);
    
    [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    
   
    
    [rootimageview addSubview:searchButton];
    
   
    searchButton.userInteractionEnabled=YES;
    
    [searchButton addTarget:self action:@selector(searchButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton.tag=1+section;
    return rootimageview;
    
    
    
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

-(void)searchButtonclick:(UIButton*)send

{
    
    UIButton *button=(UIButton *)send;
    
    //根据按钮的tag值找到所找按钮所在的区
    int section=button.tag-1;
    
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
    
    return 150;
    
    
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
-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"5" forKey:@"limit"];
        
        NSString *urls =@"/collect/list";
        id result = [KRHttpUtil getResultDataByPost:urls param:params];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"success"] boolValue])
            {
                [HUD removeFromSuperview];
                
                
                
                
            }
            
            else
            {
                NSString *reason = [result objectForKey:@"reason"];
                if (![KRHttpUtil checkString:reason])
                {
                    reason = @"请求超时或者网络环境较差!";
                    [self showMessage:reason viewHeight:SCREEN_HEIGHT/2-80];
                }
                if([reason isEqualToString:@"认证失败"])
                {
                    [self showMessage:reason viewHeight:0.0];
                    
                    
                    
                }
                
                
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
    
    DetalsocialViewController*detal=[[DetalsocialViewController alloc]init];
    [self.navigationController pushViewController:detal animated:YES];
    
    
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
