//
//  SearchRestulViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchRestulViewController.h"
#import "GetresultTableViewCell.h"
#import "JobDetalViewController.h"
#import "navbarView.h"
#import "people.h"
#import "JObpp.h"
@interface SearchRestulViewController ()

@end

@implementation SearchRestulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _jobarry=[[NSMutableArray alloc]initWithCapacity:0];
    [_jobarry removeAllObjects];

    _isReloadingAllData = YES;

    // Do any additional setup after loading the view.
    
    
      self.title=self.conditionsname;
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    _newallarry=[[NSMutableArray alloc]initWithCapacity:0];
    [self setNavBar];
    
    [self createui];
    
       
    // Do any additional setup after loading the view.
    _getresulttable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStylePlain];
    
    _getresulttable.tableFooterView = [[UIView alloc]init];

    
    
    [self.view addSubview:_getresulttable];
    _getresulttable.delegate=self;
    _getresulttable.dataSource=self;
    _getresulttable.rowHeight=50;
    
    if([self.conditionsname isEqualToString:@"最新职位"])
    {
        [self newjobdate];
        
        
    }
    else
    {
        [self setupRefresh];
        
        
    }

    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//    [self setupRefresh];
}

-(void)setupRefresh
{
    
    
    //下拉
    [_getresulttable addHeaderWithTarget:self action:@selector(loadNewStatuses:) dateKey:@"table"];
    [_getresulttable headerBeginRefreshing];
    //上拉
    [_getresulttable addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _getresulttable.headerPullToRefreshText = @"下拉可以刷新了";
    _getresulttable.headerReleaseToRefreshText = @"松开马上刷新了";
    _getresulttable.headerRefreshingText = @">.< 正在努力加载中!";
    
    _getresulttable.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _getresulttable.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _getresulttable.footerRefreshingText = @">.< 正在努力加载中!";
    
}

//下拉刷新加载更多数据
-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    _isReloadingAllData=YES;
    [_jobarry removeAllObjects];
    
    [self dates];
    
    
}

