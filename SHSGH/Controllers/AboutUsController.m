//
//  AboutUsController.m
//  SHSGH
//
//  Created by 黄含章 on 15/6/8.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "AboutUsController.h"
#import "navbarView.h"
#import "AppDelegate.h"

@interface AboutUsController ()

@end

@implementation AboutUsController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [delegate.DrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBar];
    [self initAndLayoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initAndLayoutUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //创建正文Label
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = kColor(81, 81, 81, 1.0);
    textLabel.font = [UIFont systemFontOfSize:18];
    NSString *contentStr = @"上海是中国工人阶级的摇篮，也是中国工人运动的发祥地。在1925年“五卅”反帝爱国运动的高潮中，上海总工会宣告成立。在中国共产党的领导下，上海总工会组织工人群众为推翻帝国主义、封建主义、官僚资本主义的反动统治，取得新民主主义革命的胜利和社会主义基本制度的建立进行了艰苦顽强的斗争，发挥了独特的作用。新中国成立后，上海总工会动员和组织全市职工投入了轰轰烈烈的社会主义建设事业，为改变国家一穷二白的落后面貌、为上海的繁荣和发展作出了积极的贡献。";
    textLabel.text = contentStr;
    CGSize textLabelSize = {0,0};
    textLabelSize = [contentStr sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(self.view.frame.size.width - 10, 5000)];
    textLabel.numberOfLines = 0;
    textLabel.frame = CGRectMake(5, 30 , self.view.frame.size.width - 10, textLabelSize.height);
    [self.view addSubview:textLabel];
}

-(void)setNavBar
{
    self.title = @"关于我们";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)leftMenu
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
