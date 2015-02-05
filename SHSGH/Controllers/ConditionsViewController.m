//
//  ConditionsViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ConditionsViewController.h"
#import "ConditionsTableViewCell.h"
#import "navbarView.h"
#import "people.h"
@interface ConditionsViewController ()

@end

@implementation ConditionsViewController
@synthesize block;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];


    self.title=self.conditionsname;
    
 

    [self createui];
    
  
    // Do any additional setup after loading the view.
    _Conditionstable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStylePlain];
    
    
    _Conditionstable.tableFooterView = [[UIView alloc]init];

    
    [self.view addSubview:_Conditionstable];
    _Conditionstable.delegate=self;
    _Conditionstable.dataSource=self;
    _Conditionstable.rowHeight=40;
    
     [self date];
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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
        //        [params setObject:@"1" forKey:@"typeId"];
        
        
        if([self.conditionsname isEqualToString:@"行业类别"])
        {
            urls =@"/api/job/findAllRI";

        
        }
       
       else if([self.conditionsname isEqualToString:@"首选工作区域"])
        {
            
            urls =@"/api/job/findAllAddr";

        }
        else
        {
        
            urls =@"/api/job/findAllAddr";

        
        }
            
               
        
        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
                      
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                [imagearry removeAllObjects];
                
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    people*peo=[[people alloc]init];
                    
                    peo.ids=[[[arry objectAtIndex:i] objectForKey:@"id"] intValue];
                    
                    if([self.conditionsname isEqualToString:@"行业类别"])
                    {
                        peo.namestring=[[arry objectAtIndex:i] objectForKey:@"hymc"];


                    
                    }
                    else
                    {
                        peo.namestring=[[arry objectAtIndex:i] objectForKey:@"name"];

                    }
                    
                    NSLog(@"ppppppppp地对地导弹%@",peo.about_detail);
                    
                    [_allarry addObject:peo];
                    
                }
                imagearry=[[NSMutableArray alloc]initWithCapacity:0];
                for(NSInteger i=0;i<_allarry.count;i++)
                {
                    [imagearry addObject:@""];
                    
                    
                }
                
                [imagearry replaceObjectAtIndex:self.recordint withObject:@"dui"];

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


-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}

-(void)setNavBar
{
//    self.title = @"个人中心";
//    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
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
    
//    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
//    
//    
//     gobackbut.bounds = CGRectMake(0, 0, 20, 25);
//    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIView*lineview=[[UIView alloc]init];
//    lineview.bounds = CGRectMake(0, 0, 1, 45);
//    lineview.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
//    
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
//    
//    UIBarButtonItem *leftItem2= [[UIBarButtonItem alloc] initWithCustomView:lineview];
//    
// NSArray *array = [[NSArray alloc] initWithObjects:leftItem,leftItem2, nil];
//    
//        self.navigationItem.leftBarButtonItems = array;


}
-(void)gobackclick
{


    [self.navigationController popViewControllerAnimated:YES];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allarry.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[ConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    
  
   cell.logoImageView.image=[UIImage imageNamed:[imagearry objectAtIndex:indexPath.row]];
    
    people*pname=[_allarry objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text=pname.namestring;
//    seariamgeview.tag=indexPath.row;
    
     return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//   UIImageVieConditionsTableViewCellw*clickimageview=(UIImageView*)[self.view viewWithTag:indexPath.row];
  
//        clickimageview.image=[UIImage imageNamed:@"dui"];
   [imagearry removeAllObjects];
    
  
    for(NSInteger i=0;i<_allarry.count;i++)
    {
        [imagearry addObject:@""];
        
        
    }

    [imagearry replaceObjectAtIndex:indexPath.row withObject:@"dui"];
    
    people*pname=[_allarry objectAtIndex:indexPath.row];
    

    if (self.block) {
//        if([self.conditionsname isEqualToString:@"行业类别"])
//        {
//           block([NSString stringWithFormat:@"%d",pname.ids]);
//            
//        }
//        else{
        
        
            block([NSString stringWithFormat:@"%@",pname.namestring],indexPath.row);

//        }

       
    }

   [_Conditionstable reloadData];
    
    

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
