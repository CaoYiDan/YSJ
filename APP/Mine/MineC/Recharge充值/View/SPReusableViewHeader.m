//
//  SPReusableViewHeader.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPReusableViewHeader.h"

@implementation SPReusableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
       [self setUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUI];
    } 
    return self;
}

-(void)setUI
{
    UILabel *payType = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 60)];
    payType.text = @"支付方式";
    payType.font = font(16);
    payType.textColor = [UIColor grayColor];
    [self addSubview:payType];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
