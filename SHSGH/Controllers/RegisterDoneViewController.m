//
//  RegisterDoneViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/22.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "RegisterDoneViewController.h"
#import "navbarView.h"

@interface RegisterDoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *usermwssageField;
@property (nonatomic, strong) UITextField *emailField;
@end

@implementation RegisterDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    [self initAndLayoutUI];
   
}

-(void)setNavBar
{
    self.view.backgroundColor = mainScreenColor;
    self.title = @"其他信息填写";
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    [buttonL.navButton setImage:[UIImage imageNamed:@"back_btn_white@2x"] forState:UIControlStateNormal];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)initAndLayoutUI
{
    CGFloat topSpace = 0.0f;  //距顶部
    CGFloat textFieldHeight = 44.0f; //输入框高度
    CGFloat imageSize = 20.0f; //输入框图片大小
    CGFloat signBtnOriginX = 16.f; //登录按钮左侧
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor redColor];
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
                                                           constant:100.f]];
    
    
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
    _usermwssageField = [[UITextField alloc] init];
    _usermwssageField.translatesAutoresizingMaskIntoConstraints = NO;
    _usermwssageField.borderStyle = UITextBorderStyleNone;
    _usermwssageField.backgroundColor = [UIColor whiteColor];
    _usermwssageField.delegate = self;
    _usermwssageField.placeholder = @"请输入身份证";
    _usermwssageField.font = [UIFont systemFontOfSize:15.f];
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, imageSize)];
    UIImageView *nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, imageSize, imageSize)];
    nameImageView.image = [UIImage imageNamed:@"identity_card"];
    [nameView addSubview:nameImageView];
    _usermwssageField.leftView = nameView;
    _usermwssageField.leftViewMode = UITextFieldViewModeAlways;
    _usermwssageField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usermwssageField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_usermwssageField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermwssageField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermwssageField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermwssageField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:firstLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_usermwssageField
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
                                                             toItem:_usermwssageField
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
    _emailField.secureTextEntry = YES;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
