//
//  TradeViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPiFlatSegmentedControl.h"
@interface TradeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Seatchtable;
    NSArray*namearry;
    
    UITextField*_searchfield;
        BOOL _flagArray[100];
    PPiFlatSegmentedControl *segmentedControl;
    
}



@end