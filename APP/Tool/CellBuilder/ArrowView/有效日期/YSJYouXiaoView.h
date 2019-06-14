//
//  YSJYouXiaoView.h
//  SmallPig
//
//  Created by xujf on 2019/6/10.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "SPBasePopView.h"
#import "HZQDatePickerView.h"
typedef void(^popTeachTypeViewBlock)(NSMutableArray *chosedArr);

NS_ASSUME_NONNULL_BEGIN

@interface YSJYouXiaoView : SPBasePopView
<HZQDatePickerViewDelegate>

@property (nonatomic,strong) HZQDatePickerView *pikerView;

/***/
@property(nonatomic,copy)popTeachTypeViewBlock  block;

@end

NS_ASSUME_NONNULL_END
