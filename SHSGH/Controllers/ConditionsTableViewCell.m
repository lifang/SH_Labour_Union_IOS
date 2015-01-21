//
//  ConditionsTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ConditionsTableViewCell.h"

@implementation ConditionsTableViewCell
@synthesize logoImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 15, 30, 30)];
        
        
        
        
        [self addSubview:logoImageView];
        
        
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
