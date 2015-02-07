//
//  ReuseView.m
//  ScrollView
//
//  Created by 张浩 on 14/11/13.
//  Copyright (c) 2014年 jiangxiaofei. All rights reserved.
//

#import "ReuseView.h"
#import "EGOImageView.h"

@interface ReuseView ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@end

@implementation ReuseView

- (id)initWithFrame:(CGRect)frame array:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!array || array.count == 0) return nil;
//       [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
  
        [array insertObject:[array firstObject] atIndex:0];
        [array addObject:[array firstObject]];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.contentSize = CGSizeMake(frame.size.width * array.count, frame.size.height);
        _scrollView.tag = 100;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        [self addSubview:_scrollView];
        
        for (int i = 0; i < array.count; i++) {
            EGOImageView *imageView = [[EGOImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
            imageView.imageURL = [NSURL URLWithString:array[i]];
            imageView.tag = 100 + i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
            [imageView addGestureRecognizer:singleTap];
            [_scrollView addSubview:imageView];
        }
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width / 3, _scrollView.frame.size.height - 20, _scrollView.frame.size.width, 15)];
        _pageControl.tag = 110;
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = array.count - 2;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        //设置表示的当前页点的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [_pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)handTap:(UITapGestureRecognizer *)tap {
    if ([self.reuseDelegate respondsToSelector:@selector(handleTop:)]) {
        [self.reuseDelegate handleTop:(tap)];
    }
}

#pragma mark - action
- (void)handlePageControl:(UIPageControl *)pageControl {
    //1.先获取scrollView
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:100];
    //2.修改scrollView的偏移量
    [scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * pageControl.currentPage, 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //1.先获取pageControl
    _pageControl = (UIPageControl *)[self viewWithTag:110];
    //2.修改pageContorl的currentPage与scrollView保持一致
    _pageControl.currentPage = scrollView.contentOffset.x / _scrollView.frame.size.width - 1;
    if (scrollView.contentOffset.x < _scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * (_scrollView.subviews.count - 2), 0)];
        _pageControl.currentPage = _scrollView.subviews.count - 3;
    }
    if (scrollView.contentOffset.x > _scrollView.frame.size.width * (_scrollView.subviews.count - 2)) {
        [scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
        _pageControl.currentPage = 0;
    }
    
}
- (void)runTimer {
    CGFloat x = _scrollView.contentOffset.x;
    [_scrollView setContentOffset:CGPointMake(x + _scrollView.frame.size.width, 0) animated:NO];
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width - 1;
    if (x > _scrollView.frame.size.width *(_scrollView.subviews.count - 3)) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
        _pageControl.currentPage = 0;
    }
}
- (void)dealloc
{
    self.scrollView = nil;
    self.pageControl = nil;
}

@end
