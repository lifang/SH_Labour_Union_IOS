//
//  ChoiceHospitalViewController.h
//  SHSGH
//
//  Created by lihongliang on 15/2/2.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendHospital <NSObject>

@optional
-(void)sendHospital:(NSString *)hospital WithCpid:(NSString *)cpid WithHospitalid:(NSString *)hospitalid;

@end

@interface ChoiceHospitalViewController : UITableViewController

@property(nonatomic,weak)id<sendHospital> delegate;

@property(nonatomic,strong)NSString *hospital;
@end
