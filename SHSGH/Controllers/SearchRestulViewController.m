//
//  SearchRestulViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchRestulViewController.h"
#import "GetresultTableViewCell.h"
#import "JobDetalViewController.h"
#import "navbarView.h"
@interface SearchRestulViewController ()

@end

@implementation SearchRestulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.title=self.conditionsname;
    
    [self setNavBar];
    
    [self createui];
    
       
    // Do any additional setup after loading the view.
    _getresulttable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_getresulttable];
    _getresulttable.delegate=self;
    _getresulttable.dataSource=self;
    _getresulttable.rowHeight=70;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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
    
//    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
//    
//    
//    gobackbut.bounds = CGRectMake(0, 0, 20, 25);
//    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
//    
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    
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
    
    GetresultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[GetresultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if([self.conditionsname isEqualToString:@"搜索结果"])
    {
     if(indexPath.row==0)
     {
         cell.jobname.text=@"";
         
         cell.companyname.text=@"共为您找到125个工作职位";
         cell.companyname.textColor=HHZColor(99, 27, 28);
         cell.date.text=@"";
     }
        else
        {
            cell.jobname.text=@"酒店经理";
            
            cell.companyname.text=@"协创有限公司";
            
            cell.date.text=@"2014/09/05";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    
    }
    else
    {
    cell.jobname.text=@"酒店经理";
    
    cell.companyname.text=@"协创有限公司";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.date.text=@"2014/09/05";
    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   UIImageVieConditionsTableViewCellw*clickimageview=(UIImageView*)[self.view viewWithTag:indexPath.row];
    
    //        clickimageview.image=[UIImage imageNamed:@"dui"];
    //    [imagearry removeAllObjects];
    
    if([self.conditionsname isEqualToString:@"搜索结果"])
    {
        if(indexPath.row==0)
        {
       [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        else
        {
            JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
            
            
            [self.navigationController pushViewController:jobdetal animated:YES];
            
        }
    
    
    }
    
//    职位推荐详情
    
    else
    {
        JobDetalViewController*jobdetal=[[JobDetalViewController alloc]init];
        
        
        [self.navigationController pushViewController:jobdetal animated:YES];
        

    
    }
    
    
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
