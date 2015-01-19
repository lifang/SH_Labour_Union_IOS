//
//  ReuseView.h
//  ScrollView
//
//  Created by 张浩 on 14/11/13.
//  Copyright (c) 2014年 jiangxiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReuseViewDelegate <NSObject>

- (void)handleTop:(UITapGestureRecognizer *)imageView;

@end

@interface ReuseView : UIView
@property (nonatomic, assign) id<ReuseViewDelegate>reuseDelegate;
- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array;

@end
