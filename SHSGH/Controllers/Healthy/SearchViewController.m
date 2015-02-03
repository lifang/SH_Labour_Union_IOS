//
//  SearchViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchViewController.h"
#import "navbarView.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SearchViewController

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initUI];
}

-(void)initUI
{
    CGFloat topMargin = 15.f;
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",nil];
    UISegmentedControl *segmentView = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentView.frame = CGRectMake(-2, topMargin, mainScreenW + 4, 32);
    segmentView.tintColor = sColor(59, 132, 254, 1.0);
    segmentView.momentary = NO;
    [segmentView setTitle:@"搜索医院" forSegmentAtIndex:0];
    [segmentView setTitle:@"搜索医生" forSegmentAtIndex:1];
    [segmentView addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentView.selectedSegmentIndex = 0;
    [self.view addSubview:segmentView];
    
    //搜索栏
    UIView *searchView = [[UIView alloc]init];
    UISearchBar *search = [[UISearchBar alloc]init];
    search.backgroundImage = [UIImage resizedImage:@"searchbar_textfield_background"];
    search.placeholder = @"请输入搜索医院丶医生";
    search.frame = CGRectMake(15, 10, mainScreenW * 0.9, 35);
    [searchView addSubview:search];
    searchView.backgroundColor = sColor(233, 235, 240, 1.0);
    searchView.frame = CGRectMake(0, CGRectGetMaxY(segmentView.frame) , mainScreenW, 35);
    [self.view addSubview:searchView];
    
    self.tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(searchView.frame) + 5 * CostumViewMargin, mainScreenW, mainScreenH - CGRectGetMaxY(searchView.frame) - 2 *CostumViewMargin);
    _tableView.backgroundColor = mainScreenColor;
    [self.view addSubview:_tableView];
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    SLog(@"Idex %ld",Index);
    switch (Index) {
        case 0:
            [self selectedHospital];
            break;
        case 1:
            [self selectedDoctor];
            break;
            
        default:
            break;
    }
}

-(void)selectedHospital
{
    SLog(@"选择了医院!");
}

-(void)selectedDoctor
{
    SLog(@"选择了医生!");
}


-(void)setNavBar
{
    self.title = @"搜索";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"doctor_back"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;

}

-(void)backtoHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"search";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text = @"上海长征医院";
    }
    return cell;
}


@end
