//
//  OrganizationdetalViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrganizationdetalViewController : UIViewController<UIScrollViewDelegate>


{
    UIScrollView*_scrool;
    UIPageControl *_page;
    UIScrollView*bigscroll;
    NSInteger          _move;
    NSTimer      *_scrollcententtimer;
}
@end
