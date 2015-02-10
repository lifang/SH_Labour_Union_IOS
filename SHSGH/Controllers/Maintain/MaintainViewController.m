//
//  MaintainViewController.m
//  SHSGH
//
//  Created by lihongliang on 15/1/24.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "MaintainViewController.h"
#import "navbarView.h"
#import "AppDelegate.h"
#import "PersonalViewController.h"
#import "HHZTextView.h"
#import "QuestionViewController.h"
#import "UserTool.h"
#import "UserModel.h"
#import "UserModel.h"
#import "UserTool.h"
#import "IsPhone.h"
#import "loginViewController.h"
#import "PersonalDoneViewController.h"

@interface MaintainViewController ()<UITextFieldDelegate,UITextViewDelegate,sendQuestion,UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *contentView;

@property(nonatomic,weak)UIButton *leftBtn;

@property(nonatomic,weak)UIButton *rightBtn;

@property(nonatomic,strong)UITextField *nameField;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *addressField;
@property(nonatomic,strong)UITextField *emailField;
@property(nonatomic,strong)UITextField *questionField;
@property(nonatomic,strong)UITextField *titleField;
@property(nonatomic,strong)HHZTextView *contentField;

@property(nonatomic,strong)QuestionViewController *questionVC;


@end

@implementation MaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setUpUI];
    QuestionViewController *questionVC = [[QuestionViewController alloc]init];
    _questionVC = questionVC;
}

