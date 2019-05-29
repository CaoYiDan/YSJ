//
//  YSJOrderCourseView.h
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSJOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface YSJOrderCourseView : UIView

@property (nonatomic,strong) YSJOrderModel *model;
@property (nonatomic,strong) UILabel *price; 
@end

NS_ASSUME_NONNULL_END
