//
//  YSJTeacherListCell.h
//  SmallPig

//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJCompanysModel;

static NSString *YSJCompanyListCellID = @"YSJCompanyListCellID";

@interface YSJCompanyListCell : UITableViewCell

@property (nonatomic,strong) YSJCompanysModel *model;

@end
