//
//  YSJDrawBackDeatilVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

@class YSJOrderModel;

NS_ASSUME_NONNULL_BEGIN

@interface YSJDrawBackDeatilVC : BaseViewController

@property (nonatomic,assign) YSJCellType orderType;

@property (nonatomic,strong) YSJOrderModel *model;

@end

NS_ASSUME_NONNULL_END
