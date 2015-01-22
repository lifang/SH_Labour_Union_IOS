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
#import "SearchRecordViewController.h"
@interface SearchJobViewController ()

@end

@implementation SearchJobViewController
- (void)viewWillAppear:(BOOL)animated
{
     NSLog(@"%@%@%@",str1,str3,str2);
    
    recordarry=[NSMutableArray  arrayWithCapacity:0];
   
  

}
- (void)viewDidLoad {
    self.title=@"岗位查询";
    [self setnavBar];
    
    [super viewDidLoad];
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(99, 27, 28);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(99, 27, 28);
        
        
    }
    // Do any additional setup after loading the view.
    namearry=[[NSArray alloc]initWithObjects:@"",@"行业类别",@"首选工作区域",@"次选工作区域",@"",@"        搜索记录",@"        职位推荐", nil];
    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    _conditarry=[[NSMutableArray alloc]init];
    
    
    
    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
    _Seatchtable.rowHeight=60;
    
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
//    SearchRestulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (!cell)
//    {
        SearchRestulTableViewCell*cell = [[SearchRestulTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
//    }
    
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
        seariamgeview.image=[UIImage imageNamed:@"search"];
        
        
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
        recordiamgeview.image=[UIImage imageNamed:@"searchs"];
    
    }
    if(indexPath.row==6)
    {
        
        UIImageView*adviceiamgeview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 25, 25)];
        [cell addSubview: adviceiamgeview];
        adviceiamgeview.image=[UIImage imageNamed:@"position"];
        
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
    {
        ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"行业类别";
        
     [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str1=hangyestring;
            
            
        };

    }
    
    if(indexPath.row==2)
    {ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"首选工作区域";
        
        [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str2=hangyestring;
            
            
        };

    }
    if(indexPath.row==3)
    {ConditionsViewController*searchviewcontroller=[[ConditionsViewController alloc]init];
        searchviewcontroller.conditionsname=@"次选工作区域";
        
        [self.navigationController pushViewController:searchviewcontroller animated:YES];
        searchviewcontroller.block=^(NSString*hangyestring){
            
            str3=hangyestring;
            
           
            
        };

    }
    if(indexPath.row==5)
    {
        
        SearchRecordViewController*seach=[[SearchRecordViewController alloc]init];
     
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        

        recordarry=[userDefaults objectForKey:@"record"];
        NSMutableArray*recordsarry=[NSMutableArray arrayWithCapacity:0];
        for(int i=0;i<recordarry.count;i++)
        {
            [recordsarry addObject:[recordarry objectAtIndex:i]];
            
            
            
        }

           seach.recortarry=recordsarry;
        
        [self.navigationController pushViewController:seach animated:YES];
        
    }

    if(indexPath.row==6)
    {
        
        SearchRestulViewController*seach=[[SearchRestulViewController alloc]init];
        
        seach.conditionsname=@"职位推荐";
        
        
        [self.navigationController pushViewController:seach animated:YES];

    }
    

    
}
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void)showMessage:(NSString*)message viewHeight:(float)height;
{
    if(self)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        //        hud.dimBackground = YES;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.yOffset = height;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}


-(void)searchButtonclick
{

    if([self isBlankString:str1]==YES&&[self isBlankString:str2]==YES&&[self isBlankString:str3]==YES)
    {
        [self showMessage:@"请选择行业，区域等" viewHeight:SCREEN_HEIGHT/2-80];
        return;
        
    
    }
   

    SearchRestulViewController*seach=[[SearchRestulViewController alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    recordarry=[userDefaults objectForKey:@"record"];
    NSMutableArray*recordsarry=[NSMutableArray arrayWithCapacity:0];
    for(int i=0;i<recordarry.count;i++)
    {
        [recordsarry addObject:[recordarry objectAtIndex:i]];
        
    
    
    }
    seach.conditionsname=@"搜索结果";
    NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
    [dict setValue:str1 forKey:@"12"];
    [dict setValue:str2 forKey:@"13"];
    
    [recordsarry addObject:dict];
    
    [userDefaults setObject:recordsarry forKey:@"record"];
    [userDefaults synchronize];
    

    [self.navigationController pushViewController:seach animated:YES];
     str1=@"";
    
    str2=@"";
    

    
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
