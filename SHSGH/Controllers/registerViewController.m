//
//  registerViewController.m
//  SZGH
//
//  Created by lihongliang on 15/1/17.
//  Copyright (c) 2015年 Apress. All rights reserved.
//

#import "registerViewController.h"
#import "navbarView.h"
#import "SearchJobViewController.h"
#import "RegisterDoneViewController.h"

@interface registerViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *passwordSureField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *authcodeField;
@end

@implementation registerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initAndLayoutUI];
}
-(void)searchButtonclick
{
    SearchJobViewController*v=[[SearchJobViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}

-(void)setNavBar
{
    self.title = @"注册";
    self.view.backgroundColor = mainScreenColor;
    
    navbarView *leftView = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [leftView.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
    [leftView.navButton addTarget:self action:@selector(backNavBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    navbarView *rightView = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [rightView.navButton setTitle:@"登录" forState:UIControlStateNormal];
    [rightView.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [rightView.navButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;

}

-(void)login
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backNavBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initAndLayoutUI
{
    CGFloat topSpace = 14.0f;  //距顶部
    CGFloat textFieldHeight = 44.0f; //输入框高度
    CGFloat imageSize = 20.0f; //输入框图片大小
    CGFloat signBtnOriginX = 16.f; //确认按钮左侧
    
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
    //用户名
    _usernameField = [[UITextField alloc] init];
    _usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameField.borderStyle = UITextBorderStyleNone;
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.delegate = self;
    _usernameField.placeholder = @"请输入用户名";
    _usernameField.font = [UIFont systemFontOfSize:15.f];
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    nameImageView.image = [UIImage imageNamed:@"accounts"];
    [nameView addSubview:nameImageView];
    _usernameField.leftView = nameView;
    _usernameField.leftViewMode = UITextFieldViewModeAlways;
    _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_usernameField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usernameField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usernameField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usernameField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:firstLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usernameField
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
                                                             toItem:_usernameField
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
    //密码
    _passwordField = [[UITextField alloc] init];
    _passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordField.borderStyle = UITextBorderStyleNone;
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.delegate = self;
    _passwordField.placeholder = @"请输入密码";
    _passwordField.font = [UIFont systemFontOfSize:15.f];
    _passwordField.secureTextEntry = YES;
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    passwordImageView.image = [UIImage imageNamed:@"password"];
    [passwordView addSubview:passwordImageView];
    _passwordField.leftView = passwordView;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_passwordField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:secondLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField
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
                                                             toItem:_passwordField
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
    
    //确认用户名
    _passwordSureField = [[UITextField alloc]init];
    _passwordSureField.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordSureField.borderStyle = UITextBorderStyleNone;
    _passwordSureField.backgroundColor = [UIColor whiteColor];
    _passwordSureField.delegate = self;
    _passwordSureField.placeholder = @"请确认密码";
    _passwordSureField.font = [UIFont systemFontOfSize:15.f];
    _passwordSureField.secureTextEntry = YES;
    UIView *passwordSureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *passwordSureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    passwordSureImageView.image = [UIImage imageNamed:@"password"];
    [passwordSureView addSubview:passwordSureImageView];
    _passwordSureField.leftView = passwordSureView;
    _passwordSureField.leftViewMode = UITextFieldViewModeAlways;
    _passwordSureField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordSureField.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_passwordSureField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSureField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:thirdLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSureField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSureField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSureField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:textFieldHeight]];
    
    
    //fourth line
    UIView *fourthLine = [[UIView alloc] init];
    fourthLine.translatesAutoresizingMaskIntoConstraints = NO;
    fourthLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:fourthLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fourthLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_passwordSureField
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
    
    //输入手机号
    _phoneField = [[UITextField alloc]init];
    _phoneField.translatesAutoresizingMaskIntoConstraints = NO;
    _phoneField.borderStyle = UITextBorderStyleNone;
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.delegate = self;
    _phoneField.placeholder = @"请输入您的手机号";
    _phoneField.font = [UIFont systemFontOfSize:15.f];
    _phoneField.secureTextEntry = YES;
    UIView *_phoneFieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *_phoneFieldImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    _phoneFieldImageView.image = [UIImage imageNamed:@"iphone"];
    [_phoneFieldView addSubview:_phoneFieldImageView];
    
    UIView *rightViewFS = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    UIButton *send = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 30)];
    [send setBackgroundImage:[UIImage imageNamed:@"btn-h1"] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage imageNamed:@"btn-h2"] forState:UIControlStateHighlighted];
    [send addTarget:self action:@selector(authcode) forControlEvents:UIControlEventTouchUpInside];
    send.titleLabel.tintColor = [UIColor whiteColor];
    send.titleLabel.font = [UIFont systemFontOfSize:13];
    [send setTitle:@"验证码" forState:UIControlStateNormal];
    [rightViewFS addSubview:send];
    rightViewFS.backgroundColor = [UIColor clearColor];
    _phoneField.rightView = rightViewFS;
    _phoneField.rightViewMode = UITextFieldViewModeAlways;
    _phoneField.leftView = _phoneFieldView;
    _phoneField.leftViewMode = UITextFieldViewModeAlways;
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_phoneField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:fourthLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:textFieldHeight]];
    
    //fifthline
    UIView *fifthLine = [[UIView alloc] init];
    fifthLine.translatesAutoresizingMaskIntoConstraints = NO;
    fifthLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:fifthLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fifthLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_phoneField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fifthLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fifthLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fifthLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
    
    //输入验证码
    _authcodeField = [[UITextField alloc]init];
    _authcodeField.translatesAutoresizingMaskIntoConstraints = NO;
    _authcodeField.borderStyle = UITextBorderStyleNone;
    _authcodeField.backgroundColor = [UIColor whiteColor];
    _authcodeField.delegate = self;
    _authcodeField.placeholder = @"请输入验证码";
    _authcodeField.font = [UIFont systemFontOfSize:15.f];
    _authcodeField.secureTextEntry = YES;
    UIView *_authcodeFieldView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *_authcodeFieldImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    _authcodeFieldImageView.image = [UIImage imageNamed:@"authcode_Gray"];
    [_authcodeFieldView addSubview:_authcodeFieldImageView];
    _authcodeField.leftView = _authcodeFieldView;
    _authcodeField.leftViewMode = UITextFieldViewModeAlways;
    _authcodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _authcodeField.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_authcodeField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authcodeField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:fifthLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authcodeField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authcodeField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authcodeField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:textFieldHeight]];
    
    //sixthline
    UIView *sixthLine = [[UIView alloc] init];
    sixthLine.translatesAutoresizingMaskIntoConstraints = NO;
    sixthLine.backgroundColor = HHZColor(194, 213, 224);
    [self.view addSubview:sixthLine];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sixthLine
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_authcodeField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sixthLine
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sixthLine
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sixthLine
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:0.5f]];
    
    //下一步
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.translatesAutoresizingMaskIntoConstraints = NO;
    makeSureBtn.layer.cornerRadius = 4;
    makeSureBtn.layer.masksToBounds = YES;
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [makeSureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"btn-h"] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"btn-r"] forState:UIControlStateHighlighted];
    [makeSureBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeSureBtn];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:makeSureBtn
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:sixthLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:makeSureBtn
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:signBtnOriginX]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:makeSureBtn
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-signBtnOriginX]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:makeSureBtn
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:40]];
}
-(void)next
{
    RegisterDoneViewController *registerVC = [[RegisterDoneViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    SLog(@"下一步!");
}
-(void)authcode
{
    SLog(@"验证码!");
}
@end
