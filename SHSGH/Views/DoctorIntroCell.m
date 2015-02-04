//
//  DoctorIntroCell.m
//  SHSGH
//
//  Created by lihongliang on 15/2/3.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "DoctorIntroCell.h"

@implementation DoctorIntroCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"city";
    DoctorIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DoctorIntroCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont boldSystemFontOfSize:14];
        _contentLabel.textColor = [UIColor blackColor];
        [self addSubview:_contentLabel];
        UIImageView *rightView = [[UIImageView alloc]init];
        rightView.image = [UIImage imageNamed:@"right_downArrow"];
        self.accessoryView = rightView;
    }
    return self;
}

//NSString *topLabelStr = @"市总工会启动2015年工会保障工作重点研讨";
//topLabel.text = _topLabelStr;
//CGSize topLabelSize = {0,0};
//topLabelSize = [_topLabelStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200.0, 5000)];
//topLabel.numberOfLines = 0;
//topLabel.frame = CGRectMake(leftMargin, topMargin, mainScreenW * 0.9, topLabelSize.height);
//[contentView addSubview:topLabel];

#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize contentLabelSize = {0,0};
    contentLabelSize = [_contentLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:14]
                                      constrainedToSize:CGSizeMake(mainScreenW * 0.7, self.height)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.frame = CGRectMake(10, 0, mainScreenW * 0.7, self.height);
    
    self.accessoryView.frame = CGRectMake(mainScreenW - 12 * CostumViewMargin, 30, 20, 11);
}



@end
