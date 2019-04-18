//
//  YSJCommonSwitchView.h
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJCommonSwitchView : UIView

@property (nonatomic,assign) BOOL switchSelected;
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title selected:(BOOL)selected;
@end

NS_ASSUME_NONNULL_END
