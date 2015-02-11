//
//  Route ViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/30.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "Route ViewController.h"
#import "navbarView.h"
#import "QipaoTableViewCell.h"
#import "MapdetalViewController.h"
#import "LineTableViewCell.h"
@interface Route_ViewController ()

@end

@implementation Route_ViewController
-(void)viewWillAppear:(BOOL)animated
{
   
    if(self.linarry.count==0)
    {
        
        [self showMessage:@"无合适路线" viewHeight:SCREEN_HEIGHT/2-80];
        
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"查看路线";
   
    _seletedIndex=1;
    
    _gryarry=[NSArray arrayWithObjects:@"bus_Gray",@"taxi_Gray",@"walk_Gray", nil];
    _hightarry=[NSArray arrayWithObjects:@"bus-1",@"taxi",@"walk", nil];
    [self createui];
    [_Seatchtable reloadData];
   

    // Do any additional setup after loading the view.
    [ self setnavBar];
    [ self setNavBar];
  
//    NSLog(@"%@",[self.linarry objectAtIndex:0]) ;
    
}



-(void)createui
{
       UIView*backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    backview.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor grayColor];
    
    [self.view addSubview:backview];
    
    UIImageView *logoimageview1 = [[UIImageView alloc]init];
    
    logoimageview1.frame = CGRectMake(10, 5, 20, 20);
    logoimageview1.image=[UIImage imageNamed:@"location"];
    
    [backview addSubview:logoimageview1];
    
    UIImageView *logoimageview2 = [[UIImageView alloc]init];
    
    logoimageview2.frame = CGRectMake(18, 31, 5, 26);
    logoimageview2.image=[UIImage imageNamed:@"roadLine"];
    
    [backview addSubview:logoimageview2];
    
    
    
    
    UIImageView *rightimage = [[UIImageView alloc]init];
    
    rightimage.frame = CGRectMake(SCREEN_WIDTH-40, 30, 20, 30);
    rightimage.image=[UIImage imageNamed:@"luxian"];
    
    [backview addSubview:rightimage];

    
    UIImageView *logoimageview3 = [[UIImageView alloc]init];
    
    logoimageview3.frame = CGRectMake(13, 58, 15, 15);
    logoimageview3.image=[UIImage imageNamed:@"cicle"];
    
    [backview addSubview:logoimageview3];
    
    
    
    UILabel*namelab=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 30)];
    [backview addSubview:namelab];
    namelab.text=@"我的位置";
    namelab.font=[UIFont systemFontOfSize:15];
    
    UIImageView *myimage = [[UIImageView alloc]init];
    
    myimage.frame = CGRectMake(110, 10, 16, 10);
    myimage.image=[UIImage imageNamed:@"unwind_Gray"];
    
    [backview addSubview:myimage];
    
    
    
    
    UILabel*addresslab=[[UILabel alloc]initWithFrame:CGRectMake(40, 50, SCREEN_WIDTH-80, 30)];
    [backview addSubview:addresslab];
    
    addresslab.text=self.name;
    addresslab.textColor=[UIColor grayColor];
    addresslab.font=[UIFont systemFontOfSize:15];

    
  
    
    
    for(NSInteger i=0;i<3;i++)
    {
    
        UIButton*addrbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        addrbutton.tag=i+1;
        
        if(i==0)
        {
            [addrbutton setImage:[UIImage imageNamed:[_hightarry objectAtIndex:0]] forState:UIControlStateNormal];

        
        }
        else
        {
            [addrbutton setImage:[UIImage imageNamed:[_gryarry objectAtIndex:i]] forState:UIControlStateNormal];

        }
        addrbutton.frame=CGRectMake((i+1)*SCREEN_WIDTH/4-15,90 ,30, 30);
        
        

//         [addrbutton setBackgroundImage:[UIImage imageNamed:[_gryarry objectAtIndex:i]] forState:UIControlStateNormal];
        [addrbutton addTarget:self action:@selector(luxianclicks:) forControlEvents:UIControlEventTouchUpInside];
        
        [backview addSubview:addrbutton];
        
        
       
      

    
    
    }
    
   rootview=[[UIView alloc]initWithFrame:CGRectMake(0, 131, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.view addSubview:rootview];
    rootview.backgroundColor=[UIColor whiteColor];
    
  
    rootview.hidden=YES;
    
    
    
    UIButton*addressbutton=[[UIButton alloc] initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH, 30)];
    
    [rootview addSubview:addressbutton];
    addressbutton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
