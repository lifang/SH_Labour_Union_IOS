//
//  RelatedViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/21.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPiFlatSegmentedControl.h"
@interface RelatedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITableView*_Seatchtable;
    UITableView*_helptable;
    NSArray*namearry;
    
    UITextField*_searchfield;
    NSMutableArray*_newallarry;
    NSString *urls;
    NSInteger tuizaiA;
    NSInteger A;
    NSInteger changeint;
    NSString*detalstring;
    BOOL changeimage;
    
    PPiFlatSegmentedControl *segmentedControl;
    
}


@end
