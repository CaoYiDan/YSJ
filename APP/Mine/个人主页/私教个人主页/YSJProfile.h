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

@interface YSJProfile: VTMagicController

@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,strong) YSJUserModel *model;

@end
