//
//  YSJOrderDeatilVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
@class YSJOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface YSJOrderDeatilVC : BaseViewController
@property (nonatomic,strong) YSJOrderModel *model;
@property (nonatomic,assign) YSJOrderType orderType;
@end

NS_ASSUME_NONNULL_END
