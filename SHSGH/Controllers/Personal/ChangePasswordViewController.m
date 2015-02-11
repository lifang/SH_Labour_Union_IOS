//
//  ChangePasswordViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "PersonalManagerViewController.h"
#import "UserTool.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *oldPasswordField;
@property (nonatomic, strong) UITextField *newsPasswordField;
@property (nonatomic, strong) UITextField *surePasswordField;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initAndLayoutUI];
}

-(void)setNavBar
{
    self.title = @"修改密码";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setTitle:@"保存" forState:UIControlStateNormal];
    [buttonR.navButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)back
{
    if (_oldPasswordField.text || [_oldPasswordField.text isEqualToString:@""]) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.password = _passWD;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    SLog(@"点击了save!");
        NSString *kPromptInfo = @"";
        //输入验证
        UserModel *account = [UserTool userModel];
        if (![_oldPasswordField.text isEqualToString:account.password]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kPromptInfo
                                                            message:@"旧密码错误!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    
        if (!_oldPasswordField.text || [_oldPasswordField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kPromptInfo
                                                            message:@"旧密码不能为空!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (!_newsPasswordField.text || [_newsPasswordField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kPromptInfo
                                                            message:@"新密码不能为空!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (!_surePasswordField.text || [_surePasswordField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kPromptInfo
                                                            message:@"确认密码不能为空!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (![_newsPasswordField.text isEqualToString:_surePasswordField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kPromptInfo
                                                            message:@"密码确认失败,请重新输入!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"正在修改中!";
    
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            NSString *urls = [NSString stringWithFormat:@"/api/user/changePassword?token=%@&id=%@&password=%@&newpwd=%@",delegate.token, delegate.userId,_oldPasswordField.text,_newsPasswordField.text];
            id result = [KRHttpUtil getResultDataByPost:urls param:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                //成功
                if ([[result objectForKey:@"code"] integerValue]==1)
                {
                    UIAlertView *alertV1 = [[UIAlertView alloc]initWithTitle:@"修改成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertV1 show];
                    [hud hide:YES];
                    SLog(@"%@",result);
                    delegate.password = _newsPasswordField.text;
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                //请求失败
                else
                {
                    SLog(@"修改失败!");
                    UIAlertView *alertV2 = [[UIAlertView alloc]initWithTitle:@"修改失败!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertV2 show];
                    [hud hide:YES];
                    delegate.password = _oldPasswordField.text;
                }
            });
        });
}

-(void)initAndLayoutUI
{
    CGFloat topSpace = 0.0f;  //距顶部
    CGFloat textFieldHeight = 44.0f; //输入框高度
    CGFloat labelSize = 20.0f; //输入框图片大小
    
    //first line
    UIView *firstLine = [[UIView alloc] init];
    firstLine.translatesAutoresizingMaskIntoConstraints = NO;
    firstLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:firstLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:topSpace]];
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
    //原始密码
    _oldPasswordField = [[UITextField alloc] init];
    _oldPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    _oldPasswordField.borderStyle = UITextBorderStyleNone;
    _oldPasswordField.backgroundColor = [UIColor clearColor];
    _oldPasswordField.delegate = self;
    _oldPasswordField.placeholder = @"请输入原始密码";
    _oldPasswordField.font = [UIFont systemFontOfSize:15.f];
    _oldPasswordField.secureTextEntry = YES;
    
    UIView *leftoldPasswordView = [[UIView alloc]init];
    leftoldPasswordView.size = CGSizeMake(100, 30);
    
    UILabel *leftoldPassword = [[UILabel alloc]init];
    leftoldPassword.backgroundColor = [UIColor clearColor];
    leftoldPassword.textAlignment = NSTextAlignmentCenter;
    leftoldPassword.frame = CGRectMake(0, 5, 90, labelSize);
    leftoldPassword.text = @"原始密码";
    leftoldPassword.font = mainFont;
    leftoldPassword.textColor = sColor(56, 56, 56, 56);
    [leftoldPasswordView addSubview:leftoldPassword];
    
    _oldPasswordField.leftView = leftoldPasswordView;
    _oldPasswordField.leftViewMode = UITextFieldViewModeAlways;
    _oldPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _oldPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_oldPasswordField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPasswordField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPasswordField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPasswordField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:firstLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPasswordField
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
                                                             toItem:_oldPasswordField
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
    //新密码
    _newsPasswordField = [[UITextField alloc] init];
    _newsPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    _newsPasswordField.borderStyle = UITextBorderStyleNone;
    _newsPasswordField.backgroundColor = [UIColor clearColor];
    _newsPasswordField.delegate = self;
    _newsPasswordField.placeholder = @"请输入新密码";
    _newsPasswordField.font = [UIFont systemFontOfSize:15.f];
    _newsPasswordField.secureTextEntry = YES;
    
    UIView *leftnewPasswordView = [[UIView alloc]init];
    leftnewPasswordView.size = CGSizeMake(100, 30);
    
    UILabel *leftnewPassword = [[UILabel alloc]init];
    leftnewPassword.backgroundColor = [UIColor clearColor];
    leftnewPassword.textAlignment = NSTextAlignmentCenter;
    leftnewPassword.frame = CGRectMake(4, 5, 70, labelSize);
    leftnewPassword.text = @"新密码";
    leftnewPassword.font = mainFont;
    leftnewPassword.textColor = sColor(56, 56, 56, 56);
    [leftnewPasswordView addSubview:leftnewPassword];
    
    _newsPasswordField.leftView = leftnewPasswordView;
    _newsPasswordField.leftViewMode = UITextFieldViewModeAlways;
    _newsPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _newsPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_newsPasswordField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPasswordField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPasswordField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPasswordField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:secondLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPasswordField
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
                                                             toItem:_newsPasswordField
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
    
    
    //确认新密码
    _surePasswordField = [[UITextField alloc] init];
    _surePasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    _surePasswordField.borderStyle = UITextBorderStyleNone;
    _surePasswordField.backgroundColor = [UIColor clearColor];
    _surePasswordField.delegate = self;
    _surePasswordField.placeholder = @"请确认新密码";
    _surePasswordField.font = [UIFont systemFontOfSize:15.f];
    _surePasswordField.secureTextEntry = YES;
    
    UIView *lefturePasswordView = [[UIView alloc]init];
    lefturePasswordView.size = CGSizeMake(100, 30);
    
    UILabel *leftsurePassword = [[UILabel alloc]init];
    leftsurePassword.backgroundColor = [UIColor clearColor];
    leftsurePassword.textAlignment = NSTextAlignmentRight;
    leftsurePassword.frame = CGRectMake(0, 5, 90, labelSize);
    leftsurePassword.text = @"确认新密码";
    leftsurePassword.font = mainFont;
    leftsurePassword.textColor = sColor(56, 56, 56, 56);
    [lefturePasswordView addSubview:leftsurePassword];
    
    _surePasswordField.leftView = lefturePasswordView;
    _surePasswordField.leftViewMode = UITextFieldViewModeAlways;
    _surePasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _surePasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_surePasswordField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_surePasswordField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_surePasswordField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_surePasswordField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:thirdLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_surePasswordField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:textFieldHeight]];
    
    //fourth line
    UIView *fourthLine = [[UIView alloc] init];
    fourthLine.translatesAutoresizingMaskIntoConstraints = NO;
    fourthLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:fourthLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fourthLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_surePasswordField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fourthLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fourthLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fourthLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
}


@end
