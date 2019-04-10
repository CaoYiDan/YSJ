//
//  SPReusableViewFooter.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPReusableViewFooter.h"

@implementation SPReusableViewFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-10, 40)];
    tip.text = @"注：充值返现为显示活动，最终解释权归小猪约平台所有";
    tip.adjustsFontSizeToFitWidth = YES;
    tip.textColor = [UIColor grayColor];
    tip.font = kFontNormal;
    [self addSubview:tip];
}
@end
