//
//  SearchRestulTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "SearchRestulTableViewCell.h"

@implementation SearchRestulTableViewCell

@synthesize logoImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
        
        
   
        
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
