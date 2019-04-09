//
//  YSJTeacherDetailVC.h
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
@class YSJTeacherModel;
UIKIT_EXTERN NSNotificationName const ChildScrollViewDidScrollNSNotification;

UIKIT_EXTERN NSNotificationName const ChildScrollViewRefreshStateNSNotification;

@interface YSJTeacherDetailVC : BaseViewController
@property (nonatomic,strong) YSJTeacherModel *model;
@end
