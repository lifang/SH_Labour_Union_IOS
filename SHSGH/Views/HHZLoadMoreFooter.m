//
//  HHZLoadMoreFooter.m
//  微博
//
//  Created by Mr.h on 14/12/2.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import "HHZLoadMoreFooter.h"
@interface HHZLoadMoreFooter()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@end

@implementation HHZLoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"HHZLoadMoreFooter" owner:nil options:nil] lastObject];
}

-(void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据。。。";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

-(void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}


@end
