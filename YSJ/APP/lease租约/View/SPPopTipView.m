//
//  SPPopTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPopTipView.h"

@implementation SPPopTipView
{
    UILabel *_title;
    UILabel *_content;
}

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content sureButtonText:(NSString *)Btntext frame:(CGRect)frame complment:(complment)complment
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _complmentBlock = complment;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self setUIWithTitle:title content:content sureText:Btntext];
    }
    return self;
}

-(void)setUIWithTitle:(NSString *)text content:(NSString *)contentText sureText:(NSString *)sureText
{
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, SCREEN_W-60, 140)];
    baseView.backgroundColor = WC;
    baseView.layer.cornerRadius = 5;
    baseView.clipsToBounds = YES;
    baseView.center = self.center;
    [self addSubview:baseView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-60, 40)];
    title.font = font(15);
    _title = title;
    title.text = text;
    title.textAlignment =NSTextAlignmentCenter;
    [baseView addSubview:title];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-60, 0.8)];
    line.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:line];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_W-80, 60)];
    content.numberOfLines = 0;
    _content = content;
    content.textAlignment = NSTextAlignmentCenter;
    content.text = contentText;
    content.font = font(14);
    [baseView addSubview:content];

    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-60)/2-110, 100, 100, 30)];
    cancel.backgroundColor = [UIColor grayColor];
    [cancel setTitle:@"取消" forState:0];
    cancel.titleLabel.font = font(14);
    cancel.layer.cornerRadius =4;
    cancel.clipsToBounds = YES;
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:cancel];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-60)/2+10, 100,100, 30)];
    sure.backgroundColor = [UIColor redColor];
    [sure setTitle:sureText forState:0];
    sure.titleLabel.font = font(14);
    sure.layer.cornerRadius =4;
    sure.clipsToBounds = YES;
    [sure addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:sure];
}

-(void)cancel
{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)sure:(UIButton *)btn
{
    _complmentBlock(btn.titleLabel.text);
    
    [self cancel];
}

@end
