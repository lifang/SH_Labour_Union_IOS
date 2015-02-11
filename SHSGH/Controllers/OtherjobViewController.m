//
//  OtherjobViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "OtherjobViewController.h"
#import "JobDetalViewController.h"
#import "navbarView.h"

#import "JObpp.h"
@interface OtherjobViewController ()

@end

@implementation OtherjobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _newallarry=[[NSMutableArray alloc]initWithCapacity:0];
    [self newjobdate];
    

    self.title=@"其他岗位招聘";
    
    // Do any additional setup after loading the view.
    _Conditionstable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Conditionstable];
    _Conditionstable.delegate=self;
    _Conditionstable.dataSource=self;
    _Conditionstable.rowHeight=40;
    
    _Conditionstable.tableFooterView = [[UIView alloc]init];

    
//       _Conditionstable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self  setNavBar];
    
    
}
-(void)newjobdate
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =  [NSString stringWithFormat:@"/api/job/findOtherJobById?id=%@",self.otherids];

        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        NSLog(@"ppppppppp地对地导弹%@",self.otherids);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                [_newallarry removeAllObjects];
                
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    JObpp*peo=[[JObpp alloc]init];
                    
                    
                    peo.jobid=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"id"]];
                    peo.jobname=[NSString stringWithFormat:@"%@",[[arry objectAtIndex:i] objectForKey:@"job_name"]];
                    
                    //                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_newallarry addObject:peo];
                    
                }
                
               
                [_Conditionstable reloadData];
                
                
                
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
                
                if([[[result objectForKey:@"result"] objectForKey:@"locate"] isKindOfClass:[NSNull class]])
                {
                    
                    
                    jobdetal.area=@"";
                    
                    
                }
                else
                {
                    jobdetal.area=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"locate"]];
                    
                    
                }
                if([[[result objectForKey:@"result"] objectForKey:@"lxfs"] isKindOfClass:[NSNull class]])
                {
                    
                    
                    jobdetal.contact=@"";
                    
                    
                }
                else
                {
                    jobdetal.contact=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"lxfs"]];
                    
                    
                }
                
                
                
                jobdetal.companyname=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"unit_name"]];
                
                
                if([[[result objectForKey:@"result"] objectForKey:@"unit_about"] isKindOfClass:[NSNull class]])
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
                
                jobdetal.chanageA=9;

                
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
    
  
    
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    JObpp*jj=[_newallarry objectAtIndex:indexPath.row];
    
    cell.textLabel.text=jj.jobname;
    //    seariamgeview.tag=indexPath.row;
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
    JObpp*jobp=[_newallarry objectAtIndex:indexPath.row];
    
    getids=jobp.jobid;
    [self date];
    
//    [self.navigationController pushViewController:jobdetal animated:YES];
    
    
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
