//
//  SearchRecordViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchRecordViewController.h"
#import "JobDetalViewController.h"
#import "navbarView.h"
@interface SearchRecordViewController ()

@end

@implementation SearchRecordViewController
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",self.recortarry);
    
   
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    self.title=@"搜索记录";
    
    // Do any additional setup after loading the view.
    _Conditionstable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Conditionstable];
    _Conditionstable.delegate=self;
    _Conditionstable.dataSource=self;
    _Conditionstable.rowHeight=40;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self  setNavBar];
    
    
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
-(void)createui
{
    
    
    
    
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(110, 0, 0);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(110, 0, 0);
        
        
    }

    
    [self setnavBar];
    
    
    
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text=@"网页设计师";
    //    seariamgeview.tag=indexPath.row;
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
    
    
    [self.navigationController pushViewController:jobdetal animated:YES];
    
    
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
