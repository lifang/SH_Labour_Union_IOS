//
//  PersonalEditedViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/23.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "PersonalEditedViewController.h"
#import "navbarView.h"
#import "UserModel.h"
#import "UserTool.h"
#import "AppDelegate.h"
#import "IsPhone.h"

@interface PersonalEditedViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *userIDField;

@end

@implementation PersonalEditedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self initAndLayoutUI];
}

-(void)setNavBar
{
    self.title = @"个人信息管理";
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
    [_userIDField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_usernameField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userIDField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_usernameField resignFirstResponder];
    return YES;
}

-(void)save
{
    [_userIDField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_usernameField resignFirstResponder];
    if ([_userIDField.text isEqualToString:@""]&&[_usernameField.text isEqualToString:@""]&&[_emailField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请填写完善信息!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;

    }
    if (![_emailField.text isEqualToString:@""]&&![_emailField.text isKindOfClass:[NSNull class]]&&_emailField.text!=nil&&_emailField.text.length!=0) {
        
        if (![IsPhone validateEmail:_emailField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Email格式不正确!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    if ([_emailField.text isEqualToString:@"(null)"]||_emailField.text==nil||[_emailField.text isKindOfClass:[NSNull class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请填写完善信息!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![_userIDField.text isEqualToString:@""]) {
        if ([IsPhone isEmpty:_userIDField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入合法字符!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    if (![_usernameField.text isEqualToString:@""]) {
        if ([IsPhone isEmpty:_usernameField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入合法字符!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定!"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }

    }
    

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"完善中!";
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SLog(@"%@",_emailField.text);
        UserModel *account = [UserTool userModel];
        NSString *nickName = [_usernameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urls = [NSString stringWithFormat:@"/api/user/update?token=%@&id=%@&nickName=%@&email=%@&labourUnionCode=%@",account.token, account.userID,nickName,_emailField.text,_userIDField.text];
        NSLog(@"%@",urls);
        NSString *str = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id result = [KRHttpUtil getResultDataByPost:str param:nil];
        AppDelegate *delegate = [AppDelegate shareAppDelegate];
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                SLog(@"%@",result);
                UIAlertView *alertV1 = [[UIAlertView alloc]initWithTitle:@"完善成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV1 show];
                [hud hide:YES];
                if (![_usernameField.text isEqualToString:@""]) {
                    delegate.userIDName = _usernameField.text;
//                    account.userIDName = _usernameField.text;
//                    [UserTool save:account];
                }
                if (![_emailField.text isEqualToString:@""]) {
                     delegate.email = _emailField.text;
//                    account.email = _emailField.text;
//                    [UserTool save:account];
                }
                if (![_userIDField.text isEqualToString:@""]) {
                    delegate.labourUnionCode = _userIDField.text;
//                    account.LabourUnion = _userIDField.text;
//                    [UserTool save:account];
                }
                
                SLog(@"Email================%@",[[result objectForKey:@"result"] objectForKey:@"email"]);
                account.email = [[result objectForKey:@"result"] objectForKey:@"email"];
                account.userIDName = [[result objectForKey:@"result"] objectForKey:@"nickName"];
                account.username = [[result objectForKey:@"result"] objectForKey:@"username"];
                account.password = delegate.password;
                account.LabourUnion = [[result objectForKey:@"result"] objectForKey:@"labourUnionCode"];
                [UserTool save:account];
                SLog(@"完善成功----------%@",account.userIDName);
                [self.navigationController popViewControllerAnimated:YES];
            }
            //请求失败
            else
            {
                SLog(@"更换失败!");
                UIAlertView *alertV2 = [[UIAlertView alloc]initWithTitle:[result objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV2 show];
                [hud hide:YES];
            }
        });
    });

}

-(void)initAndLayoutUI
{
    CGFloat topSpace = 0.0f;  //距顶部
    CGFloat textFieldHeight = 44.0f; //输入框高度
    CGFloat labelSize = 20.0f; //输入框图片大小
    
    UserModel *account = [UserTool userModel];
    
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
    _usernameField.backgroundColor = [UIColor clearColor];
    _usernameField.delegate = self;
    _usernameField.textColor = sColor(167, 167, 167, 1.0);
    if ([account.userIDName isKindOfClass:[NSNull class]] || account.userIDName == nil||[account.userIDName isEqualToString:@"(null)"]) {
        _usernameField.text = @"";
    }else{
        _usernameField.text = account.userIDName;
    }
    _usernameField.font = [UIFont systemFontOfSize:15.f];
    UIView *leftUserView = [[UIView alloc]init];
    leftUserView.size = CGSizeMake(100, 30);
    
    UILabel *leftUser = [[UILabel alloc]init];
    leftUser.backgroundColor = [UIColor clearColor];
    leftUser.textAlignment = NSTextAlignmentCenter;
    leftUser.frame = CGRectMake(0, 5, 70, labelSize);
    leftUser.text = @"会员名";
    leftUser.font = mainFont;
    leftUser.textColor = sColor(56, 56, 56, 56);
    [leftUserView addSubview:leftUser];
    
    _usernameField.leftView = leftUserView;
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
    //Email
    _emailField = [[UITextField alloc] init];
    _emailField.translatesAutoresizingMaskIntoConstraints = NO;
    _emailField.borderStyle = UITextBorderStyleNone;
    _emailField.backgroundColor = [UIColor clearColor];
    _emailField.delegate = self;
    _emailField.textColor = sColor(167, 167, 167, 1.0);
    if ([account.email isKindOfClass:[NSNull class]] || account.email == nil||[account.email isEqualToString:@"(null)"]) {
        _emailField.text = @"";
    }else{
        _emailField.text = account.email;
    }
    _emailField.font = [UIFont systemFontOfSize:15.f];
    
    UIView *leftEmailView = [[UIView alloc]init];
    leftEmailView.size = CGSizeMake(100, 30);
    
    UILabel *leftEmail = [[UILabel alloc]init];
    leftEmail.backgroundColor = [UIColor clearColor];
    leftEmail.textAlignment = NSTextAlignmentCenter;
    leftEmail.frame = CGRectMake(0, 5, 70, labelSize);
    leftEmail.text = @"Email";
    leftEmail.font = mainFont;
    leftEmail.textColor = sColor(56, 56, 56, 56);
    [leftEmailView addSubview:leftEmail];

    _emailField.leftView = leftEmailView;
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
    
    
    //工会会员号
    _userIDField = [[UITextField alloc] init];
    _userIDField.translatesAutoresizingMaskIntoConstraints = NO;
    _userIDField.borderStyle = UITextBorderStyleNone;
    _userIDField.backgroundColor = [UIColor clearColor];
    _userIDField.delegate = self;
    _userIDField.textColor = sColor(167, 167, 167, 1.0);
    if ([account.LabourUnion isKindOfClass:[NSNull class]] || account.LabourUnion == nil||[account.LabourUnion isEqualToString:@"(null)"]) {
        _userIDField.text = @"";
    }else{
        _userIDField.text = account.LabourUnion;
    }
    _userIDField.font = [UIFont systemFontOfSize:15.f];
    
    UIView *leftuserIDView = [[UIView alloc]init];
    leftuserIDView.size = CGSizeMake(100, 30);
    
    UILabel *leftUserID = [[UILabel alloc]init];
    leftUserID.backgroundColor = [UIColor clearColor];
    leftUserID.textAlignment = NSTextAlignmentRight;
    leftUserID.frame = CGRectMake(0, 5, 90, labelSize);
    leftUserID.text = @"工会会员号";
    leftUserID.font = mainFont;
    leftUserID.textColor = sColor(56, 56, 56, 56);
    [leftuserIDView addSubview:leftUserID];
    
    _userIDField.leftView = leftuserIDView;
    _userIDField.leftViewMode = UITextFieldViewModeAlways;
    _userIDField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userIDField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_userIDField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:thirdLine
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_userIDField
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
                                                             toItem:_userIDField
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
