//
//  HHZSearchBar.m
//
//
//  Created by Mr.h on 14-11-26.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import "HHZSearchBar.h"

@implementation HHZSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        
        //设置输入内容垂直居中
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //设置左边放放大镜图片
        UIImageView *bigView = [[UIImageView alloc]init];
        bigView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        bigView.width = bigView.image.size.width + 10;
        bigView.height = bigView.image.size.height;
        
        //设置放大镜居中
        bigView.contentMode = UIViewContentModeCenter;
        self.leftView = bigView;
        
        //设置所编的View永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //设置右边永远显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc]init];
}
@end
