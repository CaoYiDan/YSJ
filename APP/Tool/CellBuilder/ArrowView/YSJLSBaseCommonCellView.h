//
//  YSJLSBaseCommonCellView.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSJPopViewProtocol.h"

#import "YSJPopProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define normalCellH 76

@interface YSJLSBaseCommonCellView : UIView <YSJPopViewProtocol>

/**
 附加信息
 */
@property (nonatomic,copy) NSString *otherStr;

@property (nonatomic,copy) NSString *rightSubTitle;

@property (nonatomic,assign) UIKeyboardType keyBorad;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
