//
//  SearchViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchViewController.h"
#import "navbarView.h"
#import "UserTool.h"
#import "HospitalStatus.h"
#import "DoctorStatus.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *hospitalArray;

@property(nonatomic,strong)NSMutableArray *doctorsArray;

@property(nonatomic,strong)UISegmentedControl *segmentView;

@property(nonatomic,strong)NSString *doctorData;
@property(nonatomic,strong)NSString *hospitalData;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,assign)int page;

@property(nonatomic,strong)NSMutableArray *loadMoreHospitalArray;

@property(nonatomic,strong)NSMutableArray *loadMoreDoctorArray;


@end

@implementation SearchViewController



-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initUI];
    [self loadHospitalData];
    [self setupRefresh];
    self.page = 0;
}

-(void)setupRefresh
{
    //下拉
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses:) dateKey:@"table"];
    [self.tableView headerBeginRefreshing];
    //上拉
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @">.< 正在努力加载中!";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @">.< 正在努力加载中!";
    
}

-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    if (_segmentView.selectedSegmentIndex == 0) {
        [self loadHospitalData];
    }
    else
    {
        [self loadDoctorData];
    }
}

//-(void)loadMoreStatuses
//{
//    if (_segmentView.selectedSegmentIndex == 0) {
//        [_hospitalArray removeAllObjects];
//        [self loadMoreHospitalData];
//    }
//    else
//    {
//        [_doctorsArray removeAllObjects];
//        [self loadMoreDoctorData];
//    }
//}

-(void)loadMoreHospitalData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        _page++;
        NSString *pages = [NSString stringWithFormat:@"%d",_page];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findHospital?phone=%@&offset=%@&keyword=%@",account.phoneNum,pages,_searchBar.text];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                NSArray *hospitalArray = [result objectForKey:@"result"];
                for (int i = 0; i < hospitalArray.count; i++) {
                    _loadMoreHospitalArray = [NSMutableArray array];
                    HospitalStatus *status = [[HospitalStatus alloc]init];
                    status.cpid = (int)[[hospitalArray objectAtIndex:i] objectForKey:@"cpid"];
                    status.hospitalid =[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"];
                    status.hospitalleve = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalleve"];
                    status.hospitalname = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalname"];
                    [_loadMoreHospitalArray addObject:status];
                }
                [_hospitalArray addObjectsFromArray:_loadMoreHospitalArray];
                [self.tableView reloadData];
                [self.tableView footerEndRefreshing];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });

}

-(void)loadMoreDoctorData
{
    
}

-(void)loadHospitalData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findHospital?phone=%@&offset=%@&keyword=%@",account.phoneNum,@"0",_searchBar.text];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                _hospitalArray = [NSMutableArray array];
                NSArray *hospitalArray = [result objectForKey:@"result"];
                for (int i = 0; i < hospitalArray.count; i++) {
                    HospitalStatus *status = [[HospitalStatus alloc]init];
                    status.cpid = (int)[[hospitalArray objectAtIndex:i] objectForKey:@"cpid"];
                    status.hospitalid =[[hospitalArray objectAtIndex:i] objectForKey:@"hospitalid"];
                    status.hospitalleve = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalleve"];
                    status.hospitalname = [[hospitalArray objectAtIndex:i] objectForKey:@"hospitalname"];
                    [self.hospitalArray addObject:status];
                }
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });

}

-(void)loadDoctorData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserModel *account = [UserTool userModel];
        NSString *urls =[NSString stringWithFormat:@"/api/health/findDoctorByDeptId?phone=%@&offset=%@&cpid=%@&hospitalid=%@&deptid=%@&keyword=%@",account.phoneNum,@"0",@"2",@"1025133",@"7025988",_searchBar.text];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==0)
            {
                _doctorsArray = [NSMutableArray array];
                NSArray *doctorsArray = [result objectForKey:@"result"];
                for (int i = 0; i < doctorsArray.count; i++) {
                    DoctorStatus *doctors = [[DoctorStatus alloc]init];
                    doctors.cpid = (int)[[doctorsArray objectAtIndex:i] objectForKey:@"cpid"];
                    doctors.docid = (int)[[doctorsArray objectAtIndex:i] objectForKey:@"docid"];
                    doctors.docimageurl = [[doctorsArray objectAtIndex:i] objectForKey:@"docimageurl"];
                    doctors.doclevel = [[doctorsArray objectAtIndex:i] objectForKey:@"doclevel"];
                    doctors.docname = [[doctorsArray objectAtIndex:i] objectForKey:@"docname"];
                    [self.doctorsArray addObject:doctors];
                }
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });

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
    self.segmentView = segmentView;
    [self.view addSubview:segmentView];
    
    //搜索栏
    UIView *searchView = [[UIView alloc]init];
    UISearchBar *search = [[UISearchBar alloc]init];
    search.delegate = self;
    search.backgroundImage = [UIImage resizedImage:@"searchbar_textfield_background"];
    search.placeholder = @"请输入搜索医院丶医生";
    search.frame = CGRectMake(15, 10, mainScreenW * 0.9, 35);
    [searchView addSubview:search];
    searchView.backgroundColor = sColor(233, 235, 240, 1.0);
    searchView.frame = CGRectMake(0, CGRectGetMaxY(segmentView.frame) , mainScreenW, 35);
    self.searchBar = search;
    [self.view addSubview:searchView];
    
    self.tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(searchView.frame) + 5 * CostumViewMargin, mainScreenW, mainScreenH - CGRectGetMaxY(searchView.frame) - 2 *CostumViewMargin);
    _tableView.backgroundColor = mainScreenColor;
    [self.view addSubview:_tableView];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    SLog(@"点击了完成!");
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SLog(@"点击了搜索!");
    [self.tableView headerBeginRefreshing];
    if (_segmentView.selectedSegmentIndex == 0) {
        [self loadHospitalData];
    }
    else{
        [self loadDoctorData];
    }
    
    [self resignKeyBoardInView:self.view];
    searchBar.text = nil;
}

#pragma mark - 键盘消失
- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        
        if ([v isKindOfClass:[UISearchBar class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resignKeyBoardInView:self.view];
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
    [self.tableView headerBeginRefreshing];
    [self loadHospitalData];
    [_doctorsArray removeAllObjects];
}

-(void)selectedDoctor
{
    SLog(@"选择了医生!");
    [self.tableView headerBeginRefreshing];
    [self loadDoctorData];
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
    if (_segmentView.selectedSegmentIndex == 0) {
        return _hospitalArray.count;
    }else{
        return _doctorsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.backgroundColor = mainScreenColor;
            }
    if (_doctorsArray.count > 0) {
        DoctorStatus *data = [_doctorsArray objectAtIndex:indexPath.row];
        self.doctorData = data.docname;
    }
    if (_doctorsArray.count > 0) {
        cell.textLabel.text = _doctorData;
    }
    else{
        if (_hospitalArray.count>0) {
            HospitalStatus *status = [_hospitalArray objectAtIndex:indexPath.row];
            self.hospitalData = status.hospitalname;
        }
        cell.textLabel.text = _hospitalData;
    }
    return cell;
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
