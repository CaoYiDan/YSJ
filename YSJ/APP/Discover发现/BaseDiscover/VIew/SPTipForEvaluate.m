//
//  SPTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPTipForEvaluate.h"

@implementation SPTipForEvaluate

{
    UIView *_baseView;
    
    UIButton *_message1;
    UIButton *_message2;
    UIButton *_message3;
    UIButton *_message4;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-40, 200)];
    base.backgroundColor = [UIColor whiteColor];
    _baseView = base;
    base.center = self.center;
    [self addSubview:base];
    
    //关闭按钮
    UIButton *shatBtn = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-20, 10, 40, 40)];
    [shatBtn setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    [shatBtn addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    [base addSubview:shatBtn];
    
    //好友评价提示信息
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(base.frameWidth/2-50, 60, 100, 30)];
    tip.text = @"好友才能进行评价信息";
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = BoldFont(14);
    [base addSubview:tip];
    
    UILabel *please = [[UILabel alloc]initWithFrame:CGRectMake(base.frameWidth/2-50, CGRectGetMaxY(tip.frame), 100, 30)];
    please.text = @"快去成为好友吧";
    please.font = font(14);
    please.textAlignment = NSTextAlignmentCenter;
    please.textColor = [UIColor redColor];
    [base addSubview:please];
 
    UIButton * addFriend = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-75, 220, 150, 40)];
    [addFriend addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchDown];
    addFriend.backgroundColor = BaseRed;
    [addFriend setTitle:@"发出添加好友请求" forState:0];
    addFriend.layer.cornerRadius = 5;
    addFriend.clipsToBounds = YES;
    [base addSubview:addFriend];
}

-(void)setAnimtion{
    //需要实现的帧动画,这里根据自己需求改动
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@0.9,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    //添加动画
    [_baseView.layer addAnimation:animation forKey:nil];
}

//去成为好友
-(void)addFriend{
    
}

//关闭
-(void)shat{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.originY= SCREEN_H;
    }completion:^(BOOL finished) {
        
    }];
}

@end
