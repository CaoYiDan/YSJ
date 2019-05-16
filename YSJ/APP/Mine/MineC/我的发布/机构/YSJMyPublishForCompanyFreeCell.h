//
//  YSJMyPublishForCompanyCourseCell.h
//  SmallPig
//
//  Created by xujf on 2019/5/10.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import <UIKit/UIKit.h>

@class YSJCourseModel;

static NSString *YSJRequimentCellID = @"YSJMyPublishForTeacherCellID";

@interface YSJMyPublishForCompanyFreeCell : UITableViewCell

@property (nonatomic,strong) YSJCourseModel *model;

@end
