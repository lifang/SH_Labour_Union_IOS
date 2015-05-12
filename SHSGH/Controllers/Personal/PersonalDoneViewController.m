//
//  PersonalDoneViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "PersonalDoneViewController.h"
#import "HHZCommonGroup.h"
#import "HHZCommonItem.h"
#import "HHZCommonCell.h"
#import "HHZCommonArrowItem.h"
#import "HHZCommonSwitchItem.h"
#import "HHZCommonLabelItem.h"
#import "navbarView.h"
#import "PersonalManagerViewController.h"
#import "AppDelegate.h"
#import "UserTool.h"

@interface PersonalDoneViewController () <UIAlertViewDelegate>

@end

@implementation PersonalDoneViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavBar];
    
    [self setupGroups];
  
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupHeaderView];
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

-(void)setupHeaderView
{
    UIView *topView = [[UIView alloc]init];
    topView.size = CGSizeMake(mainScreenW, 90);
    
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"complete"]];
    leftView.frame = CGRectMake(20, 40, 34, 36);
    [topView addSubview:leftView];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.font = [UIFont systemFontOfSize:15];
    topLabel.text = @"请完善个人信息";
    UserModel *account = [UserTool userModel];
    if (![account.userIDName isKindOfClass:[NSNull class]]&&account.userIDName!=nil) {
        if ([account.userIDName isEqualToString:@"(null)"]) {
            topLabel.text = @"请完善个人信息";
        }else{
        topLabel.text = account.userIDName;
        }
    }
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    if (![delegate.userIDName isKindOfClass:[NSNull class]]&&delegate.userIDName!=nil) {
        if ([delegate.userIDName isEqualToString:@"(null)"]) {
            topLabel.text = @"请完善个人信息";
        }else{
        topLabel.text = delegate.userIDName;
        }
    }
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.textColor = sColor(75, 75, 75, 1.0);
    topLabel.frame = CGRectMake(CGRectGetMaxX(leftView.frame) + 2 *CostumViewMargin, CGRectGetMinY(leftView.frame) - CostumViewMargin, 130, 30);
    [topView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = [UIFont systemFontOfSize:12];
    bottomLabel.text = @"我的个人信息";
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textColor = sColor(179, 179, 179, 1.0);
    bottomLabel.frame = CGRectMake(topLabel.frame.origin.x, CGRectGetMaxY(topLabel.frame) - 2 * CostumViewMargin, 200, 26);
    [topView addSubview:bottomLabel];

    UIImageView *rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"particular_Gray"]];
    rightView.frame = CGRectMake(mainScreenW - rightView.frame.size.width * 3.4, CGRectGetMaxY(topLabel.frame) - 3 * CostumViewMargin, 10, 16);
    [topView addSubview:rightView];
    
    UIButton *headBtn = [[UIButton alloc]init];
    [headBtn addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    [headBtn setBackgroundColor:[UIColor clearColor]];
    headBtn.frame = topView.bounds;
    [topView addSubview:headBtn];
    
    self.tableView.tableHeaderView = topView;
}

-(void)headerClick
{
    PersonalManagerViewController *personVC = [[PersonalManagerViewController alloc]init];
    [self.navigationController pushViewController:personVC animated:YES];
    SLog(@"headerClick!");
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
    NSString *str = [NSString stringWithFormat:@"最新版本%@",text];
    versionsUp.subtitle = str;
    
    HHZCommonItem *exitUser = [HHZCommonItem itemWithTitle:@"退出帐号" icon:@"exit_Gray"];
    
    group.items = @[aboutUs,versionsUp,exitUser];

}

-(void)backtoDynamic
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self loadData];
    }
    if (indexPath.row == 2) {
        UIAlertView *sureView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要退出帐号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [sureView show];
    }
}

#pragma mark UIAlertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        SLog(@"点击了确定!");
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            UserModel *account = [UserTool userModel];
            NSString *urls = [NSString stringWithFormat:@"/api/user/loginOut?token=%@",account.token];
            id result = [KRHttpUtil getResultDataByPost:urls param:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                //成功
                if ([[result objectForKey:@"code"] integerValue]==1)
                {
                     //清除用户数据
                    [delegate clearLoginInfo];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                //请求失败
                else
                {
                    
                }
            });
        });
        
    }
}

@end
