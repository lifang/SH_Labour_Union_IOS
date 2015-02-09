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

 
    // Do any additional setup after loading the view.
    
    
    [self dates];
    
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
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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
             cell.companyname.text=[NSString stringWithFormat:@"共为您找到%d个工作职位",_jobarry.count ];

         
         }
         cell.companyname.textColor=HHZColor(99, 27, 28);
         cell.date.text=@"";
     }
        else
        {
            JObpp*jobp=[_jobarry objectAtIndex:indexPath.row-1];
            
            
            cell.jobname.text=jobp.jobname;
            
            cell.companyname.text=jobp.jobunit_name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    
    }
    else
    {
        NSLog(@"00000000%@",self.jobarry);
        
        
        
        JObpp*jobp=[_jobarry objectAtIndex:indexPath.row];
        
        
    cell.jobname.text=jobp.jobname;
    
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
        
        NSLog(@",,,,,,,,,,%@",self.stri1);
        
        
        NSString *urls =[NSString stringWithFormat:@"/api/job/search?q=%@&job_type=%@&Job_locate1=%@&Job_locate2=%@&offset=1",strUrll,strUrll1,strUrll2,strUrll3];
        NSString *strUrld = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        id result = [KRHttpUtil getResultDataByPost:strUrld param:nil];
        NSLog(@"ppppppppp地对地导弹%@",result);
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            [HUD removeFromSuperview];
            
            
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                
                
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

                jobdetal.area=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"locate"]];

                jobdetal.contact=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"lxfs"]];
                jobdetal.companyname=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"unit_name"]];

                jobdetal.companyintroduce=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"unit_about"]];
                jobdetal.require=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"job_about"]];
                jobdetal.otherids=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"id"]];

                
                [self.navigationController pushViewController:jobdetal animated:YES];

                
                
                
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
