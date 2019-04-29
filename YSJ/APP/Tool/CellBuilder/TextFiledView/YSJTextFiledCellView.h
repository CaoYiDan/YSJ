//
//  YSJTextFiledCellView.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSJPopViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface YSJTextFiledCellView : UIView<YSJPopViewProtocol>

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
