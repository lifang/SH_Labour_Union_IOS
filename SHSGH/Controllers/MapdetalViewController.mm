//
//  MapdetalViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "MapdetalViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
@interface MapdetalViewController ()

@end

@implementation MapdetalViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_mapViews viewWillAppear];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    _mapViews.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//    [BMKLocationService setLocationDistanceFilter:100.f];
//    
//    
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
//    
//    
//    //发起正向地理编码检索
//    
//    _searchers =[[BMKGeoCodeSearch alloc]init];
//    _searchers.delegate = self;
//    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//    geoCodeSearchOption.city= @"北京";
//    geoCodeSearchOption.address = @"海淀区上地10街10号";
//    BOOL flag = [_searchers geoCode:geoCodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"geo检索发送失败");
//    }
//    
}
- (void) viewDidAppear:(BOOL)animated {
//    // 添加一个PointAnnotation
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = per_lat;
//    coor.longitude = per_lon;
//    annotation.coordinate = coor;
//    annotation.title = @"这里是北京";
//    [_mapView setCenterCoordinate:coor];
//    
//    
//    
//    [_mapView addAnnotation:annotation];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapViews viewWillDisappear];

    _mapViews.delegate = nil; // 不用时，置nil
    _mapViews=nil;
    _searcher=nil;
    _locService=nil;
    _locService.delegate=nil;
    _searchers.delegate = nil;
    
  
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ self setnavBar];
    [ self setNavBar];
    _mapViews = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view  addSubview: _mapViews];
    _mapViews.zoomLevel = 14;
    [self  clickwhichway];
    [_mapViews setCenterCoordinate:self.coreld];

    // Do any additional setup after loading the view.
}
#pragma mark - bus car walk
-(void)clickwhichway

{
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    if(self.awhichway==3)
    {
      
        
        //发起检索
        
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        start.pt=self.coreld;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.name = self.name;
        
        BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
        transitRouteSearchOption.city= self.city;
        transitRouteSearchOption.from = start;
        transitRouteSearchOption.to = end;
        BOOL flag = [_searcher transitSearch:transitRouteSearchOption];
        if(flag)
        {
            
            
        }
        else
        {
            
            [self showMessage:@"无合适公交" viewHeight:SCREEN_HEIGHT/2-80];
            
            
        }
        
        
        start = nil;end=nil;
        transitRouteSearchOption = nil;
    
    
    }
    
    
    
    
    if(self.awhichway==2)
    {
        
        
        //发起检索
        
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        start.pt=self.coreld;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.name = self.name;
        
        BMKDrivingRoutePlanOption *transitRouteSearchOptions = [[BMKDrivingRoutePlanOption alloc]init];
        transitRouteSearchOptions.from = start;
        transitRouteSearchOptions.to = end;
        BOOL flag = [_searcher drivingSearch:transitRouteSearchOptions];
        if(flag)
        {
            
            
        }
        else
        {
            
            [self showMessage:@"无合适路线" viewHeight:SCREEN_HEIGHT/2-80];
            
            
        }
        
        
        start = nil;end=nil;
        transitRouteSearchOptions = nil;
        
        
    }
    
    
    
    
    if(self.awhichway==1)
    {
        
        
        //发起检索
        
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        start.pt=self.coreld;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.name = self.name;
        
        BMKWalkingRoutePlanOption *transitRouteSearchOptions = [[BMKWalkingRoutePlanOption alloc]init];
        transitRouteSearchOptions.from = start;
        transitRouteSearchOptions.to = end;
        BOOL flag = [_searcher walkingSearch:transitRouteSearchOptions];
        if(flag)
        {
            
            
        }
        else
        {
            
            [self showMessage:@"无合适路线" viewHeight:SCREEN_HEIGHT/2-80];
            
            
        }
        
        
        start = nil;end=nil;
        transitRouteSearchOptions = nil;
        
        
    }
    

    
    
    
    
    
    
    
}
#pragma mark - 标注
//- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
}

-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:    (BMKTransitRouteResult*)result
                     errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapViews.annotations];
    [_mapViews removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapViews.overlays];
    [_mapViews removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR)
        
    {
        
        BMKTransitRouteLine* planl = (BMKTransitRouteLine*)[result.routes objectAtIndex: self.bline];
        
      
            NSInteger size = [planl.steps count];
            int planPointCounts = 0;
            for (int i = 0; i < size; i++) {
                BMKTransitStep* transitStep = [planl.steps objectAtIndex:i];
                if(i==0){
                    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                    item.coordinate = planl.starting.location;
                    item.title = @"起点";
                    NSLog(@"----%f",planl.starting.location.latitude);
                    
                    
                    [_mapViews addAnnotation:item]; // 添加起点标注
                    
                    item=nil;

                }else if(i==size-1){
                    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                    item.coordinate = planl.terminal.location;
                    item.title = @"终点";
                    //                item.type = 1;
                    [_mapViews addAnnotation:item]; // 添加起点标注
                    item=nil;

                }
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item.coordinate = transitStep.entrace.location;
                item.title = transitStep.instruction;
                //            item.type = 3;
                [_mapViews addAnnotation:item];
                item=nil;

                //轨迹点总数累计
                planPointCounts += transitStep.pointsCount;
            }
            //轨迹点
            BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
            int i = 0;
            for (int j = 0; j < size; j++) {
                BMKTransitStep* transitStep = [planl.steps objectAtIndex:j];
                int k=0;
                for(k=0;k<transitStep.pointsCount;k++) {
                    temppoints[i].x = transitStep.points[k].x;
                    temppoints[i].y = transitStep.points[k].y;
                    i++;
                }
            }
            // 通过points构建BMKPolyline
            BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
            [_mapViews addOverlay:polyLine]; // 添加路线overlay
            delete []temppoints;
        }
    
    
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    NSArray* array = [NSArray arrayWithArray:_mapViews.annotations];
    [_mapViews removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapViews.overlays];
    [_mapViews removeOverlays:array];
  
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                [_mapViews addAnnotation:item]; // 添加起点标注
                item=nil;
                
            }else if(i==size-1){
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";

                [_mapViews addAnnotation:item]; // 添加起点标注
                item=nil;
            }
            //添加annotation节点
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            [_mapViews addAnnotation:item];
            item=nil;
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item = [[BMKPointAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.title = tempNode.name;
                [_mapViews addAnnotation:item];
                item=nil;
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapViews addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        
        
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapViews.annotations];
    [_mapViews removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapViews.overlays];
    [_mapViews removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                [_mapViews addAnnotation:item]; // 添加起点标注
                item=nil;
                
            }else if(i==size-1){
                BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                [_mapViews addAnnotation:item]; // 添加起点标注
                item=nil;
            }
            //添加annotation节点
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            [_mapViews addAnnotation:item];
            item=nil;
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapViews addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if ([self.view window] == nil){
        _mapViews.delegate = nil; // 不用时，置nil
        _mapViews=nil;
        _searcher=nil;
        
        _searchers.delegate = nil;
        self.view = nil;
    }

   

    
    // Dispose of any resources that can be recreated.
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
    _locService=nil;
    _locService.delegate=nil;

    _mapViews.delegate = nil; // 不用时，置nil
    _mapViews=nil;
    _searcher=nil;
    
    _searchers.delegate = nil;

    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
