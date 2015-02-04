//
//  QuestionViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "QuestionViewController.h"
#import "ConditionsTableViewCell.h"
#import "navbarView.h"

@interface QuestionViewController ()

@property(nonatomic,strong)NSString *questions;

@end

@implementation QuestionViewController
@synthesize block;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];

    
    namearry=[[NSArray alloc]initWithObjects:@"打工者的基本权利是什么?",@"什么是劳动合同?",@"劳动合同定立.变更和履行的原则有哪些?",@"用人单位只签订试用期合同怎么办?",@"社会保险是什么?",@"则么样界定辞退与自动离职?",@"执行国家福利时怎么分配?",@"工作环境极其恶劣怎么办?",@"乱收培训费怎么办?",@"法定节假日不放假怎么办?",@"兼职者收到侮辱怎么办?", nil];
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<namearry.count;i++)
    {
        [imagearry addObject:@""];
    }
    
    // Do any additional setup after loading the view.
    _Questiontable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
    [self.view addSubview:_Questiontable];
    _Questiontable.delegate=self;
    _Questiontable.dataSource=self;
    _Questiontable.rowHeight=50;

}

-(void)setNavBar
{
    self.conditionsname = @"问题类别";
    self.title=self.conditionsname;
    self.view.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoMaintain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoMaintain
{
    [self.delegate sendQuestion:_questions];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[ConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        cell.backgroundColor = mainScreenColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = sColor(124, 124, 124, 1.0);
        
    }
    
    
    cell.logoImageView.image=[UIImage imageNamed:[imagearry objectAtIndex:indexPath.row]];
    
    
    
    cell.textLabel.text=[namearry objectAtIndex:indexPath.row];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<namearry.count;i++)
    {
        [imagearry addObject:@""];
        
        
    }
    
    [imagearry replaceObjectAtIndex:indexPath.row withObject:@"dui"];
    if (self.block) {
        block([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }
    
    _questions = [namearry objectAtIndex:indexPath.row];
    
    [_Questiontable reloadData];
}
@end
