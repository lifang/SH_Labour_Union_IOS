//
//  LineTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "LineTableViewCell.h"

@implementation LineTableViewCell
@synthesize namelable;
@synthesize timelable;
@synthesize distancelable;
//@synthesize logoImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        logoImageView=[[UIImageView alloc]init];
//        
//        logoImageView.image=[UIImage imageNamed:@"qipao"];
//        
        
//        [self addSubview:logoImageView];
        
        
        
        namelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 20)];
        
        [self addSubview:namelable];
        
        timelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, (SCREEN_WIDTH-20), 20)];
        timelable.textColor=[UIColor grayColor];
        
        [self addSubview:timelable];
        
        
        
        distancelable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 20, (SCREEN_WIDTH-20)/2, 20)];
        
//        [self addSubview:distancelable];
        
        distancelable.textColor=[UIColor grayColor];

        
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
