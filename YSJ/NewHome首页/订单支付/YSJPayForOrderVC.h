//
//  YSJPayForOrderVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/2.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

@class YSJCourseModel;

@interface YSJPayForOrderVC : BaseViewController

@property (nonatomic,strong) YSJCourseModel *model;
//0:发起拼单 1:拼单  2:私教一对一支付 3：机构支付
@property (nonatomic,assign) int type;
@end
