//
//  YSJTeacherListCell.h
//  SmallPig

//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJTeacherModel;

static NSString *YSJTeacherListCellID = @"teacherListCellID";

@interface YSJTeacherListCell : UITableViewCell

@property (nonatomic,strong) YSJTeacherModel *model;

@end
