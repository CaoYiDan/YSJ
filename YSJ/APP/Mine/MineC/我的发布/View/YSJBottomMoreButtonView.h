//
//  YSJBottomMoreButtonView.h
//  SmallPig
//
//  Created by xujf on 2019/5/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  YSJOrderModel;
@protocol YSJBottomMoreButtonViewDelegate <NSObject>


/**
 底部点击按钮事件

 @param index 从右向左数（0，1....）
 */
-(void)bottomMoreButtonViewClickWithIndex:(NSInteger)index andTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YSJBottomMoreButtonView : UIView

@property (nonatomic,weak) id<YSJBottomMoreButtonViewDelegate> delegate;

@property (nonatomic,assign) YSJOrderType orderType;

@property (nonatomic,strong) YSJOrderModel *model;

/**
 单一灰色设置数组（）
 */
@property (nonatomic,strong) NSArray<NSString *> *btnTextArr;

/**
 多颜色设置数组
 */
@property (nonatomic,strong) NSArray<NSDictionary *> *moreColorBtnArr;

@end

NS_ASSUME_NONNULL_END
