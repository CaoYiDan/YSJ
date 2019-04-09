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

/**block*/
@property(nonatomic,copy)profileBlock  block;
@end
