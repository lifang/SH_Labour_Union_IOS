//
//  ChangePhoneViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "navbarView.h"

@interface ChangePhoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *oldPhoneField;
@property (nonatomic, strong) UITextField *authCodeField;
@property (nonatomic, strong) UITextField *newsPhoneField;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initAndLayoutUI];
}

-(void)setNavBar
{
    self.title = @"更换手机";
    self.view.backgroundColor = sColor(236, 236, 236, 1.0);
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    SLog(@"点击了save!");
    [self.navigationController popViewControllerAnimated:YES];
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
    //原手机号码
    _oldPhoneField = [[UITextField alloc] init];
    _oldPhoneField.translatesAutoresizingMaskIntoConstraints = NO;
    _oldPhoneField.borderStyle = UITextBorderStyleNone;
    _oldPhoneField.backgroundColor = [UIColor clearColor];
    _oldPhoneField.delegate = self;
    _oldPhoneField.placeholder = @"15848554844";
    _oldPhoneField.font = [UIFont systemFontOfSize:15.f];
    
    UIView *leftoldPhoneView = [[UIView alloc]init];
    leftoldPhoneView.size = CGSizeMake(100, 30);
    
    UILabel *leftoldPhone = [[UILabel alloc]init];
    leftoldPhone.textAlignment = NSTextAlignmentRight;
    leftoldPhone.frame = CGRectMake(0, 5, 90, labelSize);
    leftoldPhone.text = @"原手机号码";
    leftoldPhone.font = mainFont;
    leftoldPhone.textColor = sColor(56, 56, 56, 56);
    [leftoldPhoneView addSubview:leftoldPhone];
    
    UIView *rightViewFS = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    UIButton *send = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 30)];
    [send setBackgroundImage:[UIImage imageNamed:@"btn-h1"] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage imageNamed:@"btn-h2"] forState:UIControlStateHighlighted];
    [send addTarget:self action:@selector(authCode) forControlEvents:UIControlEventTouchUpInside];
    send.titleLabel.tintColor = [UIColor whiteColor];
    send.titleLabel.font = [UIFont systemFontOfSize:13];
    [send setTitle:@"验证码" forState:UIControlStateNormal];
    [rightViewFS addSubview:send];
    rightViewFS.backgroundColor = [UIColor clearColor];
    _oldPhoneField.rightView = rightViewFS;
    _oldPhoneField.rightViewMode = UITextFieldViewModeAlways;

    
    _oldPhoneField.leftView = leftoldPhoneView;
    _oldPhoneField.leftViewMode = UITextFieldViewModeAlways;
    _oldPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _oldPhoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_oldPhoneField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPhoneField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPhoneField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPhoneField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:firstLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_oldPhoneField
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
                                                             toItem:_oldPhoneField
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
    //验证码
    _authCodeField = [[UITextField alloc] init];
    _authCodeField.translatesAutoresizingMaskIntoConstraints = NO;
    _authCodeField.borderStyle = UITextBorderStyleNone;
    _authCodeField.backgroundColor = [UIColor clearColor];
    _authCodeField.delegate = self;
    _authCodeField.placeholder = @"suxiaon@126.com";
    _authCodeField.font = [UIFont systemFontOfSize:15.f];
    _authCodeField.secureTextEntry = YES;
    
    UIView *leftauthCodeView = [[UIView alloc]init];
    leftauthCodeView.size = CGSizeMake(100, 30);
    
    UILabel *leftauthCode = [[UILabel alloc]init];
    leftauthCode.textAlignment = NSTextAlignmentCenter;
    leftauthCode.frame = CGRectMake(0, 5, 70, labelSize);
    leftauthCode.text = @"Email";
    leftauthCode.font = mainFont;
    leftauthCode.textColor = sColor(56, 56, 56, 56);
    [leftauthCodeView addSubview:leftauthCode];
    
    _authCodeField.leftView = leftauthCodeView;
    _authCodeField.leftViewMode = UITextFieldViewModeAlways;
    _authCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _authCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_authCodeField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authCodeField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authCodeField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authCodeField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:secondLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_authCodeField
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
                                                             toItem:_authCodeField
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
    
    
    //新手机号码
    _newsPhoneField = [[UITextField alloc] init];
    _newsPhoneField.translatesAutoresizingMaskIntoConstraints = NO;
    _newsPhoneField.borderStyle = UITextBorderStyleNone;
    _newsPhoneField.backgroundColor = [UIColor clearColor];
    _newsPhoneField.delegate = self;
    _newsPhoneField.placeholder = @"20552544451255559596";
    _newsPhoneField.font = [UIFont systemFontOfSize:15.f];
    _newsPhoneField.secureTextEntry = YES;
    
    UIView *leftewPhoneView = [[UIView alloc]init];
    leftewPhoneView.size = CGSizeMake(100, 30);
    
    UILabel *leftnewPhone = [[UILabel alloc]init];
    leftnewPhone.textAlignment = NSTextAlignmentRight;
    leftnewPhone.frame = CGRectMake(0, 5, 90, labelSize);
    leftnewPhone.text = @"工会会员号";
    leftnewPhone.font = mainFont;
    leftnewPhone.textColor = sColor(56, 56, 56, 56);
    [leftewPhoneView addSubview:leftnewPhone];
    
    _newsPhoneField.leftView = leftewPhoneView;
    _newsPhoneField.leftViewMode = UITextFieldViewModeAlways;
    _newsPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _newsPhoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_newsPhoneField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPhoneField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPhoneField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPhoneField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:thirdLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_newsPhoneField
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
                                                             toItem:_newsPhoneField
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

-(void)authCode
{
    SLog(@"发送验证码!");
}

@end