//
//  CityChangeViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "CityChangeViewController.h"
#import "navbarView.h"
#import "CityCell.h"
#import "Province.h"
#import "Downtown.h"
#import "AppDelegate.h"

@interface CityChangeViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,assign)NSInteger provinceIndex;
@property(nonatomic,assign)NSInteger downtownIndex;
@property(nonatomic,strong)NSString *procityID;


@end

@implementation CityChangeViewController

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setStyle];
    [self loadData];
    [self setupNavBar];
    [self initUI];
    
}
-(void)setStyle
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.leftTableView.tableFooterView = view;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    self.rightTableView.tableFooterView = view1;
}
-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/health/findAllCity";
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *cityArray = [result objectForKey:@"result"];
                self.dataArray = cityArray;
                
                for (int i = 0; i < cityArray.count; i++) {
                    NSDictionary *cityInfo = [cityArray objectAtIndex:i];
                    Province *province = [[Province alloc]init];
                    province.city_name = [cityInfo objectForKey:@"city_name"];
                    province.city_area_id = [NSString stringWithFormat:@"%@",[cityInfo objectForKey:@"city_area_id"]];
                    [self.provinceArray addObject:province];
                    
//                    NSArray *children = [cityInfo objectForKey:@"childrens"];
                }
                [self.leftTableView reloadData];
                
                if (_province&&_downtown&&_provinceArray) {
                    [self findIndexPath];
                    NSIndexPath *left = [NSIndexPath indexPathForRow:_provinceIndex inSection:0];
                    [self.leftTableView selectRowAtIndexPath:left animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                    if (_downtownArray.count!=0) {
                        NSIndexPath *right = [NSIndexPath indexPathForRow:_downtownIndex inSection:0];
                        [self.rightTableView selectRowAtIndexPath:right animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                    }
                    Province *province = [_provinceArray objectAtIndex:_provinceIndex];
                    [self.delegate sendCity:province.city_name WithArea_id:province.city_area_id];
                    if (_downtownArray!=0) {
                        Downtown *downtown = [_downtownArray objectAtIndex:_downtownIndex];
                        SLog(@"~~~~~~~~~~~~~~~~~~%@",downtown.area_id);
                        [self.delegate sendCity:downtown.area_name WithArea_id:downtown.area_id];
                    }
                }
            }
            else {
                SLog(@"请求失败!");
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        });
    });
}

-(void)findIndexPath
{
    for (int i = 0; i < _provinceArray.count; i++) {
        Province *pro = [_provinceArray objectAtIndex:i];
        if ([pro.city_name isEqualToString:_province]) {
            SLog(@"%d",i);
            self.provinceIndex = i;
            SLog(@"%@",pro.city_area_id);
            self.procityID = pro.city_area_id;
            break;
        }
    }
    [self cityForProvinceID:_procityID];
    [self.rightTableView reloadData];
    
    
    NSArray *cityArray = nil;
    for (NSDictionary *provinceInfo in _dataArray) {
        NSString *province_id = [NSString stringWithFormat:@"%@",[provinceInfo objectForKey:@"city_area_id"]];
        if ([province_id isEqualToString:_procityID]) {
            cityArray = [provinceInfo objectForKey:@"childrens"];
            break;
        }
    }
    SLog(@"*********************%@",cityArray);
    
    for (int i = 0; i < cityArray.count; i++) {
        if ([[[cityArray objectAtIndex:i] objectForKey:@"area_name"]isEqualToString:_downtown]) {
            SLog(@"市的位置-------------------- %d",i);
            self.downtownIndex = i;
            break;
        }
    }
    
}

-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]init];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]init];
    }
    return _rightTableView;
}

-(void)initUI
{
    self.leftTableView.frame = CGRectMake(0, 0, mainScreenW * 0.6, mainScreenH);
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.tag = 1001;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_leftTableView];
    self.rightTableView.frame = CGRectMake(mainScreenW * 0.6, 0, mainScreenW * 0.4, mainScreenH);
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.tag = 1002;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_rightTableView];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = sColor(206, 206, 206, 1.0);
    lineView.frame = CGRectMake(mainScreenW *0.6, 0, 1, mainScreenH);
    [self.view addSubview:lineView];
}

-(void)setupNavBar
{
    self.title = @"城市切换";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"doctor_back"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backNavBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;

}

-(void)backNavBar
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1001) {
        return _provinceArray.count;
    }
    else{

    return _downtownArray.count;
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [CityCell cellWithTableView:tableView];
    if (tableView.tag == 1001) {
        Province *provice = [_provinceArray objectAtIndex:indexPath.row];
        cell.textLabel.text = provice.city_name;
        cell.backgroundColor = sColor(236, 236, 236, 1.0);
    }
    if (tableView.tag == 1002) {
        Downtown *downtown = [_downtownArray objectAtIndex:indexPath.row];
        cell.textLabel.text = downtown.area_name;
        cell.backgroundColor = sColor(236, 236, 236, 1.0);
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1002) {
        SLog(@"点击了右边!");
        Downtown *downtown = [_downtownArray objectAtIndex:indexPath.row];
        AppDelegate *delegate = [AppDelegate shareAppDelegate];
        delegate.area_id = downtown.area_id;
        [self.delegate sendCity:downtown.area_name WithArea_id:downtown.area_id];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        SLog(@"点击了左边!");
        Province *provice = [_provinceArray objectAtIndex:indexPath.row];
        SLog(@"%@",provice.city_area_id);
        AppDelegate *delegate = [AppDelegate shareAppDelegate];
        delegate.area_id = provice.city_area_id;
        delegate.province_name = provice.city_name;
        [self cityForProvinceID:provice.city_area_id];
        [self.rightTableView reloadData];
        if (_downtownArray.count == 0) {
            [self.delegate sendCity:provice.city_name WithArea_id:provice.city_area_id];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

-(void)cityForProvinceID:(NSString *)provinceID
{
    NSArray *cityArray = nil;
    for (NSDictionary *provinceInfo in _dataArray) {
        NSString *province_id = [NSString stringWithFormat:@"%@",[provinceInfo objectForKey:@"city_area_id"]];
        if ([province_id isEqualToString:provinceID]) {
            cityArray = [provinceInfo objectForKey:@"childrens"];
            break;
        }
    }
    if (cityArray) {
        
        if (self.downtownArray.count != 0) {
            [self.downtownArray removeAllObjects];
        }
        for (int i = 0; i < [cityArray count]; i++) {
            NSDictionary *cityInfo = [cityArray objectAtIndex:i];
            Downtown *downtown = [[Downtown alloc] init];
            downtown.area_name = [cityInfo objectForKey:@"area_name"];
            downtown.area_id = [NSString stringWithFormat:@"%@",[cityInfo objectForKey:@"area_id"]];
            
            [self.downtownArray addObject:downtown];
        }
        
        
    }

}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
