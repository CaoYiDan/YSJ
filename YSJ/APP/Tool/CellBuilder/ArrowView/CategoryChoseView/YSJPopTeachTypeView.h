//
//  YSJPopTeachTypeView.h
//  SmallPig
//
//  Created by xujf on 2019/4/18.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "SPBasePopView.h"

#import <UIKit/UIKit.h>

typedef void(^popTeachTypeViewBlock)(NSMutableArray *chosedArr);

NS_ASSUME_NONNULL_BEGIN

@interface YSJPopTeachTypeView : SPBasePopView
/***/
@property(nonatomic,copy)popTeachTypeViewBlock  block;
@end

NS_ASSUME_NONNULL_END
