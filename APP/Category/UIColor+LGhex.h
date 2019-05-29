//
//  UIColor+LGhex.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/6.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

@interface UIColor (LGhex)
//十六进制表示如：#a0a0a0
+ (UIColor *)hexColor:(NSString *)hexStr;
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end
