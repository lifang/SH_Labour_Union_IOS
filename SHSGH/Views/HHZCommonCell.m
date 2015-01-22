//
//  HHZCommonCell.m
//  微博
//
//  Created by Mr.h on 14/12/12.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import "HHZCommonCell.h"
#import "HHZCommonItem.h"
#import "HHZCommonSwitchItem.h"
#import "HHZCommonLabelItem.h"
#import "HHZCommonArrowItem.h"

@implementation HHZCommonCell

#pragma mark - 懒加载右边的View控件

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"particular_Gray-1"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor darkGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _rightLabel;
}


#pragma  mark - 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    HHZCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.height = 70;
    if (cell == nil) {
        cell = [[HHZCommonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置标题的字体
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
//        //取出cell默认的背景颜色
//        self.backgroundColor = [UIColor clearColor];
        
//        //设置背景view
//        self.backgroundView = [[UIImageView alloc]init];
//        self.selectedBackgroundView = [[UIImageView alloc]init];
    }
    return self;
}

#pragma mark - 调整子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
    
//    self.imageView.frame = CGRectMake(0, 0, 20, 20);
//    self.imageView.backgroundColor = [UIColor redColor];
}

#pragma mark - 调整tableView头部间距
//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - HHZStatusCellMargin);
//    [super setFrame:frame];
//}


- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows
{
//    //1.取出背景view
//    UIImageView *bgView = (UIImageView *)self.backgroundView;
//    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
}

#pragma mark - setter
-(void)setItem:(HHZCommonItem *)item
{
    _item = item;
    
    //1.设置基本的数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    //2.设置右边的内容
    if (item.badgeValue) {//如果右边有数字提示
    }else if ([item isKindOfClass:[HHZCommonArrowItem class]]){
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[HHZCommonSwitchItem class]]){
        self.accessoryView = self.rightSwitch;
    }else if ([item isKindOfClass:[HHZCommonLabelItem class]]){
        HHZCommonLabelItem *labelItem = (HHZCommonLabelItem *)item;
        //设置文字
        self.rightLabel.text = labelItem.text;
        //根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font];
        self.accessoryView = self.rightLabel;
    }else{//取消右边View的显示
        self.accessoryView = nil;
    }
    
}

@end
