//
//  SPRightReusableView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMySkillHeaderReusableView.h"

@implementation SPMySkillHeaderReusableView
{
    UILabel *_textLab;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self sUI];
    }
    return self;
}

-(void)sUI
{
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    headerLab.font = font(13);
    _textLab = headerLab;
    headerLab.backgroundColor = CategoryBaseColor;
    headerLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:headerLab];
}

-(void)setName:(NSString *)name {
    _name = name;
    _textLab.text = name;
}

-(void)setTextFont:(NSInteger)font{
    _textLab.font = font(font);
}
@end

