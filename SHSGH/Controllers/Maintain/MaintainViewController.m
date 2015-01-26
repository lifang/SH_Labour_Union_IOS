//
//  MaintainViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/24.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "MaintainViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "PersonalViewController.h"

@interface MaintainViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UIScrollView *contentView;

@property(nonatomic,weak)UIButton *leftBtn;

@property(nonatomic,weak)UIButton *rightBtn;

@end

@implementation MaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setUpUI];
}

-(void)setUpUI
{
    //整个界面
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = sColor(220, 220, 220, 1.0);
    //顶部View
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = sColor(245, 241, 201, 1.0);
    topView.layer.cornerRadius = 4;
    topView.layer.masksToBounds = YES;
    topView.frame = CGRectMake(15, 15, mainScreenW * 0.9, 66);
    //顶部View 感叹号图片
    UIImageView *leftImage = [[UIImageView alloc]init];
    leftImage.frame = CGRectMake(12, 20, 25, 25);
    leftImage.image = [UIImage imageNamed:@"i"];
    [topView addSubview:leftImage];
    //顶部View 右边公告Lable
    UILabel *rightLabel = [[UILabel alloc]init];
    NSString *rightLabelText = @"此服务提供广大职工向工会提出自己的疑问,相关问题将在后续第一时间答复。";
    rightLabel.text = rightLabelText;
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.textColor = sColor(163, 162, 136, 1.0);
    rightLabel.numberOfLines = 2;
    rightLabel.frame = CGRectMake(CGRectGetMaxX(leftImage.frame) + 3 * CostumViewMargin, 8, contentView.frame.size.width * 0.7, leftImage.frame.size.height + 30);
    [topView addSubview:rightLabel];
    [contentView addSubview:topView];
    //选择按钮
    //选择左边按钮
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.layer.cornerRadius = 2;
    leftBtn.layer.masksToBounds = YES;
    [leftBtn addTarget:self action:@selector(touchLeft) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftBtn setBackgroundColor:sColor(233, 117, 12, 1.0)];
    [leftBtn setTitle:@"游客维权区" forState:UIControlStateNormal];
    [leftBtn setTintColor:[UIColor whiteColor]];
    leftBtn.frame = CGRectMake(topView.frame.origin.x, CGRectGetMaxY(topView.frame) + 3 *CostumViewMargin, topView.frame.size.width * 0.5, 30);
    self.leftBtn = leftBtn;
    [contentView addSubview:leftBtn];
    //选择右边按钮
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.layer.cornerRadius = 2;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(touchRight) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setBackgroundColor:[UIColor whiteColor]];
    [rightBtn setTitle:@"会员维权区" forState:UIControlStateNormal];
    [rightBtn setTitleColor:sColor(38, 38, 38, 1.0) forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), CGRectGetMaxY(topView.frame) + 3 *CostumViewMargin, topView.frame.size.width * 0.5, 30);
    self.rightBtn = rightBtn;
    [contentView addSubview:rightBtn];
    //分隔线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = sColor(200, 200, 200, 1.0);
    lineView.frame = CGRectMake(0, CGRectGetMaxY(leftBtn.frame) + 4 * CostumViewMargin, mainScreenW, 1);
    [contentView addSubview:lineView];
    //分隔线下方控件
    CGFloat labelWidth = 60;
    CGFloat labelHeight = 20;
    //姓名
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = sColor(90, 90, 90, 1.0);
    nameLabel.text = @"姓名";
    nameLabel.frame = CGRectMake(CGRectGetMinX(leftBtn.frame) + 2 * CostumViewMargin, CGRectGetMaxY(lineView.frame) + 4 * CostumViewMargin, labelWidth * 0.5, labelHeight);
    [contentView addSubview:nameLabel];
    //红色星星
    UILabel *redStar = [[UILabel alloc]init];
    redStar.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + CostumViewMargin, nameLabel.frame.origin.y, labelWidth * 0.25, labelHeight);
    redStar.textColor = sColor(227, 15, 46, 1.0);
    redStar.text = @"*";
    redStar.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:redStar];
    //姓名输入框
    UITextField *nameField = [[UITextField alloc]init];
    nameField.layer.cornerRadius = 2;
    nameField.layer.masksToBounds = YES;
    
    
    
    
    
    
    contentView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:contentView];
}

-(void)touchLeft
{
    SLog(@"选中了左边");
    [self.rightBtn setBackgroundColor:[UIColor whiteColor]];
    [self.rightBtn setTitleColor:sColor(38, 38, 38, 1.0) forState:UIControlStateNormal];
    
    [self.leftBtn setBackgroundColor:sColor(233, 117, 12, 1.0)];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

-(void)touchRight
{
    SLog(@"选中了右边");
    [self.leftBtn setBackgroundColor:[UIColor whiteColor]];
    [self.leftBtn setTitleColor:sColor(38, 38, 38, 1.0) forState:UIControlStateNormal];
    
    [self.rightBtn setBackgroundColor:sColor(233, 117, 12, 1.0)];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)setNavBar
{
    self.title = @"维权登记";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"head_bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(21, 0, 21, 0)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    
    [buttonL.navButton setImage:[UIImage imageNamed:@"left_barbutton"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setImage:[UIImage imageNamed:@"user_white"]forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(toUser) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)toUser
{
    PersonalViewController *personVC = [[PersonalViewController alloc]init];
    self.maintainNav = [AppDelegate shareMaintainController];
    [self.maintainNav pushViewController:personVC animated:YES];
    SLog(@"toUser");
}

@end
