//
//  HHZLoadMoreFooter.h
//  微博
//
//  Created by Mr.h on 14/12/2.
//  Copyright (c) 2014年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHZLoadMoreFooter : UIView

+(instancetype)footer;

-(void)beginRefreshing;
-(void)endRefreshing;

@property(nonatomic,assign,getter = isRefreshing) BOOL refreshing;

@end
