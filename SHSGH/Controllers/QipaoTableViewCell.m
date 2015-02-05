//
//  QipaoTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/27.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "QipaoTableViewCell.h"

@implementation QipaoTableViewCell
@synthesize namelable;
@synthesize phoonelable;
@synthesize addresslable;
@synthesize logoImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        logoImageView=[[UIImageView alloc]init];
        
        logoImageView.image=[UIImage imageNamed:@"qipao"];
        
        
        [self addSubview:logoImageView];
        namelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 50)];
        namelable.backgroundColor=[UIColor clearColor];
        
        [self addSubview:namelable];
        
        
        
        
        
        
        
        
        
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
