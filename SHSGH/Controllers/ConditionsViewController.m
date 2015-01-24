//
//  ConditionsViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ConditionsViewController.h"
#import "ConditionsTableViewCell.h"
#import "navbarView.h"
@interface ConditionsViewController ()

@end

@implementation ConditionsViewController
@synthesize block;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    
    self.title=self.conditionsname;
    [self createui];
    
    namearry=[[NSArray alloc]initWithObjects:@"",@"行业类别",@"首选工作区域",@"次选工作区域",@"",@"搜索记录",@"职位推荐", nil];
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<7;i++)
    {
        [imagearry addObject:@""];
        
    
    }

    // Do any additional setup after loading the view.
    _Conditionstable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Conditionstable];
    _Conditionstable.delegate=self;
    _Conditionstable.dataSource=self;
    _Conditionstable.rowHeight=40;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}

-(void)setNavBar
{
//    self.title = @"个人中心";
//    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
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
    
//    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
//    
//    
//     gobackbut.bounds = CGRectMake(0, 0, 20, 25);
//    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIView*lineview=[[UIView alloc]init];
//    lineview.bounds = CGRectMake(0, 0, 1, 45);
//    lineview.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
//    
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
//    
//    UIBarButtonItem *leftItem2= [[UIBarButtonItem alloc] initWithCustomView:lineview];
//    
// NSArray *array = [[NSArray alloc] initWithObjects:leftItem,leftItem2, nil];
//    
//        self.navigationItem.leftBarButtonItems = array;


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
    
    ConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[ConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        
    }
    
  
   cell.logoImageView.image=[UIImage imageNamed:[imagearry objectAtIndex:indexPath.row]];
    

    
    cell.textLabel.text=[namearry objectAtIndex:indexPath.row];
//    seariamgeview.tag=indexPath.row;
    
     return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//   UIImageVieConditionsTableViewCellw*clickimageview=(UIImageView*)[self.view viewWithTag:indexPath.row];
  
//        clickimageview.image=[UIImage imageNamed:@"dui"];
//    [imagearry removeAllObjects];
    
  
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<7;i++)
    {
        [imagearry addObject:@""];
        
        
    }

    [imagearry replaceObjectAtIndex:indexPath.row withObject:@"dui"];
    if (self.block) {
        block([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }

   [_Conditionstable reloadData];
    
    

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
