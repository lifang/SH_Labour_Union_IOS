//
//  SearchJobViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchJobViewController.h"
#import "SearchRestulTableViewCell.h"
#import "SearchRestulViewController.h"
#import "ConditionsViewController.h"
@interface SearchJobViewController ()

@end

@implementation SearchJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    namearry=[[NSArray alloc]initWithObjects:@"",@"行业类别",@"首选工作区域",@"次选工作区域",@"",@"        搜索记录",@"        职位推荐", nil];
    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=60;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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
    
    cell.textLabel.text=[namearry objectAtIndex:indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0)
    {
        UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 40)];
        [cell addSubview:searchrootview];
        if(iOS7)
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-80, 38)];
        }
        else
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-80, 38)];
            
        }
        searchrootview.layer.cornerRadius=20;
        
        _searchfield.placeholder=@"请输入关键字/职位/公司/地点 ";
        _searchfield.delegate=self;
        CALayer *layer=[searchrootview layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        
        //设置边框线的宽
        //
        [layer setBorderWidth:1];
        //设置边框线的颜色
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        [searchrootview addSubview:_searchfield];
        
        UIImageView*seariamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 25, 25)];
        [searchrootview addSubview: seariamgeview];
        seariamgeview.image=[UIImage imageNamed:@"搜索"];
        
        
    }
    if(indexPath.row==4)
    {
        UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 40)];
        
        [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
        [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchButton setBackgroundColor:[UIColor colorWithRed:214.0/255 green:180.0/255 blue:92.0/255 alpha:1]];
        
        searchButton.layer.cornerRadius=5;
        
        
        [cell addSubview:searchButton];
        
        
        searchButton.userInteractionEnabled=YES;
        
        [searchButton addTarget:self action:@selector(searchButtonclick) forControlEvents:UIControlEventTouchUpInside];
    }
    if(indexPath.row==5)
    {
    
        UIImageView*recordiamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 25, 25)];
        [cell addSubview: recordiamgeview];
        recordiamgeview.image=[UIImage imageNamed:@"搜索记录"];
    
    }
    if(indexPath.row==6)
    {
        
        UIImageView*adviceiamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 25, 25)];
        [cell addSubview: adviceiamgeview];
        adviceiamgeview.image=[UIImage imageNamed:@"职位推荐"];
        
    }
    if(indexPath.row==0||indexPath.row==4)
    {
        
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        
[self.navigationController pushViewController:searchviewcontroller animated:YES];
    }
    
    
    
    
    
}

-(void)searchButtonclick
{
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
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
