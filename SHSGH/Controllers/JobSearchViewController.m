//
//  JobSearchViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "JobSearchViewController.h"
#import "SearchRestulTableViewCell.h"
@interface JobSearchViewController ()

@end

@implementation JobSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=60;
    
    
    
    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    SearchRestulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[SearchRestulTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0||indexPath.row==4)
    {
    
    
    }
    else
    {
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }
  
    
    return cell;
    
    
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