//    [addressbutton addTarget:self action:@selector(dituclick) forControlEvents:UIControlEventTouchUpInside];
    
    
    addressbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if([self  isBlankString:self.address])
    {
    
        [addressbutton setTitle:[NSString stringWithFormat:@"   当前位置  → 暂无目的地"] forState:UIControlStateNormal];

    
    }
    else
    {
    
        [addressbutton setTitle:[NSString stringWithFormat:@"   当前位置  →%@",self.address] forState:UIControlStateNormal];

    
    
    }
    [addressbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
//    UIImageView *nextimageview = [[UIImageView alloc]init];
//    
//    nextimageview.frame = CGRectMake(SCREEN_WIDTH-40, 13, 15, 20);
//    nextimageview.image=[UIImage imageNamed:@"particular_Gray"];
//    
//    [rootview addSubview:nextimageview];
    
    
    
    
    
    
    
    UILabel*linelable2=[[UILabel alloc]init];
    linelable2.frame=CGRectMake(0, addressbutton.frame.size.height+addressbutton.frame.origin.y+10, SCREEN_WIDTH, 1);
    linelable2.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    [rootview addSubview:linelable2];
    

    
    _Seatchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 131, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    _Seatchtable.tableFooterView = [[UIView alloc]init];

    [self.view addSubview:_Seatchtable];
    _Seatchtable.delegate=self;
    _Seatchtable.dataSource=self;
     _Seatchtable.rowHeight=45;
    
//    _Seatchtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //    _Seatchtable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.linarry.count;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    LineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[LineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    NSDictionary*dict=[self.linarry objectAtIndex:indexPath.row];
    
    cell.timelable.text=[NSString stringWithFormat:@"%@|%@", [dict objectForKey:@"time"],[dict objectForKey:@"distance"]];
    
//    cell.distancelable.text=;
    
    NSArray*arry=[dict objectForKey:@"line"];
    
    NSString*string;
    
    NSString *lastString = @"";
    for (NSString *value in arry)
    {
        string = [NSString stringWithFormat:@"%@%@  →", lastString, value];
       
        lastString = [NSString stringWithFormat:@"%@", string];
    }
    
    NSString *cccc = [lastString substringToIndex:[lastString length] - 1];
    cell.namelable.text=cccc;
    
    
    return cell;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UILabel*templabel =[[UILabel alloc]initWithFrame:CGRectMake(80, 230, 210, 30)];
//    templabel.numberOfLines=0;
////    people*peop=[_allarry objectAtIndex:indexPath.section];
////    
////    templabel.text =peop.about_detail;
//    
//    templabel.font=[UIFont systemFontOfSize:12];
//    [templabel sizeToFit];
//    
//    
//    return templabel.frame.size.height+30;
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView*rootimageview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
//    rootimageview.userInteractionEnabled=YES;
//    
//    //    UITapGestureRecognizer *singleTapss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
//    UIButton*touchclickimageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
//    touchclickimageview.tag=section+1;
//    
//    [rootimageview addSubview:touchclickimageview];
//    
//    [touchclickimageview addTarget:self action:@selector(detalButtonclick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    //       [ touchclickimageview addGestureRecognizer:singleTapss];
//       UILabel*namelable=[[UILabel alloc]init];
//    namelable.frame=CGRectMake(10,0, SCREEN_WIDTH-100, 30);
//    
//    namelable.font=[UIFont systemFontOfSize:15];
//    //      requirecontent.textColor=[UIColor grayColor];
//    //    namelable.numberOfLines=0;
//    [rootimageview addSubview:namelable];
////    namelable.text=peop.namestring;
//    namelable.userInteractionEnabled=NO;
//    
//    UILabel*addresslable=[[UILabel alloc]init];
//    addresslable.frame=CGRectMake(10,30, SCREEN_WIDTH-100, 30);
//    
//    addresslable.font=[UIFont systemFontOfSize:15];
//    addresslable.textColor=[UIColor grayColor];
//    addresslable.numberOfLines=0;
//    [rootimageview addSubview:addresslable];
////    addresslable.text=peop.addrstring;
//    
//    addresslable.userInteractionEnabled=NO;
//    
// 
//    
//    
//    
//    UIButton*searchButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//    searchButton.frame= CGRectMake(SCREEN_WIDTH-40, 15, 30, 30);
//    
//    
//    if (_flagArray[section])
//    {   [UIView beginAnimations:nil context:nil];
//        
//        [UIView setAnimationDuration:0.5];
//        
//        [searchButton setImage:[UIImage imageNamed:@"unwind_Gray"] forState:UIControlStateNormal];
//        
//        [UIView commitAnimations];
//        
//        
//    }
//    else
//    {
//        [UIView beginAnimations:nil context:nil];
//        
//        [UIView setAnimationDuration:0.5];
//        
//        [searchButton setImage:[UIImage imageNamed:@"right_dark"] forState:UIControlStateNormal];
//        
//        [UIView commitAnimations];
//    }
//    
//    
//    
//    
//    [rootimageview addSubview:searchButton];
//    
//    
//    //    searchButton.userInteractionEnabled=NO;
//    
//    [searchButton addTarget:self action:@selector(detalButtonclick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    searchButton.tag=1+section;
//    return rootimageview;
//    
//    
//    
//}
//-(void)detalButtonclick:(UIButton*)send
//
//{
//    
//    UIButton *button=(UIButton *)send;
//    
//    //根据按钮的tag值找到所找按钮所在的区
//    int section=button.tag-1.0;
//    
//    //取反  如果布尔数组中的值是yes=>>no.no=>>yes
//    _flagArray[section]=!_flagArray[section];
//    
//    //让表重新加载(刷新整个表)
//    //[_tableView reloadData];
//    
//    //先根据要刷新的区号，创建一个索引集
//    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:section];
//    
//    //刷新指定的区
//    [_Seatchtable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
//    
//    
//    
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return 60;
//    
//    
//}
-(void)luxianclicks:(UIButton*)send
{
    
    NSInteger current=send.tag;
    
    if (_seletedIndex == current) return;
    UIButton *previousButton = (UIButton *)[self.view viewWithTag:_seletedIndex ];

    [previousButton setImage:[UIImage imageNamed:[_gryarry objectAtIndex:_seletedIndex-1]] forState:UIControlStateNormal];
    _seletedIndex=current;
    UIButton *currentButton = (UIButton *)[self.view viewWithTag:(current )];
    [currentButton setImage:[UIImage imageNamed:[_hightarry objectAtIndex:current-1]] forState:UIControlStateNormal];
    
    if(current==1)
    {
    
        _Seatchtable.hidden=NO;
        
    
    
    }
    if(current==2)
    {
        
        _Seatchtable.hidden=YES;
        rootview.hidden=NO;

        MapdetalViewController*map=[[MapdetalViewController alloc]init];
        map.coreld=self.coreld;
        map.city=self.city;
        map.name=self.name;

        
        map.awhichway=2;
        
        [self.navigationController pushViewController:map animated:YES];
        
    }

    if(current==3)
    {
        
        _Seatchtable.hidden=YES;
        
        MapdetalViewController*map=[[MapdetalViewController alloc]init];
        map.coreld=self.coreld;
        map.city=self.city;

        map.name=self.name;

        map.awhichway=1;
        
        [self.navigationController pushViewController:map animated:YES];
        
    }
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MapdetalViewController*map=[[MapdetalViewController alloc]init];
    map.coreld=self.coreld;
    map.bline=indexPath.row;
    map.city=self.city;
    map.name=self.name;
    
    map.awhichway=3;
    
    [self.navigationController pushViewController:map animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNavBar
{
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
