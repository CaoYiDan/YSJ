//
//  YSJTeacherListCell.h
//  SmallPig

//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJRequimentModel;

static NSString *YSJRequestListCellID = @"YSJRequestListCellID";

@interface YSJRequestListCell : UITableViewCell

@property (nonatomic,strong) YSJRequimentModel *model;

@end
