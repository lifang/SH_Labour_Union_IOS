//
//  DynamicChildViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DynamicChildViewController.h"
#import "navbarView.h"
#import "EGOImageView.h"

@interface DynamicChildViewController ()

@property(nonatomic,strong)UIScrollView *contentView;

@end

@implementation DynamicChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    [self setNavBar];
}

-(void)setupContentView
{
    CGFloat topMargin = 16;
    CGFloat leftMargin = 16;
    
    //创建主view
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = mainScreenColor;
    //创建标题Label
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.textColor = [UIColor blackColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont systemFontOfSize:17];
    NSString *topLabelStr = @"市总工会启动2015年工会保障工作重点研讨";
    topLabel.text = topLabelStr;
    CGSize topLabelSize = {0,0};
    topLabelSize = [topLabelStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(200.0, 5000)];
    topLabel.numberOfLines = 0;
    topLabel.frame = CGRectMake(leftMargin, topMargin, mainScreenW * 0.9, topLabelSize.height);
    [contentView addSubview:topLabel];
    //创建时间Label
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2014-10-12 10:08";
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = sColor(107, 107, 107, 1.0);
    timeLabel.frame = CGRectMake(topLabel.frame.origin.x, CGRectGetMaxY(topLabel.frame) + CostumViewMargin, 100, 20);
    [contentView addSubview:timeLabel];
    //创建分隔线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = sColor(215, 215, 215, 1.0);
    lineView.frame = CGRectMake(leftMargin, CGRectGetMaxY(timeLabel.frame) + CostumViewMargin * 2, topLabel.frame.size.width, 1);
    [contentView addSubview:lineView];
    //创建图片
    EGOImageView *imageView = [[EGOImageView alloc]init];
    NSURL *imageUrl = [NSURL URLWithString:@"http://www.audit.suzhou.gov.cn/news/sjj/2011/3/7/16-30-54-2347-1.jpg"];
    imageView.imageURL = imageUrl;
    imageView.frame = CGRectMake(leftMargin, CGRectGetMaxY(lineView.frame) + CostumViewMargin * 2, lineView.frame.size.width, 200);
    [contentView addSubview:imageView];
    //创建正文Label
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = sColor(81, 81, 81, 1.0);
    textLabel.font = [UIFont systemFontOfSize:14];
    NSString *textLabelStr = @"在小组座谈会中，一群相互之间完全陌生的人集中到一起，而且要畅所欲言，是有相当的难度的。首要的就是要建立大家之间的信任感，特别是要建立主持人与参会人员之间的信任感。\n这就要求主持人一定是个有热情的人，是一个让大家一见就感到信赖和亲切的人，是一个有着高度亲和力的人.有亲和力的主持人通过这种友好表示,使得在座的人员合作在一起，有一种合作的意识和趋向意识，和共同作用的力量。\n有亲和力是促成合作的起因，只有具有了合作意向，才会使大家结合在一起共同合作,才能更好的达成会议目标.座谈会要让每个与会者都能真实的表达自己的意思.特别是遇到一些可能触及到个人价值观或判断能力的话题，小组成员往往有顾虑，或者看别人的眼色随波逐流随声附和。\n最好的办法莫过于让大家进入一种忘我的境界,全心全意的投入到讨论当中，这时候的人们更多的是感性的人们，而不是一个说话要斟酌再三的“理性”的人。对于主持人来说，就要很快进入会议主持状态，让小组成员放开思想包袱，在无论对错没有水平高低的担忧下充分讨论。";
    textLabel.text = textLabelStr;
    CGSize textLabelSize = {0,0};
    textLabelSize = [textLabelStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenW * 0.9, 5000)];
    textLabel.numberOfLines = 0;
    textLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(imageView.frame) + CostumViewMargin * 3, mainScreenW * 0.9, textLabelSize.height);
    [contentView addSubview:textLabel];

    [self.view addSubview:contentView];
    contentView.contentSize = CGSizeMake(mainScreenW, CGRectGetMaxY(textLabel.frame) + 70);
    
    UIImageView *backTopView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_top"]];
    backTopView.frame = CGRectMake(mainScreenW - 60, mainScreenH - 140, 40, 40);
    [self.view addSubview:backTopView];
    
}



-(void)setNavBar
{
    self.title = @"新闻详情";
    self.view.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoDynamic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoDynamic
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end