//
//  DituViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DituViewController.h"
#import "navbarView.h"
#import "BMapKit.h"
#import "Route ViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "AppDelegate.h"
@interface DituViewController ()

@end


@implementation DituViewController
-(void)viewWillAppear:(BOOL)animated
{
   
    NSLog(@"%@成功",self.city);

    
    
    
    [_mapView viewWillAppear];
    _linebusarry=[[NSMutableArray alloc]initWithCapacity:0];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    //发起正向地理编码检索
    
    _searchers =[[BMKGeoCodeSearch alloc]init];
    _searchers.delegate = self;
    
    
    
    
    
   
    
    
    
    
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= self.city;
    geoCodeSearchOption.address = self.address;
    NSLog(@"geo检索发送成功%@",self.address);

    
    BOOL flag = [_searchers geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}
- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"地图详情";
    
    [ self setnavBar];
    [ self setNavBar];
    
    [self createui];
    
    NSLog(@"%f",corld.latitude);
    
    // Do any additional setup after loading the view.
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
   
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    
       
    
    
    //发起检索
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt=userLocation.location.coordinate;
    corld=userLocation.location.coordinate;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = self.name;
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= self.city;
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_searcher transitSearch:transitRouteSearchOption];
    if(flag)
    {
        NSLog(@"%@",self.name);
        NSLog(@"%@",self.name);

        
    }
    else
    {
        
//        [self showMessage:@"无合适公交" viewHeight:SCREEN_HEIGHT/2-80];
        
        
    }
    

    
    
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

#pragma mark - BMKRouteSearchDelegate
-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:    (BMKTransitRouteResult*)result
                     errorCode:(BMKSearchErrorCode)error
{
    
   
    if (error == BMK_SEARCH_NO_ERROR)
        
    {
        [_linebusarry removeAllObjects];
        
        
        for(int i=0;i<result.routes.count;i++)
        {
            
            BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:i ];

        
        NSLog(@"----%@%d", plan.terminal.title,plan.duration.minutes);
        NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
        
        NSMutableArray*arry=[[NSMutableArray alloc]initWithCapacity:0];
        
        for(int i=0;i<plan.steps.count;i++)
        {
            
            
            BMKTransitStep*step=(BMKTransitStep*)[plan.steps objectAtIndex:i ];
            
            
            step.stepType=BMK_BUSLINE;
            
            
            
            if([self isBlankString:step.vehicleInfo.title])
            {
            
            
            }else
            {
                [arry addObject:step.vehicleInfo.title];

            
            }
            
          

        }
            [dict setValue:arry forKey:@"line"];
             [dict setValue:[NSString stringWithFormat:@"%.1f公里",plan.distance/1000.0] forKey:@"distance"];
            
            if([self isBlankString:[NSString stringWithFormat:@"%d",plan.duration.minutes]])
            {
            
                [dict setValue:[NSString stringWithFormat:@"%d小时",plan.duration.hours] forKey:@"time"];

            
            }
            if([self isBlankString:[NSString stringWithFormat:@"%d",plan.duration.hours]])
            {
                
                [dict setValue:[NSString stringWithFormat:@"%d分钟",plan.duration.minutes] forKey:@"time"];
                
                
            }
            else
            {
             [dict setValue:[NSString stringWithFormat:@"%d小时%d分钟",plan.duration.hours,plan.duration.minutes] forKey:@"time"];
            
            
            }
            
            [_linebusarry addObject:dict];
            
            
            
            
    }

}

    
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

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        per_lon=result.location.longitude;
        per_lat=result.location.latitude;

        
        
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        
        
      
        coor.latitude = per_lat;
        coor.longitude = per_lon;
        annotation.coordinate = coor;
        annotation.title = self.name;
        
        
        
        [_mapView addAnnotation:annotation];
        [_mapView setCenterCoordinate:coor];

        annotation=nil;
        

        NSLog(@"----%f",result.location.latitude);

        
        //在此处理正常结果
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        return newAnnotationView;
//    }
//    return nil;
//}
-(void)viewWillDisappear:(BOOL)animated
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _mapView=nil;
    _searchers=nil;
    _locService=nil;
    _locService.delegate=nil;
    
     _searchers.delegate = nil;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];


}

-(void)createui
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-124)];
    [self.view  addSubview: _mapView];
    _mapView.zoomLevel = 11;

    UIView*backview=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-124, SCREEN_WIDTH, 60)];
    backview.backgroundColor=[UIColor whiteColor];
//    [_mapView sendSubviewToBack:backview];
    
    
    [_mapView addSubview:backview];
    UILabel*namelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_HEIGHT-120, 30)];
    [backview addSubview:namelab];
    namelab.text=self.name;
    namelab.font=[UIFont systemFontOfSize:13];
    
    
    UILabel*addresslab=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, SCREEN_HEIGHT-120, 20)];
    [backview addSubview:addresslab];

    addresslab.text=self.address;
    addresslab.textColor=[UIColor grayColor];
    
    addresslab.font=[UIFont systemFontOfSize:12];

    
    UIButton*addrbutton=[[UIButton alloc]init];
    
    
    addrbutton.frame=CGRectMake(SCREEN_WIDTH-110,SCREEN_HEIGHT-110 ,100, 30);
    
    [addrbutton addTarget:self action:@selector(luxianclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addrbutton];
   addrbutton.userInteractionEnabled=YES;
//    self.view.userInteractionEnabled=YES;
//    backview.userInteractionEnabled=YES;
//
//_mapView.userInteractionEnabled=YES;
//
//    [ backview sendSubviewToBack:_mapView];
//    [addrbutton sendSubviewToBack:backview];
    

    
   
    addrbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [addrbutton setImage:[UIImage imageNamed:@"road"] forState:UIControlStateNormal];
    
   addrbutton.backgroundColor=[UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];

    [addrbutton setTitle:@" 查看路线" forState:UIControlStateNormal];

}
-(void)luxianclick
{
   
    
    
    
    Route_ViewController*route=[[Route_ViewController alloc]init];
    route.coreld=corld;
    route.city=self.city;
    route.address=self.address;
    route.name=self.name;

    route.linarry=_linebusarry;
    
    [self.navigationController pushViewController:route animated:YES];
    

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
