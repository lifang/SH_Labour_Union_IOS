//
//  SearchRecordViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchRecordViewController.h"
#import "JobDetalViewController.h"
#import "navbarView.h"
#import "SearchRestulViewController.h"
#import "JObpp.h"
@interface SearchRecordViewController ()

@end

@implementation SearchRecordViewController
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",self.recortarry);
    if(self.recortarry.count==0)
    {
    
        [self showMessage:@"暂无记录" viewHeight:SCREEN_HEIGHT/2-80];

    
    
    
    }
   
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newallarry=[[NSMutableArray alloc]initWithCapacity:0];

    
    self.title=@"搜索记录";
    
    // Do any additional setup after loading the view.
    _Conditionstable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Conditionstable];
    _Conditionstable.delegate=self;
    _Conditionstable.dataSource=self;
    _Conditionstable.rowHeight=40;
    
    _Conditionstable.tableFooterView = [[UIView alloc]init];

    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self  setNavBar];
    
    
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
    
    
    
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recortarry.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    NSString*addstring;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==NO)
    {
        if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
        {
            addstring=[NSString stringWithFormat:@"%@+%@+%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"15"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
        }else
        {
            addstring=[NSString stringWithFormat:@"%@+%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
        
        }
        
        
    }
    
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==YES)
    {
        
        
        
        
        if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
        {
            addstring=[NSString stringWithFormat:@"%@+%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"]];

            
        }else
        {
            addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"]];

            
            
        }
        
    }
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==YES)
    {
      
        if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
        {
            addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"15"]];
 
            
        }else
        {
            addstring=[NSString stringWithFormat:@"%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"]];

            
            
        }
        
        
       
    }
    
    
    
    
    
    
    
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==YES)
    {
        
        
        
        if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
    {
        addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"15"]];

        
    }else
    {
        addstring=[NSString stringWithFormat:@"%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"]];

        
        
    }
    
    }
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==NO)
    {if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
    {
        addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"15"]];

        
    }else
    {
        
        addstring=[NSString stringWithFormat:@"%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
    }
        
    }
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==NO)
    {if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
    {
        addstring=[NSString stringWithFormat:@"%@+%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
    }else
    {
        
        addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"13"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
    }
        
    }
    
    if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"12"]]==NO&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"13"]]==YES&&[self isBlankString:[[self.recortarry objectAtIndex:indexPath.row ] objectForKey:@"14"]]==NO)
    {if([self isBlankString:[[self.recortarry objectAtIndex:indexPath.row] objectForKey:@"15"]]==NO)
    {
        addstring=[NSString stringWithFormat:@"%@+%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"15"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];

        
    }else
    {
        
        addstring=[NSString stringWithFormat:@"%@+%@",[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"12"],[[self.recortarry objectAtIndex:indexPath.row  ] objectForKey:@"14"]];
 
        
    }
        
    }
    

    

    cell.textLabel.text=addstring;
    //    seariamgeview.tag=indexPath.row;
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    changeA=indexPath.row;
    
    SearchRestulViewController*seach=[[SearchRestulViewController alloc]init];
    
    seach.conditionsname=@"搜索结果";
    seach.stri1=[[self.recortarry objectAtIndex:changeA ] objectForKey:@"12"];
    seach.stri2=[[self.recortarry objectAtIndex:changeA ] objectForKey:@"13"];
    seach.stri3=[[self.recortarry objectAtIndex:changeA ] objectForKey:@"15"];
    seach.str4=[[self.recortarry objectAtIndex:changeA ] objectForKey:@"14"];
    [self.navigationController pushViewController:seach animated:YES];
    
    
//    JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
//    
//    
//    [self.navigationController pushViewController:jobdetal animated:YES];
    
    
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

-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
                       NSLog(@"ppppppppp地对地导弹%@",self.recortarry);

        
        
        
        
        
        

        
        
        NSString *strUrll = [[[self.recortarry objectAtIndex:changeA ] objectForKey:@"14"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strUrll1 = [[[self.recortarry objectAtIndex:changeA ] objectForKey:@"12"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strUrll2 = [[[self.recortarry objectAtIndex:changeA ] objectForKey:@"13"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strUrll3 = [[[self.recortarry objectAtIndex:changeA ] objectForKey:@"15"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSString *urls =[NSString stringWithFormat:@"/api/job/search?job_type=%@&offset=1",strUrll1];

        NSString *strUrld = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        

//        NSString *urls =[NSString stringWithFormat:@"/api/job/search?q=%@&job_type=%@&Job_locate1=%@&Job_locate2=%@&offset=1",,,,];
        
        
        
        
        
        
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
