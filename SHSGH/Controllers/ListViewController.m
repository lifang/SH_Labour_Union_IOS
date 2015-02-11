//
//  ListViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ListViewController.h"
#import "navbarView.h"
#import "ListTableViewCell.h"
#import "people.h"

#import "DituViewController.h"
@interface ListViewController ()

@end

@implementation ListViewController
- (void)viewWillAppear:(BOOL)animated


{ [super viewWillAppear:animated];
    
    
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    [_allarry removeAllObjects];
    
    
    
    _locationManager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        [self showMessage:@"定位服务当前可能尚未打开，请设置打开" viewHeight:SCREEN_HEIGHT/2-80];

        return;
    }
    
    //如果没有授权则请求用户授权
  
    else {
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=100.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style: UITableViewStylePlain];
  
    
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=70;
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
    
    _Seatchtable.tableFooterView = [[UIView alloc]init];

   
   
    [ self setnavBar];
    [ self setNavBar];
    

   }

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    
    per_lon=[NSString stringWithFormat:@"%f",coordinate.longitude];
    
    per_lat=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
    
    _searchers =[[BMKGeoCodeSearch alloc]init];
    _searchers.delegate = self;
    
    
    CLLocationCoordinate2D pt =coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flagf = [_searchers reverseGeoCode:reverseGeoCodeSearchOption];
    if(flagf)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    

    [self date];

    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
        
    {
        city=result.addressDetail.city;
        
        NSLog(@"%@",result.addressDetail.city);
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _allarry.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    people*pp=[_allarry objectAtIndex:indexPath.row];
    
    cell.namelable.text=pp.namestring;
    
    cell.addresslable.text=pp.addrstring;
    
   
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DituViewController*ditu=[[DituViewController alloc]init];
    people*pp=[_allarry objectAtIndex:indexPath.row];
   
    ditu.name=pp.namestring;
    ditu.address=pp.addrstring;

    ditu.city=city;
    
    [self.navigationController pushViewController:ditu animated:YES];
    
//    people*pp=[_allarry objectAtIndex:indexPath.row];
//    changeA=pp.ids;
    
//    [self detaldate];
    
    
}
#pragma mark - 获取网络数据
-(void)date
{
    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载...";
    [HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
          urls =[NSString stringWithFormat:@"/api/merchant/findOtherMerchants?id=%@&per_lon=%@&per_lat=%@",self.ids,per_lon,per_lat];
            
      
        
        
        
        
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD removeFromSuperview];
            
            [_Seatchtable headerEndRefreshing];
            [_Seatchtable footerEndRefreshing]; 
            
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
             
                NSArray* arry= [[NSArray alloc]initWithArray:[result objectForKey:@"result"]];
                
                for(int i=0;i<arry.count;i++)
                {
                    
                    people*peo=[[people alloc]init];
                    
                    peo.addrstring=[[arry objectAtIndex:i] objectForKey:@"addr"];
                    peo.ids=[[[arry objectAtIndex:i] objectForKey:@"id"] intValue];
                    
                    peo.namestring=[[arry objectAtIndex:i] objectForKey:@"name"];
                    
                    
                    [_allarry addObject:peo];
                    
                }
//                totalCount = [[[result objectForKey:@"result"] objectForKey:@"total"] integerValue];
                
                if (_allarry.count!=0)
                {
                    
                    [_Seatchtable reloadData];
                    
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
//-(void)detaldate
//{
//    MBProgressHUD*HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
//    
//    [self.view addSubview:HUD];
//    
//    HUD.labelText = @"正在加载...";
//    [HUD show:YES];
//    
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        NSString*changeurl=[NSString stringWithFormat:@"/api/service/center/info?id=%ld",(long)changeA];
//        
//        id result = [KRHttpUtil getResultDataByPost:changeurl param:nil];
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [HUD removeFromSuperview];
//            
//            [_Seatchtable headerEndRefreshing];
//            [_Seatchtable footerEndRefreshing];
//            
//            
//            if ([[result objectForKey:@"code"] integerValue]==0)
//            {
//                //                NSArray*arry=[result objectForKey:@"result"] ;
//                
//                
//                OrganizationdetalViewController*detal=[[OrganizationdetalViewController alloc]init];
//                
//                
//                detal.name=[[result objectForKey:@"result"]  objectForKey:@"addr"];
//                
//                detal.tel=[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"]  objectForKey:@"tel"]];
//                detal.address=[[result objectForKey:@"result"]  objectForKey:@"name"];
//                NSLog(@"%@",detal.name);
//                
//                
//                [self.navigationController pushViewController:detal animated:YES];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                
//            }
//            
//            
//            else
//            {
//                NSString *reason = @"请求超时或者网络环境较差!";
//                if (![KRHttpUtil checkString:reason])
//                {
//                    reason = @"请求超时或者网络环境较差!";
//                }
//                
//                
//                [self showMessage:reason viewHeight:SCREEN_HEIGHT/2-80];
//                
//                
//                
//                
//                
//            }
//        });
//    });
//}


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
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
