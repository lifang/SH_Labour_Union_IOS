//
//  SearchJobViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchJobViewController.h"
#import "SearchRestulTableViewCell.h"
#import "SearchRestulViewController.h"
#import "ConditionsViewController.h"
#import "SearchRecordViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "JobDetalViewController.h"
#import "JObpp.h"
#import "PersonalViewController.h"
#import "people.h"

@interface SearchJobViewController ()

@end

@implementation SearchJobViewController
- (void)viewWillAppear:(BOOL)animated
{
     NSLog(@"%@%@%@",str1,str3,str2);
    namearry=[[NSMutableArray alloc]initWithObjects:@"",@"行业类别",@"首选工作区域",@"次选工作区域",@"",@"        搜索记录",@"        最新职位", nil];
    

    recordarry=[NSMutableArray  arrayWithCapacity:0];
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    recordarry=[userDefaults objectForKey:@"record"];
    if(recordarry.count<3)
    {
    
    for(NSInteger i=0;i<recordarry.count;i++)
    {
        NSString*addstring=[NSString stringWithFormat:@"%@+%@",[[recordarry objectAtIndex:i ] objectForKey:@"12"],[[recordarry objectAtIndex:i ] objectForKey:@"13"]];
        
        [namearry insertObject:addstring atIndex:6];
        
        [_Seatchtable reloadData];

    
    }
    }
    else
    {
        for(NSInteger i=0;i<3;i++)
    {
        
        NSString*addstring=[NSString stringWithFormat:@"%@+%@",[[recordarry objectAtIndex: recordarry.count-i-1] objectForKey:@"12"],[[recordarry objectAtIndex:recordarry.count-i-1 ] objectForKey:@"13"]];
        
        
        [namearry insertObject:addstring atIndex:6];
        
        [_Seatchtable reloadData];
        
        
    }

    
    }
}
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    _newallarry=[[NSMutableArray alloc]initWithCapacity:0];

    self.title=@"岗位查询";
    [self setnavBar];
    if(iOS7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage resizedImage:@"navBG"] forBarMetrics:UIBarMetricsDefault];
        
    }
    // Do any additional setup after loading the view.
      _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    _conditarry=[[NSMutableArray alloc]init];
    
    
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=50;
    [self left];
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return namearry.count;

  
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
//    SearchRestulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (!cell)
//    {
        SearchRestulTableViewCell*cell = [[SearchRestulTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
//    }
  
    
    
        cell.textLabel.text=[namearry objectAtIndex:indexPath.row];

 
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0)
    {
        UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 33)];
        [cell addSubview:searchrootview];
        if(iOS7)
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-80, 31)];
        }
        else
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-80, 31)];
            
        }
        searchrootview.layer.cornerRadius=15;
        
        _searchfield.placeholder=@"请输入关键字/职位/公司/地点 ";
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
        
        UIImageView*seariamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
        [searchrootview addSubview: seariamgeview];
        seariamgeview.image=[UIImage imageNamed:@"search"];
        
        
    }
    if(indexPath.row==4)
    {
        UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 40)];
        
        [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
        [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchButton setBackgroundColor:[UIColor colorWithRed:234.0/255 green:171.0/255 blue:26.0/255 alpha:1]];
        
        searchButton.layer.cornerRadius=5;
        
        
        [cell addSubview:searchButton];
        
        
        searchButton.userInteractionEnabled=YES;
        
        [searchButton addTarget:self action:@selector(searchButtonclick) forControlEvents:UIControlEventTouchUpInside];
    }
    if(indexPath.row==5)
    {
    
        UIImageView*recordiamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
        [cell addSubview: recordiamgeview];
        recordiamgeview.image=[UIImage imageNamed:@"searchs"];
    
    }
    if(indexPath.row==namearry.count-1)
    {
        
        
        UIImageView*adviceiamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
        [cell addSubview: adviceiamgeview];
        adviceiamgeview.image=[UIImage imageNamed:@"position"];
        
    }
    if(indexPath.row==0||indexPath.row==4)
    {
        
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    return cell;
    
    
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
    //    self.leftViewBtn.tag++;
    //    SLog(@"%ld",self.leftViewBtn.tag);
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    //    if (self.leftViewBtn.tag % 2 == 0) {
    //        [delegate.DrawerController closeDrawerAnimated:YES completion:nil];
    //    }
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   //  行业类别
    
    
    
    
    if(indexPath.row==1)
    {
        ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"行业类别";
        
     [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str1=hangyestring;
            
            
            
        };

    }
    
     //  首选工作区域
    
    
    if(indexPath.row==2)
    {ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"首选工作区域";
        
        [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str2=hangyestring;
            
            
        };

    }
    
//   次选工作区域
    
    
    if(indexPath.row==3)
    {ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"次选工作区域";
        
        [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str3=hangyestring;
            
           
            
        };

    }
    
//  搜索记录
    
    
    
    if(indexPath.row==5)
    {
        
        SearchRecordViewController*seach=[[SearchRecordViewController alloc]init];
     
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        

        recordarry=[userDefaults objectForKey:@"record"];
        NSMutableArray*recordsarry=[NSMutableArray arrayWithCapacity:0];
        for(int i=0;i<recordarry.count;i++)
        {
            [recordsarry addObject:[recordarry objectAtIndex:i]];
            
            
            
        }

           seach.recortarry=recordsarry;
        
        [self.navigationController pushViewController:seach animated:YES];
        
    }
    //  最新职位

    if(indexPath.row==namearry.count-1)
    {
        [self newjobdate];

            }
    
    //  搜索记录1
    
    
    if(namearry.count==8)
    {
        if(indexPath.row==6)
        {
        JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
        
        
        [self.navigationController pushViewController:jobdetal animated:YES];
        }
        
    }
    
    
    //  搜索记录2
    if(namearry.count==9)
    {
        if(indexPath.row==6)
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
        }
        if(indexPath.row==7)
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
        }
        
    }
    //  搜索记录3
    if(namearry.count==10)
    {
        if(indexPath.row==6)
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
        }
        if(indexPath.row==7)
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
        }
        if(indexPath.row==8)
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
        }
        
    }
 
    

    
}
#pragma mark - 获取网络数据
-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =[NSString stringWithFormat:@"/api/job/search?q=%@&job_type=%@&Job_locate1=%@&Job_locate2=%@",_searchfield.text,str1,str2,str3];
        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    
                    peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"job_name"]];
                    peo.jobunit_name=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"unit_name"]];
                    
                    //                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_newallarry addObject:peo];
                    
                }
                
                SearchRestulViewController*seach=[[SearchRestulViewController alloc]init];
                
                seach.conditionsname=@"搜索结果";
                seach.jobarry=_newallarry;
                NSLog(@"%@",seach.jobarry);
                [self.navigationController pushViewController:seach animated:YES];

                
            }
            
            else
            {
                NSString *reason = @"请求超时或者网络环境较差!";
                if (![KRHttpUtil checkString:reason])
                {
                    reason = @"请求超时或者网络环境较差!";
                }

                [self showMessage:reason viewHeight:SCREEN_HEIGHT/2-80];
              
                
                
            }
        });
    });
}

