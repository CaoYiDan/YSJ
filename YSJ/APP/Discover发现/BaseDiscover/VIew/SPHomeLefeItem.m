//
//  SPHomeLefeItem.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeLefeItem.h"
#import "SPMyButtton.h"

@implementation SPHomeLefeItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(59, 5, 1, 30)];
        line.backgroundColor = HomeLineColor;
        [self addSubview:line];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight-20);
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel.frame = CGRectMake(0, self.frameHeight-20, self.frameWidth, 20);
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = font(12);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