-(void)setUpUI
{
    //整个界面
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.backgroundColor = sColor(236, 236, 236, 1.0);
    contentView.delegate = self;
    //顶部View
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = sColor(245, 241, 201, 1.0);
    topView.layer.cornerRadius = 4;
    topView.layer.masksToBounds = YES;
    topView.frame = CGRectMake(15, 15, mainScreenW * 0.9, 66);
    //顶部View 感叹号图片
    UIImageView *leftImage = [[UIImageView alloc]init];
    leftImage.frame = CGRectMake(12, 20, 25, 25);
    leftImage.image = [UIImage imageNamed:@"i"];
    [topView addSubview:leftImage];
    //顶部View 右边公告Lable
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.backgroundColor = [UIColor clearColor];
    NSString *rightLabelText = @"此服务提供广大职工向工会提出自己的疑问,相关问题将在后续第一时间答复。";
    rightLabel.text = rightLabelText;
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.textColor = sColor(163, 162, 136, 1.0);
    rightLabel.numberOfLines = 2;
    rightLabel.frame = CGRectMake(CGRectGetMaxX(leftImage.frame) + 3 * CostumViewMargin, 8, contentView.frame.size.width * 0.7, leftImage.frame.size.height + 30);
    [topView addSubview:rightLabel];
    [contentView addSubview:topView];
    //选择segmentedControl
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",nil];
    UISegmentedControl *segmentView = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentView.frame = CGRectMake(topView.frame.origin.x, CGRectGetMaxY(topView.frame) + 3 *CostumViewMargin, topView.frame.size.width, 32);
    segmentView.tintColor = [UIColor orangeColor];
    segmentView.momentary = NO;
    [segmentView setTitle:@"游客维权区" forSegmentAtIndex:0];
    [segmentView setTitle:@"会员维权区" forSegmentAtIndex:1];
    [segmentView addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentView.selectedSegmentIndex = 0;
    [contentView addSubview:segmentView];
    //分隔线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = sColor(200, 200, 200, 1.0);
    lineView.frame = CGRectMake(0, CGRectGetMaxY(segmentView.frame) + 4 * CostumViewMargin, mainScreenW, 1);
    [contentView addSubview:lineView];
    //分隔线下方控件
    CGFloat labelWidth = 60;
    CGFloat labelHeight = 20;
    //姓名
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = sColor(90, 90, 90, 1.0);
    nameLabel.text = @"姓名";
    nameLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(lineView.frame) + 4 * CostumViewMargin, labelWidth * 0.5, labelHeight);
    [contentView addSubview:nameLabel];
    //红色星星
    UILabel *redStar1 = [[UILabel alloc]init];
    redStar1.backgroundColor = [UIColor clearColor];
    redStar1.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + CostumViewMargin, nameLabel.frame.origin.y, labelWidth * 0.25, labelHeight);
    redStar1.textColor = sColor(227, 15, 46, 1.0);
    redStar1.text = @"*";
    redStar1.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:redStar1];
    //姓名输入框
    CGFloat fieldWidth = mainScreenW * 0.84;
    CGFloat fieldHeight = 32;
    _nameField = [[UITextField alloc]init];
    UIView *leftV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _nameField.delegate = self;
    _nameField.leftView = leftV1;
    _nameField.leftViewMode = UITextFieldViewModeAlways;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.layer.cornerRadius = 2;
    _nameField.layer.masksToBounds = YES;
    _nameField.placeholder = @"请输入您的姓名";
    [_nameField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_nameField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _nameField.backgroundColor = [UIColor whiteColor];
    _nameField.frame = CGRectMake(CGRectGetMinX(nameLabel.frame),CGRectGetMaxY(nameLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_nameField];
    //联系电话
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = sColor(90, 90, 90, 1.0);
    phoneLabel.text = @"联系电话";
    phoneLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_nameField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:phoneLabel];
    //红色星星
    UILabel *redStar2 = [[UILabel alloc]init];
    redStar2.backgroundColor = [UIColor clearColor];
    redStar2.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + CostumViewMargin, phoneLabel.frame.origin.y, labelWidth * 0.25, labelHeight);
    redStar2.textColor = sColor(227, 15, 46, 1.0);
    redStar2.text = @"*";
    redStar2.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:redStar2];
    //联系电话输入框
    _phoneField = [[UITextField alloc]init];
    UIView *leftV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _phoneField.delegate = self;
    _phoneField.leftView = leftV2;
    _phoneField.leftViewMode = UITextFieldViewModeAlways;
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneField.layer.cornerRadius = 2;
    _phoneField.layer.masksToBounds = YES;
    _phoneField.placeholder = @"请输入您的手机号码";
    [_phoneField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_phoneField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.frame = CGRectMake(CGRectGetMinX(phoneLabel.frame),CGRectGetMaxY(phoneLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_phoneField];
    //联系地址
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = [UIFont systemFontOfSize:15];
    addressLabel.textColor = sColor(90, 90, 90, 1.0);
    addressLabel.text = @"联系地址";
    addressLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_phoneField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:addressLabel];
    //联系地址输入框
    _addressField = [[UITextField alloc]init];
    UIView *leftV3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _addressField.delegate = self;
    _addressField.leftView = leftV3;
    _addressField.leftViewMode = UITextFieldViewModeAlways;
    _addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _addressField.layer.cornerRadius = 2;
    _addressField.layer.masksToBounds = YES;
    _addressField.placeholder = @"请输入您的联系地址";
    [_addressField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_addressField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _addressField.backgroundColor = [UIColor whiteColor];
    _addressField.frame = CGRectMake(CGRectGetMinX(addressLabel.frame),CGRectGetMaxY(addressLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_addressField];
    //电子邮件
    UILabel *emailLabel = [[UILabel alloc]init];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.font = [UIFont systemFontOfSize:15];
    emailLabel.textColor = sColor(90, 90, 90, 1.0);
    emailLabel.text = @"电子邮件";
    emailLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_addressField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:emailLabel];
    //电子邮件输入框
    _emailField = [[UITextField alloc]init];
    UIView *leftV4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _emailField.delegate = self;
    _emailField.leftView = leftV4;
    _emailField.leftViewMode = UITextFieldViewModeAlways;
    _emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailField.layer.cornerRadius = 2;
    _emailField.layer.masksToBounds = YES;
    _emailField.placeholder = @"请输入您的电子邮件";
    [_emailField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_emailField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _emailField.backgroundColor = [UIColor whiteColor];
    _emailField.frame = CGRectMake(CGRectGetMinX(emailLabel.frame),CGRectGetMaxY(emailLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_emailField];
    //问题类别
    UILabel *questionLabel = [[UILabel alloc]init];
    questionLabel.backgroundColor = [UIColor clearColor];
    questionLabel.font = [UIFont systemFontOfSize:15];
    questionLabel.textColor = sColor(90, 90, 90, 1.0);
    questionLabel.text = @"问题类别";
    questionLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_emailField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:questionLabel];
    //问题输入框
    _questionField = [[UITextField alloc]init];
    UIView *leftV5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _questionField.delegate = self;
    _questionField.leftView = leftV5;
    _questionField.leftViewMode = UITextFieldViewModeAlways;
    //右边View
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightV.backgroundColor = [UIColor clearColor];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = sColor(148, 148, 148, 0.5);
    line.frame = CGRectMake(0, 0, 0.3, 32);
    [rightV addSubview:line];
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"right_dan"];
    imageV.frame = CGRectMake(10, 8, 10, 16);
    [rightV addSubview:imageV];
    UIButton *rightArrow = [[UIButton alloc]init];
    [rightArrow addTarget:self action:@selector(rightArrow) forControlEvents:UIControlEventTouchUpInside];
    rightArrow.frame = CGRectMake(0, 0, rightV.frame.size.width, rightV.frame.size.height);
    [rightV addSubview:rightArrow];
    _questionField.rightViewMode = UITextFieldViewModeAlways;
    _questionField.rightView = rightV;
    _questionField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _questionField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _questionField.layer.cornerRadius = 2;
    _questionField.layer.masksToBounds = YES;
    _questionField.placeholder = @"请选择问题类别";
    [_questionField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_questionField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _questionField.backgroundColor = [UIColor whiteColor];
    _questionField.frame = CGRectMake(CGRectGetMinX(questionLabel.frame),CGRectGetMaxY(questionLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_questionField];
    //咨询标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = sColor(90, 90, 90, 1.0);
    titleLabel.text = @"咨询标题";
    titleLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_questionField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:titleLabel];
    //咨询标题输入框
    _titleField = [[UITextField alloc]init];
    UIView *leftV6 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _titleField.delegate = self;
    _titleField.leftView = leftV6;
    _titleField.leftViewMode = UITextFieldViewModeAlways;
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _titleField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _titleField.layer.cornerRadius = 2;
    _titleField.layer.masksToBounds = YES;
    _titleField.placeholder = @"请输入您要咨询的标题";
    [_titleField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_titleField setValue:sColor(180, 180, 180, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    _titleField.backgroundColor = [UIColor whiteColor];
    _titleField.frame = CGRectMake(CGRectGetMinX(titleLabel.frame),CGRectGetMaxY(titleLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight);
    [contentView addSubview:_titleField];
    //咨询内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = sColor(90, 90, 90, 1.0);
    contentLabel.text = @"咨询内容";
    contentLabel.frame = CGRectMake(CGRectGetMinX(segmentView.frame) + 2 * CostumViewMargin, CGRectGetMaxY(_titleField.frame) + 2 * CostumViewMargin, labelWidth, labelHeight);
    [contentView addSubview:contentLabel];
    _contentField = [[HHZTextView alloc]init];
    _contentField.placehoder = @"请输入您要咨询的内容";
    _contentField.delegate = self;
    _contentField.returnKeyType = UIReturnKeyDone;
    _contentField.layer.cornerRadius = 2;
    _contentField.layer.masksToBounds = YES;
    _contentField.backgroundColor = [UIColor whiteColor];
    _contentField.frame = CGRectMake(CGRectGetMinX(contentLabel.frame),CGRectGetMaxY(contentLabel.frame) + 2 * CostumViewMargin , fieldWidth, fieldHeight * 5);
    [contentView addSubview:_contentField];
    //底部view
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = sColor(203, 203, 203, 1.0);
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(_contentField.frame) + 5 * CostumViewMargin, mainScreenW, 280);
    [contentView addSubview:bottomView];
    //底部分隔线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = sColor(207, 207, 207, 1.0);
    bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_contentField.frame) + 5 * CostumViewMargin, mainScreenW, 1);
    [contentView addSubview:bottomLine];
    //确认按钮
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"bttonBG"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn-h2"] forState:UIControlStateHighlighted];
    [sureBtn setTitle:@"确 认"forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    sureBtn.frame = CGRectMake(_contentField.frame.origin.x,CGRectGetMaxY(bottomLine.frame) + 2 *CostumViewMargin , mainScreenW * 0.4, 40);
    [contentView addSubview:sureBtn];
    //拨打维权热线
    UIButton *telBtn = [[UIButton alloc]init];
    [telBtn addTarget:self action:@selector(telClick) forControlEvents:UIControlEventTouchUpInside];
    [telBtn setBackgroundImage:[UIImage imageNamed:@"btn-l"] forState:UIControlStateNormal];
    [telBtn setBackgroundImage:[UIImage imageNamed:@"btn-l-highlight"] forState:UIControlStateHighlighted];
    [telBtn setTitle:@"     拨打维权热线"forState:UIControlStateNormal];
    telBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    telBtn.frame = CGRectMake(CGRectGetMaxX(sureBtn.frame) + 2 * CostumViewMargin,CGRectGetMaxY(bottomLine.frame) + 2 *CostumViewMargin , mainScreenW * 0.42, 40);
    [contentView addSubview:telBtn];

    contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(telBtn.frame) + 4 * CostumViewMargin +  60);
    [self.view addSubview:contentView];
}

-(void)sureClick
{
    SLog(@"sureClick");
    //输入验证
    if (!_nameField.text || [_nameField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"姓名不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (!_phoneField.text || [_phoneField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"电话不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![IsPhone isMobileNumber:_phoneField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"手机号不正确!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    if (!_titleField.text || [_titleField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"咨询标题不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }if (!_contentField.text || [_contentField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"咨询内容不能为空!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定!"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"提交中!";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *name = [_nameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *title = [_titleField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *content = [_contentField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *email = [_emailField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *address = [_addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urls = [NSString stringWithFormat:@"/api/protect/regist?username=%@&mobile=%@&title=%@&content=%@&address=%@&email=%@",name, _phoneField.text,title,content,address,email];
        NSString *str = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id result = [KRHttpUtil getResultDataByPost:str param:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            //成功
            if ([[result objectForKey:@"code"] integerValue]==1)
            {
                UIAlertView *alertV1 = [[UIAlertView alloc]initWithTitle:@"提交成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV1 show];
                [hud hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
                _nameField.text = nil;
                _phoneField.text = nil;
                _titleField.text = nil;
                _contentField.text = nil;
                _emailField.text = nil;
                _addressField.text = nil;
            }
            //请求失败
            else
            {
                UIAlertView *alertV2 = [[UIAlertView alloc]initWithTitle:@"提交失败!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertV2 show];
                [hud hide:YES];
            }
        });
    });

    
}

-(void)telClick
{
    SLog(@"telClick");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://021-12351"]];
}

#pragma mark - 键盘消失
- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        
        if ([v isKindOfClass:[UISearchBar class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resignKeyBoardInView:self.view];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y - 160, textView.frame.size.width, textView.frame.size.height);
    if (mainScreenH<=480) {
         frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y-220, textView.frame.size.width, textView.frame.size.height);
    }
    SLog(@"%@",NSStringFromCGRect(frame));
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset > 0) {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
      self.view.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
    if (mainScreenH<=480) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    SLog(@"Idex %ld",Index);
    switch (Index) {
        case 0:
            [self selectedTourist];
            break;
        case 1:
            [self selectedmMember];
            break;
            
        default:
            break;
    }
}

-(void)selectedTourist
{
    SLog(@"选择了游客维权");
    _nameField.text = nil;
    _phoneField.text = nil;
}

-(void)selectedmMember
{
    SLog(@"选择了会员维权");
    UserModel *account = [UserTool userModel];
    if (account.userIDName == nil) {
        loginViewController *loginVC = [[loginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
        _nameField.text = account.userIDName;
        _phoneField.text = account.phoneNum;
}

-(void)setNavBar
{
    self.title = @"维权登记";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:22],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage resizedImage:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    navbarView *buttonL = [[navbarView alloc]initWithNavType:navbarViewTypeLeft];
    
    [buttonL.navButton setImage:[UIImage imageNamed:@"left_barbutton"] forState:UIControlStateNormal];
    [buttonL.navButton addTarget:self action:@selector(leftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:buttonL];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    navbarView *buttonR = [[navbarView alloc]initWithNavType:navbarViewTypeRight];
    [buttonR.navButton setImage:[UIImage imageNamed:@"user_white"]forState:UIControlStateNormal];
    [buttonR.navButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonR.navButton addTarget:self action:@selector(toUser) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buttonR];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftMenu
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.DrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)toUser
{
    UserModel *account = [UserTool userModel];
    if (account.password) {
        PersonalDoneViewController *personDoneVC = [[PersonalDoneViewController alloc]init];
        personDoneVC.userName = account.username;
        personDoneVC.userPasswd = account.password;
        PersonalDoneViewController *personDownVC = [[PersonalDoneViewController alloc]init];
        self.maintainNav = [AppDelegate shareMaintainController];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.username = account.username;
        delegate.password = account.password;
        delegate.phone = account.phoneNum;
        delegate.email = account.email;
        delegate.labourUnionCode = account.LabourUnion;
        [self.maintainNav pushViewController:personDownVC animated:YES];
    }else{
        self.maintainNav = [AppDelegate shareMaintainController];
        PersonalViewController *personVC = [[PersonalViewController alloc]init];
        [self.maintainNav pushViewController:personVC animated:YES];
    }
    
    SLog(@"toUser");
}

-(void)rightArrow
{
    SLog(@"rightArrow");

    _questionVC.delegate = self;
    [self.navigationController pushViewController:_questionVC animated:YES];
}

-(void)sendQuestion:(NSString *)question
{
    _questionField.text = question;
}

@end
