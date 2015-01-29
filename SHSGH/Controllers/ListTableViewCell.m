//
//  ListTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/29.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell
@synthesize namelable;
@synthesize phoonelable;
@synthesize addresslable;
@synthesize logoImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 17, 26, 26)];
        
        logoImageView.image=[UIImage imageNamed:@"location"];
        
        
        [self addSubview:logoImageView];
        namelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-120, 30)];
        
        [self addSubview:namelable];
        
        
        addresslable=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-120, 30)];
        
        [self addSubview:addresslable];

        
        
        
        
        
        
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
