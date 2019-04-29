//
//  SPBasePopView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/9.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBasePopView.h"

@implementation SPBasePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = RGBCOLORA(0, 0, 0, 0.4);
        [self addGestureRecognizer];
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
}
-(void)addGestureRecognizer{
    self.tag=11;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shat)];
    tap.delegate=self;
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag==11) {
        return YES;
    }
    return  NO;
}

-(void)shat{
    
    [self endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.originY= SCREEN_H+100;
    }completion:^(BOOL finished) {
        
    }];
}

-(void)setAnimtion{
    //需要实现的帧动画,这里根据自己需求改动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@1.03,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    //添加动画
    [self.layer addAnimation:animation forKey:nil];
}
@end
