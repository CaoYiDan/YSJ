//
//  YSJPublishHomeWorkVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
@class  YSJCourseModel,YSJOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface YSJPublishHomeWorkVC : BaseViewController

@property (nonatomic,copy) NSString *order_Id;

@property (nonatomic,strong) YSJCourseModel *model;

@property (nonatomic,strong) YSJOrderModel *orderModel;

@property (nonatomic,copy) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
