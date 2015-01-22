//
//  HHZCommonCell.h
//  微博
//
//  Created by Mr.h on 14/12/12.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHZCommonItem;

@interface HHZCommonCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows;
/** 箭头 */
@property (strong, nonatomic) UIImageView *rightArrow;
/** 开关 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/** 标签*/
@property (strong, nonatomic) UILabel *rightLabel;
/** cell对应的item数据 */
@property(nonatomic,strong)HHZCommonItem *item;

@end
