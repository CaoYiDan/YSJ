//
//  YSJProfile.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJUserModel;

#import "VTMagic.h"

@interface YSJCompanyProfileVC: VTMagicController

@property (nonatomic,strong) YSJUserModel *model;


@property (nonatomic,copy) NSString *identifier;

@end
