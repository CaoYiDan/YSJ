//
//  SPNoDataTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/11/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNoDataTipView.h"

@implementation SPNoDataTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UILabel *noDataTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    noDataTitle.numberOfLines = 2;
    noDataTitle.text = @"你还没有订单\n完成以下工作，可以让订单来的猛烈些";
    noDataTitle.textColor = [UIColor grayColor];
    noDataTitle.textAlignment = NSTextAlignmentCenter;
    noDataTitle.font = kFontNormal;
    [self addSubview:noDataTitle];

    NSArray * textArr = @[@"完善个人资料",@"上传照片",@"发布技能"];
    CGFloat btnW =150;
    CGFloat btnH = 35;
    int i=0;
    for (NSString *text in textArr) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2-btnW/2,70+i*(btnH+20), btnW, btnH)];
        btn.backgroundColor = RGBCOLOR(254, 56, 100);
        [btn setTitle:text forState:0];
        btn.titleLabel.font = font(14);
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        
        i++;
    }
}

-(void)click:(UIButton *)btn{
    !self.block?:self.block(btn.titleLabel.text);
}
@end