//上拉刷新加载更多微博数据
-(void)loadMoreStatuses
{
    _isReloadingAllData=NO;
    if(_jobarry.count==totalCount)
    {
        [self showMessage:@"已经为您加载了全部数据亲" viewHeight:SCREEN_HEIGHT/2-80];
        [_getresulttable footerEndRefreshing];
        
        return;
        
    }
    
    if(_jobarry.count<totalCount)
    {
        [self dates];
        
    }
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [_Seatchtable footerEndRefreshing];
    //        
    //    });
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
-(void)createui
{
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(110, 0, 0);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(110, 0, 0);
        
        
    }
    
    [self setnavBar];
    
//    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
//    
//    
//    gobackbut.bounds = CGRectMake(0, 0, 20, 25);
//    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
//    
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.conditionsname isEqualToString:@"搜索结果"])
    {
        return _jobarry.count+1;

    
    }
    else
    {
    
    
        return _jobarry.count;
}
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    GetresultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[GetresultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if([self.conditionsname isEqualToString:@"搜索结果"])
    {
     if(indexPath.row==0)
     {
         cell.jobname.text=@"";
         if(self.jobarry.count==0)
         {
             cell.companyname.text=@"暂无此职位";

         
         }else
         {
             cell.companyname.text=[NSString stringWithFormat:@"共为您找到%d个工作职位",totalCount ];

         
         }
         cell.companyname.textColor=HHZColor(99, 27, 28);
         cell.date.text=@"";
     }
        else
        {
            
            if(_jobarry.count!=0)
            {
            
                JObpp*jobp=[_jobarry objectAtIndex:indexPath.row-1];
                
                
                cell.jobname.text=jobp.jobname;
                cell.companyname.textColor=[UIColor grayColor];

                cell.companyname.text=jobp.jobunit_name;
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    
    }
    else
    {
        NSLog(@"00000000%@",self.jobarry);
        
        
        
        JObpp*jobp=[_jobarry objectAtIndex:indexPath.row];
        
        
    cell.jobname.text=jobp.jobname;
        cell.companyname.textColor=[UIColor grayColor];
        
    cell.companyname.text=jobp.jobunit_name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   UIImageVieConditionsTableViewCellw*clickimageview=(UIImageView*)[self.view viewWithTag:indexPath.row];
    
    //        clickimageview.image=[UIImage imageNamed:@"dui"];
    //    [imagearry removeAllObjects];
    
    if([self.conditionsname isEqualToString:@"搜索结果"])
    {
        if(indexPath.row==0)
        {
       [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        else
        {   JObpp*jobp=[self.jobarry objectAtIndex:indexPath.row-1];
            
            getids=jobp.jobid;
            [self date];

         
            
            
        }
    
    
    }
    
//    职位推荐详情
    
    else
    {
        
        JObpp*jobp=[self.jobarry objectAtIndex:indexPath.row];
        
        getids=jobp.jobid;
        [self date];

        
        
        
        
        

    
    }
    
    
}
#pragma mark - 获取网络数据



-(void)dates
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    

    

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *strUrll = [self.str4 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strUrll1 = [self.stri1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strUrll2 = [self.stri2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strUrll3 = [self.stri3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@",,,,,,,,,1,%@",self.str4);
        NSLog(@",,,,,,,,,,%@",self.stri2);
        NSLog(@",,,,,,,,2,,%@",self.stri3);

        NSLog(@",,,,,,,,,,%@",self.stri1);
        NSString*sttt1;
        
        
          NSString*sttt2;
          NSString*sttt3;
          NSString*sttt4;
        if( [self isBlankString: strUrll1]==YES)
        {
        
            sttt1=@"";

        
        }
        else
        {
        
            sttt1=[NSString stringWithFormat:@"&job_type=%@",strUrll1];
            
        
        
        }
        
        
        if( [self isBlankString: strUrll2]==YES)
        {
            
            sttt2=@"";

            
        }
        else
        {
            
            sttt2=[NSString stringWithFormat:@"&Job_locate1=%@",strUrll2];
            
            
            
        }
        if( [self isBlankString: strUrll3]==YES)
        {
            
            sttt3=@"";

            
        }
        else
        {
            
            sttt3=[NSString stringWithFormat:@"&Job_locate2=%@",strUrll3];
            
            
            
        }

        if( [self isBlankString: strUrll]==YES)
        {
            
            sttt4=@"";
            
            
        }
        else
        {
            
            sttt4=[NSString stringWithFormat:@"&q=%@",strUrll];
            
            
            
        }

        
        
        
        NSString *urls =[NSString stringWithFormat:@"/api/job/search?%@%@%@%@&offset=%d",sttt4,sttt1,sttt2,sttt3,_jobarry.count/10+1];
        
      NSString*headerDatadgdgfgf= [urls stringByReplacingOccurrencesOfString:@" " withString:@""];

        NSString *strUrld = [headerDatadgdgfgf stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        id result = [KRHttpUtil getResultDataByPost:strUrld param:nil];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            [HUD removeFromSuperview];
            
            
            
            [_getresulttable headerEndRefreshing];
            [_getresulttable footerEndRefreshing];
            
            
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                if (_isReloadingAllData)
                    
                {
                    [_jobarry removeAllObjects];
                }
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    
                    peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"job_name"]];
                    peo.jobunit_name=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"unit_name"]];
                    
                    //                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_jobarry addObject:peo];
                    
                }
                totalCount = [[result objectForKey:@"total"] integerValue];

                [_getresulttable reloadData];
                
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
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                [_jobarry removeAllObjects];
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    
                    peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"job_name"]];
                    peo.jobunit_name=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"unit_name"]];
                    
                    //                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_jobarry addObject:peo];
                    
                }
                
                [_getresulttable reloadData];
          
                
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

-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        NSString *urls =  [NSString stringWithFormat:@"/api/job/findById?id=%@",getids];
        

        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                
                
                
                
                    
              
                
                JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
                jobdetal.zhiweiname=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"job_name"]];
                
                jobdetal.peoplenumber=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"rs"]];
                
                if( [self isBlankString: [[result objectForKey:@"result"] objectForKey:@"locate"] ])
                {
                    
                    
                 jobdetal.area=@"";
                    
                    
                }
                else
                {
                    jobdetal.area=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"locate"]];
                    
                    
                }
                if( [self isBlankString: [[result objectForKey:@"result"] objectForKey:@"lxfs"] ])
                {
                    
                    
                    jobdetal.contact=@"";
                    
                    
                }
                else
                {
                    jobdetal.contact=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"lxfs"]];
                    
                    
                }


                if( [self isBlankString: [[result objectForKey:@"result"] objectForKey:@"unit_name"] ])
                {
                    
                    
                    jobdetal.companyname=@"暂无公司名字";
                    
                    
                }
                else
                {
                    jobdetal.companyname=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"unit_name"]];
                    
                    
                }

                
                
                if( [self isBlankString: [[result objectForKey:@"result"] objectForKey:@"unit_about"] ])
                {
                    
                    
                    jobdetal.companyintroduce=@"";
                    
                    
                }
                else
                {
                    jobdetal.companyintroduce=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"unit_about"]];
                    
                    
                }
                if([[[result objectForKey:@"result"] objectForKey:@"job_about"] isKindOfClass:[NSNull class]])
                {
                    
                    
                    jobdetal.require=@"";
                    
                    
                }
                else
                {
                    jobdetal.require=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"job_about"]];
                    
                    
                }



                jobdetal.otherids=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"id"]];

                
                [self.navigationController pushViewController:jobdetal animated:YES];

                NSLog(@"hhhhhh%@", jobdetal.contact);
                
                NSLog(@"%@", jobdetal.companyintroduce);

                
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
