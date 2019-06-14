//
//  YSJMoreTextFiledView.h
//  SmallPig
//
//  Created by xujf on 2019/4/26.
//  Copyright © 2019年 lisen. All rights reserved.

#import "SPBasePopView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^popMoreTextFiledTypeViewBlock)(NSMutableArray *chosedArr);

@interface YSJMenKanView: SPBasePopView

- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray*)arr;

/* Block **/
@property(nonatomic,copy)popMoreTextFiledTypeViewBlock  block;

@end

NS_ASSUME_NONNULL_END
