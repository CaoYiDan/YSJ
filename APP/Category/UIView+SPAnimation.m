//
//  UIView+SPAnimation.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "UIView+SPAnimation.h"

@implementation UIView (SPAnimation)

-(void)transformAnimation
{
    //需要实现的帧动画,这里根据自己需求改动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.2,@0.9,@1.0];
    animation.duration = 0.4;
    animation.calculationMode = kCAAnimationCubic;
    //添加动画
    [self.layer addAnimation:animation forKey:nil];
}
@end
