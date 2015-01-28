//
//  GetresultTableViewCell.m
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import "GetresultTableViewCell.h"

@implementation GetresultTableViewCell
@synthesize date;

@synthesize companyname;
@synthesize jobname;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        jobname=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 30)];
        
       [self addSubview:jobname];
        
        
        companyname=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH, 20)];
        companyname.font=[UIFont systemFontOfSize:15];
        companyname.textColor=[UIColor grayColor];
        
        
        [self addSubview:companyname];
//        date=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH, 20)];
//        
//        [self addSubview:date];
//        
//        date.font=[UIFont systemFontOfSize:15];
//        date.textColor=[UIColor grayColor];
        


        
        

        
        
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
