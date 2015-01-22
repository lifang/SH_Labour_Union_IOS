//
//  ConditionsViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ConditionsViewController.h"
#import "ConditionsTableViewCell.h"
@interface ConditionsViewController ()

@end

@implementation ConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _Conditionstable.rowHeight=60;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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