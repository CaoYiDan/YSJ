//
//  YSJTeacherCourse_OneByOneVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/4.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^profileBlock) (NSDictionary *profileDic);

@class YSJCourseModel;

#import "BaseViewController.h"

@interface YSJTeacherCourse_OneByOneVC: BaseViewController

@property (nonatomic,strong) YSJCourseModel *M;
/**<##>courseID*/
@property(nonatomic,copy)NSString *courseID;
/**
 0 普通进入 1 查看自己的发布
 */

@property (nonatomic,assign) NSInteger vcType;

/**block*/
@property(nonatomic,copy)profileBlock  block;
@end
