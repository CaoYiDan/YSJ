//
//  UITabBar+SPTabbarBadge.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (SPTabbarBadge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end
