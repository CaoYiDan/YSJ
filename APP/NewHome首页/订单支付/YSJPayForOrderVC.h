//
//  YSJPayForOrderVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/2.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

@class YSJCourseModel,YSJSpellListModel;

@interface YSJPayForOrderVC : BaseViewController

@property (nonatomic,strong) YSJCourseModel *model;

@property (nonatomic,strong) YSJSpellListModel *spellModel;

@property (nonatomic,assign) YSJPayForObject payForType;

@end
