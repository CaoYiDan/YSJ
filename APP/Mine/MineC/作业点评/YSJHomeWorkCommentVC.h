//
//  YSJHomeWorkCommentVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/29.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
@class YSJOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface YSJHomeWorkCommentVC : BaseViewController
@property (nonatomic,assign) HomeWorkDetailType homeWorkDetailType;

@property (nonatomic,strong) YSJOrderModel *orderModel;


@end

NS_ASSUME_NONNULL_END
