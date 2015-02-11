//
//  QuestionViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/1/26.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendQuestion <NSObject>

@optional
-(void)sendQuestion:(NSString *)question WithCode:(NSString *)code;

@end

typedef void (^aBlock)(NSString *hangyestring);
@interface QuestionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView*_Questiontable;
    NSMutableArray*imagearry;
    NSMutableArray*namearry;
}
@property(nonatomic,strong)NSString*conditionsname;
@property (nonatomic, copy)aBlock block;
@property(nonatomic,weak)id<sendQuestion> delegate;
@end
