
//
//  SPKungFuSection.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyInterestSection.h"

@implementation SPMyInterestSection
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
    
    //分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, self.frameHeight)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_titleLabel];
    
    //箭头
    _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 20, 20)];
    [_arrow setImage:[UIImage imageNamed:@"grxx_r3_c3"]];
    [self addSubview:_arrow];
}

//标题text
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

//箭头 上下设置
-(void)setFlag:(NSString *)flag{
    _flag = flag;
    if ([flag isEqualToString:@"NO"])
    {
        _arrow.transform=CGAffineTransformIdentity;
        
    }else
    {
        _arrow.transform=CGAffineTransformMakeRotation(M_PI);
    }
}

//字体颜色设置
-(void)setBaseColor:(UIColor *)baseColor{
    _baseColor = baseColor;
    _titleLabel.textColor = baseColor;
}
@end