-(void)newjobdate
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/job/findNewJob";
        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                [_newallarry removeAllObjects];
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    
                    peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"job_name"]];
                    peo.jobunit_name=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"unit_name"]];

//                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_newallarry addObject:peo];
                    
                }

                SearchRestulViewController*seach=[[SearchRestulViewController alloc]init];
                
                seach.conditionsname=@"最新职位";
                seach.jobarry=_newallarry;
                NSLog(@"%@",seach.jobarry);
                [self.navigationController pushViewController:seach animated:YES];
                

                
            }
            
            else
            {
                NSString *reason = @"请求超时或者网络环境较差!";
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

#pragma mark - 搜索点击事件
-(void)searchButtonclick
{

    if([self isBlankString:str1]==YES&&[self isBlankString:str2]==YES&&[self isBlankString:str3]==YES&&[self isBlankString:_searchfield.text]==YES)
    {
        [self showMessage:@"请选择查询条件" viewHeight:SCREEN_HEIGHT/2-80];
        return;
        
    
    }
   
    [self date];
    
    

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    recordarry=[userDefaults objectForKey:@"record"];
    NSMutableArray*recordsarry=[NSMutableArray arrayWithCapacity:0];
    for(int i=0;i<recordarry.count;i++)
    {
        [recordsarry addObject:[recordarry objectAtIndex:i]];
        
    
    
    }
    NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
    [dict setValue:str1 forKey:@"12"];
    [dict setValue:str2 forKey:@"13"];
    
    [recordsarry addObject:dict];
    
    [userDefaults setObject:recordsarry forKey:@"record"];
    [userDefaults synchronize];
    

     str1=@"";
    
    str2=@"";
    

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
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
