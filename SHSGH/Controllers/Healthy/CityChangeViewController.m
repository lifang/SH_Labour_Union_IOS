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

@interface CityChangeViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)NSMutableArray *provinceArray;

@property(nonatomic,strong)NSMutableArray *downtownArray;

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
    [self loadData];
    [self setupNavBar];
    [self initUI];
}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/health/findAllCity";
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
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
                SLog(@"省数组为+++++++++++++++++++%@",_provinceArray);
            }
            else {
                SLog(@"请求失败!");
              
            }
        });
    });

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
        SLog(@"%@",downtown.area_name);
        [self.delegate sendCity:downtown.area_name];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        SLog(@"点击了左边!");
        Province *provice = [_provinceArray objectAtIndex:indexPath.row];
        SLog(@"%@",provice.city_area_id);
        [self cityForProvinceID:provice.city_area_id];
        [self.rightTableView reloadData];
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


@end
