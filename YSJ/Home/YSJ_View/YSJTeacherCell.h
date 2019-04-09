//
//  YSJTeacherCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJTeacherModel;

static NSString *YSJTeacherCellID = @"teacherCellID";

@interface YSJTeacherCell : UICollectionViewCell

@property (nonatomic,strong) YSJTeacherModel *model;

@end
