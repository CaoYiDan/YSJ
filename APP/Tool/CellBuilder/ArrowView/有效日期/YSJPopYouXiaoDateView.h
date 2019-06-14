//
//  YSJPopCourserCellView.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSJLSBaseCommonCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSJPopYouXiaoDateView :  YSJLSBaseCommonCellView

/**
 0：多选
 1：只能选择一个
 */
@property (nonatomic,assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
