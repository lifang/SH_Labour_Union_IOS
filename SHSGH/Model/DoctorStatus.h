//
//  DoctorStatus.h
//  SHSGH
//
//  Created by lihongliang on 15/2/4.
//  Copyright (c) 2015年 comdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorStatus : NSObject

@property(nonatomic,assign)int cpid;
@property(nonatomic,assign)int docid;
@property(nonatomic,strong)NSString *docimageurl;
@property(nonatomic,strong)NSString *doclevel;
@property(nonatomic,strong)NSString *docname;

@end
