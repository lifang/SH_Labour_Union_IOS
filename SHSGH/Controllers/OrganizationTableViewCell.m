//
//  OrganizationTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "OrganizationTableViewCell.h"

@implementation OrganizationTableViewCell
@synthesize namelable;
@synthesize phoonelable;
@synthesize addresslable;
@synthesize logoImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        namelable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 30)];
        
        [self addSubview:namelable];
        
        
        phoonelable=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 120, 20)];
        phoonelable.font=[UIFont systemFontOfSize:15];
        phoonelable.textColor=[UIColor grayColor];
//        phoonelable.text=@"021-56874968";
        
        
        [self addSubview:phoonelable];
        addresslable=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, 20)];
        
        [self addSubview:addresslable];
        
        addresslable.font=[UIFont systemFontOfSize:15];
        addresslable.textColor=[UIColor grayColor];
        
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(140, 30, 20, 20)];
        
        logoImageView.image=[UIImage imageNamed:@"tel"];
        
        
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
