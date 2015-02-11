//
//  RegisterDoneViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/22.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "RegisterDoneViewController.h"
#import "navbarView.h"
#import "PersonalDoneViewController.h"
#import "AppDelegate.h"
#import "UserTool.h"
#import "UserModel.h"
#import "IsPhone.h"

@interface RegisterDoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *usermessageField;
@property (nonatomic, strong) UITextField *emailField;
@end

@implementation RegisterDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    [self initAndLayoutUI];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    SLog(@"%@",delegate.userId);
    
}


-(void)setNavBar
{
    self.view.backgroundColor = mainScreenColor;
    self.title = @"其他信息填写";
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setTitle:@"跳过" forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)skip
{
    PersonalDoneViewController *PersonDoneVC = [[PersonalDoneViewController alloc]init];
    [self.navigationController pushViewController:PersonDoneVC animated:YES];
}


-(void)initAndLayoutUI
{
    CGFloat topSpace = 0.0f;  //距顶部
    CGFloat textFieldHeight = 44.0f; //输入框高度
    CGFloat imageSize = 20.0f; //输入框图片大小
    CGFloat signBtnOriginX = 16.f; //登录按钮左侧
    
    UIView *topView = [[UIView alloc]init];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image =[UIImage imageNamed:@"right"];
    imageV.frame = CGRectMake(50, 30, 30, 24);
    [topView addSubview:imageV];
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont systemFontOfSize:15];
    topLabel.text = @"恭喜您,注册成功。";
    topLabel.textColor = sColor(75, 75, 75, 1.0);
    topLabel.frame = CGRectMake(CGRectGetMaxX(imageV.frame) + 2 *CostumViewMargin, CGRectGetMinY(imageV.frame) - 4 * CostumViewMargin, 130, 30);
    [topView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.font = [UIFont systemFontOfSize:12];
    bottomLabel.text = @"完善以下信息将获得更多权益与信息!";
    bottomLabel.textColor = sColor(179, 179, 179, 1.0);
    bottomLabel.frame = CGRectMake(topLabel.frame.origin.x, CGRectGetMaxY(topLabel.frame) -CostumViewMargin, 200, 26);
    [topView addSubview:bottomLabel];
    
    
    topView.backgroundColor = [UIColor clearColor];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:topSpace]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:80.f]];
    
    
    //first line
    UIView *firstLine = [[UIView alloc] init];
    firstLine.translatesAutoresizingMaskIntoConstraints = NO;
    firstLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:firstLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:topView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
    //身份证
    _usermessageField = [[UITextField alloc] init];
    _usermessageField.translatesAutoresizingMaskIntoConstraints = NO;
    _usermessageField.borderStyle = UITextBorderStyleNone;
    _usermessageField.backgroundColor = [UIColor whiteColor];
    _usermessageField.delegate = self;
    _usermessageField.placeholder = @"请输入工会会员号";
    _usermessageField.font = [UIFont systemFontOfSize:15.f];
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    nameImageView.image = [UIImage imageNamed:@"identity_card"];
    [nameView addSubview:nameImageView];
    _usermessageField.leftView = nameView;
    _usermessageField.leftViewMode = UITextFieldViewModeAlways;
    _usermessageField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usermessageField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_usermessageField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermessageField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermessageField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermessageField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:firstLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermessageField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:textFieldHeight]];
    
    //second line
    UIView *secondLine = [[UIView alloc] init];
    secondLine.translatesAutoresizingMaskIntoConstraints = NO;
    secondLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:secondLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_usermessageField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
    //email
    _emailField = [[UITextField alloc] init];
    _emailField.translatesAutoresizingMaskIntoConstraints = NO;
    _emailField.borderStyle = UITextBorderStyleNone;
    _emailField.backgroundColor = [UIColor whiteColor];
    _emailField.delegate = self;
    _emailField.placeholder = @"请输入邮件";
    _emailField.font = [UIFont systemFontOfSize:15.f];
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    passwordImageView.image = [UIImage imageNamed:@"email_Gray"];
    [passwordView addSubview:passwordImageView];
    _emailField.leftView = passwordView;
    _emailField.leftViewMode = UITextFieldViewModeAlways;
    _emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_emailField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:secondLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:textFieldHeight]];
    //third line
    UIView *thirdLine = [[UIView alloc] init];
    thirdLine.translatesAutoresizingMaskIntoConstraints = NO;
    thirdLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:thirdLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_emailField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
    
    //完成
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.translatesAutoresizingMaskIntoConstraints = NO;
    signInBtn.layer.cornerRadius = 4;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [signInBtn setTitle:@"完成" forState:UIControlStateNormal];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"btn-h"] forState:UIControlStateNormal];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"btn-r"] forState:UIControlStateHighlighted];
    [signInBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInBtn];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:signInBtn
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:thirdLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:signInBtn
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:signBtnOriginX]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:signInBtn
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-signBtnOriginX]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:signInBtn
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:40]];

}

-(void)done
{
    
    //输入验证
    if (!_usermessageField.text || [_usermessageField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"身份证不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([IsPhone isEmpty:_usermessageField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请输入合法字符!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (!_emailField.text || [_emailField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Email不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![IsPhone validateEmail:_emailField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Email格式不正确!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"完善中!";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSString *urls = [NSString stringWithFormat:@"/api/user/update?token=%@&id=%@&email=%@&labourUnionCode=%@",delegate.token, delegate.userId,_emailField.text,_usermessageField.text];
        id result = [KRHttpUtil getResultDataByPost:urls param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                UIAlertView *alertV1 = [[UIAlertView alloc]initWithTitle:@"完善成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV1 show];
                [hud hide:YES];
                UserModel *account = [UserTool userModel];
                account.email = _emailField.text;
                account.LabourUnion = _usermessageField.text;
                [UserTool save:account];
            }
            //请求失败
            else
            {
                SLog(@"注册失败!");
                UIAlertView *alertV2 = [[UIAlertView alloc]initWithTitle:@"完善失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV2 show];
                [hud hide:YES];
            }
        });
    });
    
    PersonalDoneViewController *personalDoneVC = [[PersonalDoneViewController alloc]init];
    
    [self.navigationController pushViewController:personalDoneVC animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
