//
//  HealthyHomeViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "HealthyHomeViewController.h"
#import "navbarView.h"
#import "ReuseView.h"
#import "EGOImageView.h"
#import "cellBtn.h"
#import "HHZSearchBar.h"
#import "CityChangeViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"
#import "ChoiceHospitalViewController.h"
#import "ClassViewController.h"
#import "DoctorListViewController.h"
#import "Province.h"
#import "Downtown.h"

@interface HealthyHomeViewController ()<ReuseViewDelegate,sendHospital,sendClass,sendCity>
@property(nonatomic,strong)CityChangeViewController *cityVC;
@property(nonatomic,strong)UILabel *hospitalLabel;
@property(nonatomic,strong)UILabel *classLabel;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *cpid;
@property(nonatomic,strong)NSString *hospitalid;
@property(nonatomic,strong)NSString *deptid;
@property(nonatomic,strong)NSString *cityArea_Id;

@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSMutableArray *downtownArray;
@end

@implementation HealthyHomeViewController

-(NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

-(NSMutableArray *)downtownArray
{
    if (!_downtownArray) {
        _downtownArray = [NSMutableArray array];
    }
    return _downtownArray;
}

-(CityChangeViewController *)cityVC
{
    if (!_cityVC) {
        _cityVC = [AppDelegate shareCityController];
    }
    return _cityVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initUI];
    [self setupNav];
    
    SLog(@"&&&&&&&&&&&&&&&&&&%@",_hospitalid);
}


-(void)sendCity:(NSString *)city WithArea_id:(NSString *)area_id
{
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    delegate.area_id = area_id;
    self.cityName = city;
    self.cityArea_Id = area_id;
    [self setupNav];
}


#pragma mark - 自动定位
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cityVC.delegate = self;
    [self setupNav];
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    if (delegate.area_id==nil) {
        [self sendCity:_cityName WithArea_id:_cityArea_Id];
    }
    
    _allarry=[[NSMutableArray alloc]initWithCapacity:0];
    [_allarry removeAllObjects];
    _locationManager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        [self showMessage:@"定位服务当前可能尚未打开，请设置打开" viewHeight:SCREEN_HEIGHT/2-80];
        
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
        
    {
        if(iOS7)
        {
            [_locationManager requestWhenInUseAuthorization];
        }
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=100.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        if (!_cityName) {
            //启动跟踪定位
            [_locationManager startUpdatingLocation];
        }

    }
    else {
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=100.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        if (!_cityName) {
            //启动跟踪定位
            [_locationManager startUpdatingLocation];
        }
        
    }
    
}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/health/findAllCity";
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                if (![result objectForKey:@"result"] || ![[result objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                    return;
                }
                NSArray *cityArray = [result objectForKey:@"result"];
                for (int i = 0; i < cityArray.count; i++) {
                    NSDictionary *cityInfo = [cityArray objectAtIndex:i];
                    Province *province = [[Province alloc]init];
                    province.city_name = [cityInfo objectForKey:@"city_name"];
                    province.city_area_id = [NSString stringWithFormat:@"%@",[cityInfo objectForKey:@"city_area_id"]];
                    [self.provinceArray addObject:province];
                    NSArray *children = [cityInfo objectForKey:@"childrens"];
                    for (int i=0; i<children.count; i++) {
                        NSDictionary *downDic = [children objectAtIndex:i];
                        Downtown *downtown = [[Downtown alloc]init];
                        downtown.area_id = [downDic objectForKey:@"area_id"];
                        downtown.area_name = [downDic objectForKey:@"area_name"];
                        [self.downtownArray addObject:downtown];
                    }
                }
                SLog(@"~~~~~~~~~~~~~%ld",_provinceArray.count);
                SLog(@"~~~~~~~~~~~~%ld",_downtownArray.count);
                [self searchCityID];
            }
            else {
                SLog(@"请求失败!");
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        });
    });
}

