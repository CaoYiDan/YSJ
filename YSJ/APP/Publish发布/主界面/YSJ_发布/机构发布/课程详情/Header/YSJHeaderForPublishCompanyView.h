//
//  YSJHeaderForPublishCompanyView.h
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopMoreTextFiledView.h"

NS_ASSUME_NONNULL_BEGIN


typedef  void (^headerBlock) (CGFloat h);

@class  LGTextView,YSJPopTextFiledView;

@interface YSJHeaderForPublishCompanyView : UICollectionReusableView

/*self.block
 返回 0 ,约定的是点击了“添加老师”按钮
 返回 不是0 ,约定的返回的“h” 是添加图片引发的header的高度的动态变化高度
 */

@property (nonatomic,copy) headerBlock block;

@property(nonatomic,weak)LGTextView *textView;

@property (nonatomic, strong) NSMutableArray *photos;

/**
 上课时间
 */
@property (nonatomic,strong) YSJPopTextFiledView *classTime;
/**
 课时数
 */
@property (nonatomic,strong) YSJPopMoreTextFiledView *classNums;

@end

NS_ASSUME_NONNULL_END
