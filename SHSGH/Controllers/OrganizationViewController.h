//
//  OrganizationViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPiFlatSegmentedControl.h"
@interface OrganizationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Seatchtable;
    NSArray*namearry;
    NSMutableArray*_allarry;

    UITextField*_searchfield;
    NSString*urls;
    BOOL _isReloadingAllData;
    NSInteger totalCount;
    NSInteger changeA;
    NSInteger firstA;

    PPiFlatSegmentedControl *segmentedControl;
    
}


@end
