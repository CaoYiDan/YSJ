//
//  YSJHomeWorkTypeListCell.h
//  SmallPig

//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.

#import <UIKit/UIKit.h>
#import "YSJGBModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^HBUseBlock)();
@interface YSJHongBaoCell : UITableViewCell

@property (nonatomic,strong) YSJGBModel *model;

@property (nonatomic,assign) HBType type;

@property (nonatomic,copy) HBUseBlock  block;
@end

NS_ASSUME_NONNULL_END
