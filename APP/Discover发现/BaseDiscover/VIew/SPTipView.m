//
//  SPTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPTipView.h"

@implementation SPTipView

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
    
    UIView *base = [[UIView alloc]init];
    base.frame= CGRectMake(0, 0, 250, 380);
    base.backgroundColor = [UIColor whiteColor];
    _baseView = base;
    [self addSubview:base];
    
    //关闭按钮
    UIButton *shatBtn = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-20, 10, 40, 40)];
    [shatBtn setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    [shatBtn addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    [base addSubview:shatBtn];
    
    //
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(base.frameWidth/2-50, 60, 100, 30)];
    tip.text = @"提示信息";
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = BoldFont(14);
    [base addSubview:tip];
    
    UILabel *subTip = [[UILabel alloc]initWithFrame:CGRectMake(base.frameWidth/2-75, 90, 150, 50)];
    subTip.text = @"档案信息不完善将影响\n别人对您的了解及印象";
    subTip.font = font(14);
    subTip.numberOfLines = 2;
    subTip.textAlignment = NSTextAlignmentCenter;
    subTip.textColor = [UIColor grayColor];
    [base addSubview:subTip];
    
    UILabel *please = [[UILabel alloc]initWithFrame:CGRectMake(base.frameWidth/2-50, CGRectGetMaxY(subTip.frame), 100, 30)];
    please.text = @"请完善档案信息";
    please.font = BoldFont(14);
    please.textAlignment = NSTextAlignmentCenter;
    please.textColor = [UIColor redColor];
    [base addSubview:please];
    
    NSArray *textArr = @[@"基础信息",@"我的标签",@"我的技能",@"项目经历"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-50, CGRectGetMaxY(please.frame)+i*35, 100, 30)];
        btn.titleLabel.font = font(14);
        [btn setTitle:textArr[i] forState:0];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [base addSubview:btn];
        switch (i) {
            case 0:
                _message1 = btn;
                break;
            case 1:
                _message2 = btn;
                break;
            case 2:
                _message3 = btn;
                break;
            case 3:
                _message4 = btn;
                break;
            default:
                break;
        }
    }
    
    UIButton * gotoPerfect = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-75, 310, 150, 40)];
    [gotoPerfect addTarget:self action:@selector(perfect) forControlEvents:UIControlEventTouchDown];
    gotoPerfect.backgroundColor = BaseRed;
    [gotoPerfect setTitle:@"去完善" forState:0];
    gotoPerfect.layer.cornerRadius = 5;
    gotoPerfect.clipsToBounds = YES;
    [base addSubview:gotoPerfect];

    base.frame= CGRectMake(0, 0, 250, CGRectGetMaxY(gotoPerfect.frame)+10);
    base.center = self.center;
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

//去完善信息
-(void)perfect{
   
}

-(void)shat{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.originY= SCREEN_H;
    }completion:^(BOOL finished) {
        
    }];
}

@end
