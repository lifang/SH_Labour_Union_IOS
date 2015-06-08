//
//  PersonalViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/22.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "PersonalViewController.h"
#import "HHZCommonGroup.h"
#import "HHZCommonItem.h"
#import "HHZCommonCell.h"
#import "HHZCommonArrowItem.h"
#import "HHZCommonSwitchItem.h"
#import "HHZCommonLabelItem.h"
#import "navbarView.h"
#import "loginViewController.h"
#import "registerViewController.h"
#import "AboutUsController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setupGroups];
    [self setHeadView];
}

-(void)setHeadView
{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = mainScreenColor;
    headerV.frame = CGRectMake(0, 0, mainScreenW, 100);
    
    UIButton *loadBtn = [[UIButton alloc]init];
    [loadBtn addTarget:self action:@selector(loginVC) forControlEvents:UIControlEventTouchUpInside];
    [loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loadBtn setTitleColor:sColor(224, 84, 0, 1.0) forState:UIControlStateNormal];
    loadBtn.backgroundColor = [UIColor clearColor];
    loadBtn.frame = CGRectMake(0, 4, mainScreenW / 2, 100);
    
    UILabel *loadLabel = [[UILabel alloc]init];
    loadLabel.backgroundColor = [UIColor clearColor];
    loadLabel.textAlignment =  NSTextAlignmentCenter;
    loadLabel.textColor = sColor(166, 166, 166, 1.0);
    loadLabel.font = [UIFont systemFontOfSize:14];
    loadLabel.text = @"可管理个人信息等";
    loadLabel.frame = CGRectMake(0, (loadBtn.frame.size.height / 2) + (CostumViewMargin * 3), mainScreenW / 2, 26);
    [headerV addSubview:loadLabel];
    [headerV addSubview:loadBtn];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn addTarget:self action:@selector(registerVC) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:sColor(224, 84, 0, 1.0) forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.frame = CGRectMake(mainScreenW / 2, 4, mainScreenW / 2, 100);
    
    UILabel *registerLabel = [[UILabel alloc]init];
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.textAlignment =  NSTextAlignmentCenter;
    registerLabel.textColor = sColor(166, 166, 166, 1.0);
    registerLabel.font = [UIFont systemFontOfSize:14];
    registerLabel.text = @"可享受会员信息等";
    registerLabel.frame = CGRectMake(mainScreenW / 2, (loadBtn.frame.size.height / 2) + (CostumViewMargin * 3), mainScreenW / 2, 26);
    [headerV addSubview:registerLabel];
    [headerV addSubview:registerBtn];
    
    UIView *divisionLine = [[UIView alloc]init];
    divisionLine.backgroundColor = sColor(219, 219, 219, 1.0);
    divisionLine.frame = CGRectMake(mainScreenW / 2, 40, 1, 40);
    [headerV addSubview:divisionLine];
    
    self.tableView.tableHeaderView = headerV;
}

-(void)loginVC
{
    loginViewController *loginVC = [[loginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)registerVC
{
    registerViewController *registerVC = [[registerViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)setNavBar
{
    self.title = @"个人中心";
    self.tableView.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(backtoDynamic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)backtoDynamic
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setupGroups
{
    [self setupGroup0];
}

-(void)setupGroup0
{
    //1创建组
    HHZCommonGroup *group = [HHZCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组所有行的数据
    HHZCommonArrowItem *aboutUs = [HHZCommonArrowItem itemWithTitle:@"关于我们" icon:@"about_us"];
    
    HHZCommonArrowItem *versionsUp = [HHZCommonArrowItem itemWithTitle:@"版本升级" icon:@"upgrade"];
    NSString *text = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    NSString *str = [NSString stringWithFormat:@"当前版本%@",text];
    versionsUp.subtitle = str;
    
    group.items = @[aboutUs,versionsUp];

}
#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AboutUsController *aboutVC = [[AboutUsController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if (indexPath.row == 1) {
        [self loadData];
    }
//    if (indexPath.row == 2) {
//        UIAlertView *sureView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要退出帐号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [sureView show];
//    }
}

-(void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *urls = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppID];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        SLog(@"%@",result);
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                NSString *text = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSArray *infoArray = [result objectForKey:@"results"];
                    if ([infoArray count] > 0) {
                        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
                        if (![lastVersion isEqualToString:text]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                            message:@"有新版本是否更新?"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"取消"
                                                                  otherButtonTitles:@"更新", nil];
                            [alert show];
                        }
                        else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                            message:@"已是最新版本!!"
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }
                    }
                }
                
            }
            //请求失败
            else
            {
                UIAlertView *alertV2 = [[UIAlertView alloc]initWithTitle:@"请检查网络!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV2 show];
            }
        });
    });
    
}

@end
