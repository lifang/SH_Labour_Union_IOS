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
    NSMutableArray*namearry;
    
    UITextField*_searchfield;
    NSMutableArray*recordarry;
    NSMutableArray*_allarry;
    NSMutableArray*_newallarry;

    NSMutableArray*_conditarry;
    
    NSInteger a;
    NSInteger b;
    NSInteger c;

    
    NSInteger recordA;
    NSInteger recordB;
    NSInteger recordC;
    
    
    
    NSString*str1;
      NSString*str2;
      NSString*str3;
    NSString*str4textfield;

}
@property(nonatomic,strong)UINavigationController *dynamicNav;

@end