-(void)searchCityID
{
    for (int i = 0; i<_provinceArray.count;i++) {
        Province *pro = [_provinceArray objectAtIndex:i];
        if ([pro.city_name isEqualToString:_cityName]) {
            AppDelegate *delegate = [AppDelegate shareAppDelegate];
            delegate.area_id = pro.city_area_id;
        }
    }
    
    for (int i = 0; i<_downtownArray.count; i++) {
        Downtown *dow = [_downtownArray objectAtIndex:i];
        if ([dow.area_name isEqualToString:_cityName]) {
            AppDelegate *delegate = [AppDelegate shareAppDelegate];
            delegate.area_id = dow.area_id;
        }
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



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    
    per_lon=[NSString stringWithFormat:@"%f",coordinate.longitude];
    
    per_lat=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
    
    _searchers =[[BMKGeoCodeSearch alloc]init];
    _searchers.delegate = self;
    
    
    CLLocationCoordinate2D pt =coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
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
    
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
        
    {
        cityLocateName=result.addressDetail.city;
        provinceLocateName = result.addressDetail.province;
        self.cityVC.province = provinceLocateName;
        self.cityVC.downtown = cityLocateName;
         NSLog(@"省为==%@,市为==%@",provinceLocateName,cityLocateName);
        _cityName = cityLocateName;
        if (!cityLocateName) {
            _cityName = provinceLocateName;
        }
        [self setupNav];
        [self searchCityID];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

-(void)initUI
{
   
    //广告条
    UIImage *image1 = [UIImage imageNamed:@"healthyMain1"];
    UIImage *image2 = [UIImage imageNamed:@"healthyMain2"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:image1,image2, nil];
    ReuseView *scrollView = [[ReuseView alloc]initWithFrame:CGRectMake(0, 0, mainScreenW, 160) array:arr];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = sColor(62, 159, 136, 1.0);
    scrollView.reuseDelegate = self;
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(0, 130, mainScreenW, 30);
    view1.backgroundColor = sColor(255, 255, 255, 0.5);
    [scrollView addSubview:view1];
    [self.view addSubview:scrollView];
    CGFloat cellHeight = 50.f;
    //搜索栏
    UIView *searchView = [[UIView alloc]init];
    UISearchBar *search = [[UISearchBar alloc]init];
    search.backgroundImage = [UIImage resizedImage:@"searchbar_textfield_background"];
    search.placeholder = @"请输入搜索医院、医生";
    search.frame = CGRectMake(15, 10, mainScreenW * 0.9, cellHeight - 15);
    [searchView addSubview:search];
    searchView.backgroundColor = sColor(233, 235, 240, 1.0);
    searchView.frame = CGRectMake(0, CGRectGetMaxY(scrollView.frame) + 2 * CostumViewMargin, mainScreenW, cellHeight + 10);
    UIButton *searchClike = [[UIButton alloc]init];
    [searchClike setBackgroundColor:[UIColor clearColor]];
    [searchClike addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    searchClike.frame = searchView.frame;
    [self.view addSubview:searchView];
    [self.view addSubview:searchClike];
    //First分割线
    UIView *firstLine = [[UIView alloc]init];
    firstLine.backgroundColor = sColor(201, 201, 201, 1.0);
    firstLine.frame = CGRectMake(0, CGRectGetMaxY(searchView.frame), mainScreenW, 1);
    [self.view addSubview:firstLine];
    //医院View
    cellBtn *hospitalView = [[cellBtn alloc]init];
    [hospitalView.clickBtn addTarget:self action:@selector(hospitalClick) forControlEvents:UIControlEventTouchUpInside];
    hospitalView.leftImg.image = [UIImage imageNamed:@"choseHospital"];
    hospitalView.contentLabel.text = @"请选择医院";
    hospitalView.contentLabel.backgroundColor = [UIColor clearColor];
    _hospitalLabel = hospitalView.contentLabel;
    hospitalView.backgroundColor = sColor(233, 235, 240, 1.0);
    hospitalView.frame = CGRectMake(0, CGRectGetMaxY(firstLine.frame), mainScreenW, cellHeight + 5);
    [self.view addSubview:hospitalView];
    //Second分隔线
    UIView *secondLine = [[UIView alloc]init];
    secondLine.backgroundColor = sColor(201, 201, 201, 1.0);
    secondLine.frame = CGRectMake(0, CGRectGetMaxY(hospitalView.frame), mainScreenW, 1);
    [self.view addSubview:secondLine];
    //科室View
    cellBtn *classView = [[cellBtn alloc]init];
    [classView.clickBtn addTarget:self action:@selector(classClick) forControlEvents:UIControlEventTouchUpInside];
    classView.leftImg.image = [UIImage imageNamed:@"choseKeshi"];
    classView.contentLabel.text = @"请选择科室";
    classView.contentLabel.backgroundColor = [UIColor clearColor];
    _classLabel = classView.contentLabel;
    classView.backgroundColor = sColor(233, 235, 240, 1.0);
    classView.frame = CGRectMake(0, CGRectGetMaxY(secondLine.frame), mainScreenW, cellHeight + 5);
    [self.view addSubview:classView];
    //Third分隔线
    UIView *thirdLine = [[UIView alloc]init];
    thirdLine.backgroundColor = sColor(201, 201, 201, 1.0);
    thirdLine.frame = CGRectMake(0, CGRectGetMaxY(classView.frame), mainScreenW, 1);
    [self.view addSubview:thirdLine];
    //切换城市
    UIButton *cityBtn = [[UIButton alloc]init];
    [cityBtn addTarget:self action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
    [cityBtn setBackgroundImage:[UIImage imageNamed:@"doctor_bg_white"] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [cityBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cityBtn setTitle:@"切换城市" forState:UIControlStateNormal];
    cityBtn.frame = CGRectMake(mainScreenW * 0.2 - 10, CGRectGetMaxY(thirdLine.frame) + 6 * CostumViewMargin, 140 * 0.7, 54 * 0.7);
    [self.view addSubview:cityBtn];
    //查找医生
    UIButton *doctorBtn = [[UIButton alloc]init];
    [doctorBtn addTarget:self action:@selector(doctorClick) forControlEvents:UIControlEventTouchUpInside];
    [doctorBtn setBackgroundImage:[UIImage imageNamed:@"doctor_bg"] forState:UIControlStateNormal];
    doctorBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [doctorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doctorBtn setTitle:@"查找医生" forState:UIControlStateNormal];
    doctorBtn.frame = CGRectMake(CGRectGetMaxX(cityBtn.frame) + 8 * CostumViewMargin, CGRectGetMaxY(thirdLine.frame) + 6 * CostumViewMargin, 140 * 0.7, 54 * 0.7);
    [self.view addSubview:doctorBtn];
}

-(void)searchClick
{
    SLog(@"点击了searchBar!");
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.rightCity = _cityName;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)cityClick
{
    _classLabel.text = @"请选择科室";
    _hospitalLabel.text = @"请选择医院";
    SLog(@"点击了切换城市!");
    [self.navigationController pushViewController:_cityVC animated:YES];
}

-(void)doctorClick
{
    SLog(@"点击了查找医生!");
    //输入验证
    if ([_hospitalLabel.text isEqualToString:@"请选择医院"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请先选择医院!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([_classLabel.text isEqualToString:@"请选择科室"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请选择科室!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    DoctorListViewController *docVC = [[DoctorListViewController alloc]init];
    docVC.hospitalname = _hospitalLabel.text;
    docVC.classname = _classLabel.text;
    docVC.cpid = _cpid;
    docVC.deptid = _deptid;
    docVC.hospitalid = _hospitalid;
    [self.navigationController pushViewController:docVC animated:YES];
    
    _classLabel.text = @"请选择科室";
    _hospitalLabel.text = @"请选择医院";

}


-(void)hospitalClick
{
    SLog(@"点击了选择医院!");
    ChoiceHospitalViewController *choiceHospitalVC = [[ChoiceHospitalViewController alloc]init];
    choiceHospitalVC.delegate = self;
    [self.navigationController pushViewController:choiceHospitalVC animated:YES];
}

-(void)sendHospital:(NSString *)hospital WithCpid:(NSString *)cpid WithHospitalid:(NSString *)hospitalid
{
    _hospitalLabel.text = hospital;
    self.cpid = cpid;
    self.hospitalid = hospitalid;
    
    SLog(@"%@  %@",_cpid,_hospitalid);
}

-(void)classClick
{
    
    if (_hospitalid==nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请先选择医院!" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil, nil];
        [alertView show];
        return;
                                
    }
    SLog(@"点击了选择科室!");
    ClassViewController *classVC = [[ClassViewController alloc]init];
    classVC.selected = YES;
    classVC.hospitalid = _hospitalid;
    classVC.cpid = _cpid;
    classVC.delegate = self;
    [self.navigationController pushViewController:classVC animated:YES];
}

-(void)sendClass:(NSString *)className WithDeptid:(NSString *)deptid
{
    _classLabel.text = className;
    self.deptid = deptid;
}


-(void)setupNav
{
    self.title = @"健康服务";
    self.view.backgroundColor = sColor(235, 235, 240, 1.0);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"doctor_BG@2x(1)-1"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeDoctor];
    [buttonL.navButton setTitle:_cityName forState:UIControlStateNormal];
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    SLog(@"~~~~~~~~~~~~~~~~~~~%@",delegate.cityName);
    SLog(@"~~~~~~~~~~~~~~~~~~~%@",_cityName);
    if (delegate.cityName) {
        [buttonL.navButton setTitle:delegate.cityName forState:UIControlStateNormal];
    }
    [buttonL.navButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.rightBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonR.navButton setImage:[UIImage imageNamed:@"right_tarBar"]forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.leftBarButtonItem = rightItem;
    
}

-(void)rightClick
{
    SLog(@"选择地点!");
    _cityVC.provinceArray = _provinceArray;
    _cityVC.cityZero = _cityName;
    [self.navigationController pushViewController:_cityVC animated:YES];
}

-(void)leftClick
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - ScrollView didSelect
-(void)handleTop:(UITapGestureRecognizer *)imageView
{
    //    UIButton *mainClick = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainScreenW, mainScreenH)];
    //    [mainClick addTarget:self action:@selector(clickedBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [mainClick becomeFirstResponder];
    //    self.clickBtn = mainClick;
    //
    //    int ids = (int)imageView.view.tag - 101;
    //    EGOImageView *bigV = [[EGOImageView alloc]init];
    //    bigV.userInteractionEnabled = YES;
    //    bigV.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_bigArray[ids]]];
    //    bigV.backgroundColor = [UIColor clearColor];
    //    bigV.frame = CGRectMake(0, 0, mainScreenW, mainScreenH);
    //    [self.view addSubview:bigV];
    //    [self.view addSubview:mainClick];
    //    self.bigView = bigV;
    SLog(@"点击了图片!");
}

@end
