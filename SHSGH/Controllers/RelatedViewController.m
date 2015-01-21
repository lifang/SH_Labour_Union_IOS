//
//  RelatedViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "RelatedViewController.h"
#import "DetalsocialViewController.h"
@interface RelatedViewController ()

@end

@implementation RelatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"相关查询";
    [self setnavBar];
    [self createui];
    
    
}
-(void)createui
{
    if(iOS7)
    {
        self.navigationController.navigationBar.barTintColor=HHZColor(99, 27, 28);
        
    }
    else
    {
        self.navigationController.navigationBar.tintColor = HHZColor(99, 27, 28);
        
        
    }
    
    self.view.backgroundColor=[UIColor whiteColor];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"法规查询",@"互助保障",@"问卷调查",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame =CGRectMake(20,70,SCREEN_WIDTH-40,40);
    [self.view addSubview:segmentedControl];
    segmentedControl.segmentedControlStyle= UISegmentedControlStyleBar;//设置
    segmentedControl.tintColor= [UIColor colorWithRed:238.0/255 green:160.0/255 blue:20.0/255 alpha:1];
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];


    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    
    
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(indexPath.row==0)
    {
        UIView*searchrootview=[[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-80, 40)];
        [cell addSubview:searchrootview];
        if(iOS7)
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 1, SCREEN_WIDTH-120, 38)];
        }
        else
        {
            _searchfield=[[UITextField alloc]initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-120, 38)];
            
        }
        searchrootview.layer.cornerRadius=20;
        
        _searchfield.placeholder=@"请输入关键字 ";
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
        
        
        UIButton*searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 15, 40, 30)];
        
        [searchButton setTitle: @"搜索" forState:UIControlStateNormal];
        [searchButton setTitleColor:HHZColor(99, 27, 28) forState:UIControlStateNormal];
               searchButton.layer.cornerRadius=5;
          searchButton.layer.cornerRadius=10;
        
        [cell addSubview:searchButton];
        
        CALayer *layers=[searchButton layer];
        //是否设置边框以及是否可见
        [layers setMasksToBounds:YES];
        //设置边框圆角的弧度
        
        //设置边框线的宽
        //
        [layers setBorderWidth:1];
        //设置边框线的颜色
        [layers setBorderColor:[[UIColor grayColor] CGColor]];
        searchButton.userInteractionEnabled=YES;
        
        [searchButton addTarget:self action:@selector(searchButtonclick) forControlEvents:UIControlEventTouchUpInside];
        
    }
       else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=@"社会保障法";

    }
    
    
    return cell;
    
    
}
-(void)searchButtonclick
{




}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetalsocialViewController*detal=[[DetalsocialViewController alloc]init];
    [self.navigationController pushViewController:detal animated:YES];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
}


-(void)change:(UISegmentedControl*)segmentedControl
{
 if(segmentedControl.selectedSegmentIndex==0)
      {
_Seatchtable.hidden=NO;

      }
else if(segmentedControl.selectedSegmentIndex==1)
      {
        _Seatchtable.hidden=NO;
        
      }
    else
    {
        
        _Seatchtable.hidden=YES;
        
        [self showMessage:@"正在加紧制作中，，，" viewHeight:SCREEN_HEIGHT/2-80];
    
    }


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

-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
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
