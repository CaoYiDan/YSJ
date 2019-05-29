
//
//  SPKungFuSection.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPKungFuSection.h"

@implementation SPKungFuSection
{
    UILabel *_titleLabel;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, self.frameHeight)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_titleLabel];
    
    //分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

@end
