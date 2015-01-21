//
//  JobDetalViewController.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "JobDetalViewController.h"
#import "OtherjobViewController.h"
@interface JobDetalViewController ()

@end

@implementation JobDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *gobackbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [gobackbut setBackgroundImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    
    
    gobackbut.bounds = CGRectMake(0, 0, 20, 25);
    [gobackbut addTarget:self action:@selector(gobackclick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:gobackbut];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title=@"详情";
    
    // Do any additional setup after loading the view.
    
    [self createui];
    self.view.backgroundColor=[UIColor whiteColor];
    
}
-(void)setnavBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, NavTitle_FONT(NavTitle_FONTSIZE),NSFontAttributeName,nil]];
}

-(void)createui
{ if(iOS7)
{
    self.navigationController.navigationBar.barTintColor=HHZColor(99, 27, 28);
    
}
else
{
    self.navigationController.navigationBar.tintColor = HHZColor(99, 27, 28);
    
    
}
    [self setnavBar];
    UIScrollView*bigscrollow=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:bigscrollow];
    
    UILabel*jobname=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/2, 30)];
    [bigscrollow addSubview:jobname];
    jobname.text=@"酒店运营经理";
//    UILabel*discuss=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 50, 60, 10)];
//    discuss.font=[UIFont systemFontOfSize:15];
//    discuss.textColor=[UIColor redColor];
//    [bigscrollow addSubview:discuss];
//    discuss.text=@"面议";

    UILabel*datename=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 90, 20)];
    datename.font=[UIFont systemFontOfSize:15];
    datename.textColor=[UIColor grayColor];
    [bigscrollow addSubview:datename];
      datename.text=@"2014/06/12";
    
    UILabel*companyname=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-20, 20)];
    companyname.font=[UIFont systemFontOfSize:15];
    companyname.textColor=[UIColor grayColor];
    [bigscrollow addSubview:companyname];
      companyname.text=@"中邦置业集团有限公司";
    
    UILabel*address=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-80, 20)];
    address.font=[UIFont systemFontOfSize:15];
    address.textColor=[UIColor grayColor];
    [bigscrollow addSubview:address];
    address.text=@"杭州 西湖区";

    UILabel*require=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-20, 30)];
    require.font=[UIFont systemFontOfSize:15];
//    address.textColor=[UIColor grayColor];
    [bigscrollow addSubview:require];
    require.text=@"任职要求：";
    
    UILabel*requirecontent=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, SCREEN_WIDTH-30, 30)];
    requirecontent.font=[UIFont systemFontOfSize:15];
      requirecontent.textColor=[UIColor grayColor];
     requirecontent.numberOfLines=0;
    [bigscrollow addSubview:requirecontent];
    requirecontent.text=@"任职要求：都刚好合适的话他还是身体是他说他是如何谁认识他是搞糊涂人士同时也会是符合人体还是事故发生突然";

    [requirecontent sizeToFit];
    

    
    UILabel*contact=[[UILabel alloc]initWithFrame:CGRectMake(20, requirecontent.frame.origin.y+requirecontent.frame.size.height+10, SCREEN_WIDTH-20, 30)];
    contact.font=[UIFont systemFontOfSize:15];
    //    address.textColor=[UIColor grayColor];
    [bigscrollow addSubview:contact];
    contact.text=@"联系方式：";

    
    
    UILabel*contactcontent=[[UILabel alloc]initWithFrame:CGRectMake(20, contact.frame.origin.y+contact.frame.size.height+10, SCREEN_WIDTH-30, 30)];
    contactcontent.font=[UIFont systemFontOfSize:15];
    contactcontent.textColor=[UIColor grayColor];
    [bigscrollow addSubview:contactcontent];
      contactcontent.numberOfLines=0;
    
        contactcontent.text=@"任职要求：都刚好合适的话他还是身体是他说他是如何谁认识他是搞糊涂人士同时也会是符合人体还是事故发生突然";
[contactcontent sizeToFit];
    
    
    
    UILabel*coompamyname=[[UILabel alloc]initWithFrame:CGRectMake(20, contactcontent.frame.origin.y+contactcontent.frame.size.height+10, SCREEN_WIDTH-30, 30)];
    coompamyname.font=[UIFont systemFontOfSize:15];
    //    address.textColor=[UIColor grayColor];
    [bigscrollow addSubview:coompamyname];
    coompamyname.text=@"中邦置业有限公司：";
    
    
    
    UILabel*coompamycontent=[[UILabel alloc]initWithFrame:CGRectMake(20, coompamyname.frame.origin.y+coompamyname.frame.size.height+10, SCREEN_WIDTH-30, 30)];
    coompamycontent.font=[UIFont systemFontOfSize:15];
      coompamycontent.textColor=[UIColor grayColor];
    [bigscrollow addSubview:coompamycontent];
    coompamycontent.numberOfLines=0;
    coompamycontent.text=@"任职要求：都刚好合适的话他还是身体是他说他是如何谁认识他是搞糊涂人士同时也会是符合人体还是事故发生突然";
    [coompamycontent sizeToFit];
    
    
    
    UIButton *othersbut = [[UIButton alloc]init];
    [othersbut setTitle:@"该公司其他推荐职位" forState:UIControlStateNormal];
    
    [othersbut setTitleColor:HHZColor(238, 110, 0) forState:UIControlStateNormal];
    
//      [othersbut setImage:[UIImage imageNamed:@"particular_Gray"] forState:UIControlStateNormal];
    othersbut.frame=CGRectMake(20, coompamycontent.frame.origin.y+coompamycontent.frame.size.height+20, SCREEN_WIDTH-60, 30);
    
    othersbut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [othersbut addTarget:self action:@selector(otherclick) forControlEvents:UIControlEventTouchUpInside];
    [bigscrollow addSubview:othersbut];
    
    
    
    UIButton *othersbuts = [[UIButton alloc]init];
    
         [othersbuts setImage:[UIImage imageNamed:@"particular_Gray"] forState:UIControlStateNormal];
    othersbuts.frame=CGRectMake(SCREEN_WIDTH-40, coompamycontent.frame.origin.y+coompamycontent.frame.size.height+30, 20, 20);
    
    
    [othersbuts addTarget:self action:@selector(otherclick) forControlEvents:UIControlEventTouchUpInside];
    [bigscrollow addSubview:othersbuts];
    

    bigscrollow.contentSize=CGSizeMake(SCREEN_WIDTH, othersbut.frame.origin.y+othersbut.frame.size.height+20)
    ;
    
    
    

    
    
}
-(void)otherclick
{
    OtherjobViewController*otherview=[[OtherjobViewController alloc]init];
    [self.navigationController pushViewController:otherview animated:YES];
    

}
-(void)gobackclick
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
