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
    BOOL _isReloadingAllData;
    NSInteger ff;
    UITextField*_searchfield;
    UITextField*_searchfields;

    NSMutableArray*_newallarry;
    NSString *urls;
    NSInteger tuizaiA;
    NSInteger A;
    NSInteger changeint;
    NSString*detalstring;
    BOOL changeimage;
    NSInteger totalCount;
    NSString*str4textfield;
    NSString*stringurl;
    UILabel*lab;
    
    PPiFlatSegmentedControl *segmentedControl;
    
}
@property(nonatomic,strong)UINavigationController *dynamicNav;


@end
