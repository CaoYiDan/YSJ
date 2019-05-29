//
//  YSJMyPublishForCompanyCourseCell.h
//  SmallPig
//
//  Created by xujf on 2019/5/10.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import <UIKit/UIKit.h>

@class YSJOrderModel,YSJCourseModel;

@interface YSJBuyManagerCell : UITableViewCell

@property (nonatomic,assign) YSJCellType orderType;
@property (nonatomic,strong) YSJOrderModel *model;
@property (nonatomic,strong) YSJCourseModel *courseModel;
@end
