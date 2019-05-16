//
//  YSJDrawBackCauseView.h
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"

typedef void(^popTeachTypeViewBlock)(NSMutableArray *chosedArr);

NS_ASSUME_NONNULL_BEGIN

@interface YSJDrawBackCauseView : SPBasePopView
/***/
@property(nonatomic,copy)popTeachTypeViewBlock  block;

@end

NS_ASSUME_NONNULL_END
