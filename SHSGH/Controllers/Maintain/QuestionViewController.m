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
#import "ProductRegist.h"

@interface QuestionViewController ()

@property(nonatomic,strong)NSString *questions;
@property(nonatomic,strong)NSString *code;

@property(nonatomic,strong)NSMutableArray *productRegistArray;

@end

@implementation QuestionViewController
@synthesize block;

-(NSMutableArray *)productRegistArray
{
    if (!_productRegistArray) {
        _productRegistArray = [NSMutableArray array];
    }
    return _productRegistArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self loadDate];
    
//    namearry=[[NSArray alloc]initWithObjects:@"打工者的基本权利是什么?",@"什么是劳动合同?",@"劳动合同定立.变更和履行的原则有哪些?",@"用人单位只签订试用期合同怎么办?",@"社会保险是什么?",@"则么样界定辞退与自动离职?",@"执行国家福利时怎么分配?",@"工作环境极其恶劣怎么办?",@"乱收培训费怎么办?",@"法定节假日不放假怎么办?",@"兼职者收到侮辱怎么办?", nil];
//    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
//    for(NSInteger i=0;i<namearry.count;i++)
//    {
//        [imagearry addObject:@""];
//    }
//    
//    // Do any additional setup after loading the view.
//    _Questiontable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
//    
//    [self.view addSubview:_Questiontable];
//    _Questiontable.delegate=self;
//    _Questiontable.dataSource=self;
//    _Questiontable.rowHeight=50;
}

-(void)setupTableView
{
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
        for(NSInteger i=0;i<_productRegistArray.count;i++)
        {
            [imagearry addObject:@""];
        }
    
        // Do any additional setup after loading the view.
        _Questiontable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
    
        [self.view addSubview:_Questiontable];
        _Questiontable.delegate=self;
        _Questiontable.dataSource=self;
        _Questiontable.rowHeight=50;
    
       [_Questiontable reloadData];
}

-(void)loadDate
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urls =@"/api/protect/getType";
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        SLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~%@",result);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSArray *dataArray = [result objectForKey:@"result"];
                for (int i = 0; i < dataArray.count; i++) {
                    ProductRegist *registe = [[ProductRegist alloc]init];
                    registe.name = [[dataArray objectAtIndex:i] objectForKey:@"name"];
                    registe.code = [[dataArray objectAtIndex:i] objectForKey:@"code"];
                    [self.productRegistArray addObject:registe];
                }
                [self setupTableView];
            }
            else {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        });
    });
}

-(void)setNavBar
{
    self.conditionsname = @"问题类别";
    self.title=self.conditionsname;
    self.view.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoMaintain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoMaintain
{
    [self.delegate sendQuestion:_questions WithCode:_code];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productRegistArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[ConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        if (mainScreenH<=480) {
            cell.height = 20;
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = sColor(124, 124, 124, 1.0);
        
    }
    
    
    cell.logoImageView.image=[UIImage imageNamed:[imagearry objectAtIndex:indexPath.row]];
    
    
    ProductRegist *registe = [_productRegistArray objectAtIndex:indexPath.row];
    cell.textLabel.text = registe.name;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mainScreenH<=480) {
        return 40;
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    imagearry=[[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<_productRegistArray.count;i++)
    {
        [imagearry addObject:@""];
    }
    
    [imagearry replaceObjectAtIndex:indexPath.row withObject:@"dui"];
    if (self.block) {
        block([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }
    
    ProductRegist *registe = [_productRegistArray objectAtIndex:indexPath.row];
    self.questions = registe.name;
    self.code = registe.code;
    [_Questiontable reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
