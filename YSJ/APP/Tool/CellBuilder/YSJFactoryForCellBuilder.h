//
//  YSJFactoryForCell.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJFactoryForCellBuilder : NSObject

-(UIScrollView *)createViewWithDic:(NSDictionary *)dic;
//最底下的一个view.参照view
@property (nonatomic,strong) UIView *lastBottomView;

/**
 获取所有的填写信息

 @return 数组
 */
-(NSMutableArray *)getAllContent;

/**
 移除所有cellView
 */
-(void)removeCellView;

#pragma mark - 专门为 发布需求 写的方法

/**
  显示（找机构）
 */
-(void)hiddenViewForRequement;

/**
  隐藏（找私教）
 */
-(void)showViewForRequement;

#pragma mark - 专门为 发布私教 写的方法

/**
 私教课程
 */
-(void)publishForTeachOneByOne;
/**
 拼单课程
 */
-(void)publishForTeachPinDan;


#pragma mark - 专门为 发布机构 写的方法

/**
 明星课程 he 精品课程 布局一样
 */
-(void)publishForCompanyFamousCourseOrJingPin;

/**
 试听课程
 */
-(void)publishForCompanyFree;

@end

NS_ASSUME_NONNULL_END
