//
//  SearchJobViewController.h
//  SHSGH
//
//  Created by comdosoft on 15/1/20.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchJobViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITableView*_Seatchtable;
    NSArray*namearry;
    
    UITextField*_searchfield;
    
    
}

@end
