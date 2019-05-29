//
//  YSJSpellListDetailVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/3.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJBaseForDetailView.h"

#import "BaseViewController.h"

@class YSJCourseModel;

@interface YSJSpellListDetailVC: BaseViewController

/**
 0 普通进入 1 查看自己的发布
 */

@property (nonatomic,assign) NSInteger vcType;

/**<##>courseID*/
@property(nonatomic,copy)NSString *courseID;

@property (nonatomic,strong) YSJCourseModel *M;

@end
