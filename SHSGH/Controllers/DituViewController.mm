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

#import "AppDelegate.h"
@interface DituViewController ()

@end

@implementation DituViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"地图详情";
    
    [ self setnavBar];
    [ self setNavBar];
    
    [self createui];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    
    NSString *address=@"独墅村";
    
  
    
    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            //                  self.detailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
        }
        
        else   //  编码成功，找到了具体的位置信息
        {
            //打印查看找到的所有的位置信息
            /*
             61                     name:名称
             62                     locality:城市
             63                     country:国家
             64                     postalCode:邮政编码
             65                  */
            for (CLPlacemark *placemark in placemarks)
            
            
            {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            }
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
            //                                 self.detailAddressLabel.text=firstPlacemark.name;
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            
           
            per_lat=latitude ;
            
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            //                         NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            per_lon= longitude ;

        }
    }];
    

}
- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = per_lat;
    coor.longitude = per_lon;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView setCenterCoordinate:coor];

    
    
    [_mapView addAnnotation:annotation];
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

}

-(void)createui
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-124)];
    [self.view  addSubview: _mapView];
    _mapView.zoomLevel = 7;

    UIView*backview=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-124, SCREEN_WIDTH, 60)];
    backview.backgroundColor=[UIColor whiteColor];
//    [_mapView sendSubviewToBack:backview];
    
    
    [_mapView addSubview:backview];
    UILabel*namelab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_HEIGHT-120, 30)];
    [backview addSubview:namelab];
    namelab.text=@"风格";
    
    
    UILabel*addresslab=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, SCREEN_HEIGHT-120, 20)];
    [backview addSubview:addresslab];

    addresslab.text=@"风格dfgr";
    addresslab.textColor=[UIColor grayColor];
    
    
    
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
    [self.navigationController pushViewController:route animated:YES];
    

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
