//
//  OrganizationViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "OrganizationViewController.h"
#import "DetalsocialViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "NSString+FontAwesome.h"
#import "PersonalViewController.h"
#import "OrganizationTableViewCell.h"
#import "OrganizationdetalViewController.h"
@interface OrganizationViewController ()

@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"机构查询";
    [self setnavBar];
    [self createui];
    [self left];
    
    
    
}
-(void)createui
{
    //初始化UISegmentedControl 使用第三方 PPiFlatSegmentedControl
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"head_bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(21, 0, 21, 0)] forBarMetrics:UIBarMetricsDefault];
    segmentedControl=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20,5,SCREEN_WIDTH-40,30) items:@[               @{@"text":@"职工援助服务中心",@"":@""},
                                                                                                                               @{@"text":@"职工法律援助中心",@"":@""}
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
    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
    
    
    
    
    segmentedControl.color=[UIColor whiteColor];
    segmentedControl.borderWidth=0.5;
    segmentedControl.borderColor=[UIColor grayColor];
    segmentedControl.selectedColor=[UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
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
    _Seatchtable.rowHeight=70;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    OrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[OrganizationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    
    
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrganizationdetalViewController*detal=[[OrganizationdetalViewController alloc]init];
    [self.navigationController pushViewController:detal animated:YES];
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
//    
//    UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-80, 35)];
//    [rootimageview addSubview:searchrootview];
//    
//    if(iOS7)
//    {
//        _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-120, 33)];
//    }
//    else
//    {
//        _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-120, 33)];
//        
//    }
//    searchrootview.layer.cornerRadius=18;
//    
//    _searchfield.placeholder=@"请输入关键字 ";
//    _searchfield.delegate=self;
//    CALayer *layer=[searchrootview layer];
//    //是否设置边框以及是否可见
//    [layer setMasksToBounds:YES];
//    //设置边框圆角的弧度
//    
//    //设置边框线的宽
//    //
//    [layer setBorderWidth:1];
//    //设置边框线的颜色
//    [layer setBorderColor:[[UIColor grayColor] CGColor]];
//    [searchrootview addSubview:_searchfield];
//    
//    UIImageView*seariamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 25, 25)];
//    [searchrootview addSubview: seariamgeview];
//    seariamgeview.image=[UIImage imageNamed:@"search"];
//    
//    
//    UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 8, 40, 30)];
//    
//    [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
//    searchButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
//    
//    [searchButton setTitleColor:HHZColor(99, 27, 28) forState:UIControlStateNormal];
//    searchButton.layer.cornerRadius=5;
//    searchButton.layer.cornerRadius=5;
//    
//    [rootimageview addSubview:searchButton];
//    
//    CALayer *layers=[searchButton layer];
//    //是否设置边框以及是否可见
//    [layers setMasksToBounds:YES];
//    //设置边框圆角的弧度
//    
//    //设置边框线的宽
//    //
//    [layers setBorderWidth:1];
//    //设置边框线的颜色
//    [layers setBorderColor:[[UIColor grayColor] CGColor]];
//    searchButton.userInteractionEnabled=YES;
//    
//    [searchButton addTarget:self action:@selector(searchButtonclick) forControlEvents:UIControlEventTouchUpInside];
//    return rootimageview;
//    
//    
//    
//}
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