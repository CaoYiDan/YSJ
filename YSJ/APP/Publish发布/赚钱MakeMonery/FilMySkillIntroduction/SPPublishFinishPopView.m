//
//  SPPopTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishFinishPopView.h"

@implementation SPPublishFinishPopView
{
    UILabel *_title;
    UILabel *_content;
}

-(instancetype)initWithFrame:(CGRect)frame complment:(complment)complment {
    self = [super initWithFrame:frame];
    if (self) {
        _complmentBlock = complment;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, SCREEN_W-60, 180)];
    baseView.backgroundColor = WC;
    baseView.layer.cornerRadius = 5;
    baseView.clipsToBounds = YES;
    baseView.center = self.center;
    [self addSubview:baseView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-60, 40)];
    title.font = font(16);
    _title = title;
    title.text = @"提示";
    title.textAlignment =NSTextAlignmentCenter;
    [baseView addSubview:title];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-60, 0.8)];
    line.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:line];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_W-80, 80)];
    content.numberOfLines = 0;
    _content = content;
    content.textAlignment = NSTextAlignmentCenter;
    content.text = @"技能发布成功!\n\n完善资料可以提升需求方对您技能的新热度哦!";
    content.font = font(15);
    [baseView addSubview:content];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-60)/2-110, 130, 100, 30)];
    cancel.backgroundColor = [UIColor redColor];
    [cancel setTitle:@"补充资料" forState:0];
    cancel.titleLabel.font = font(14);
    cancel.layer.cornerRadius =4;
    cancel.clipsToBounds = YES;
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:cancel];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-60)/2+10, 130,100, 30)];
    sure.backgroundColor = [UIColor redColor];
    [sure setTitle:@"返回" forState:0];
    sure.titleLabel.font = font(14);
    sure.layer.cornerRadius =4;
    sure.clipsToBounds = YES;
    [sure addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:sure];
}

-(void)cancel:(UIButton *)btn{
    
    _complmentBlock(btn.titleLabel.text);
    
    [self quit];
   
}

-(void)quit{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)sure:(UIButton *)btn{
    
    _complmentBlock(btn.titleLabel.text);
    
    [self quit];
    
}

@end

