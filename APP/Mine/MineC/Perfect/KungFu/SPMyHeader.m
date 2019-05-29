//
//  SPMyHeader.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyHeader.h"

@implementation SPMyHeader
{
    UIImageView *_img;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/2-25, 60,60, 60)];
    [self addSubview:_img];
    
}

-(void)setImg:(UIImage *)image{
    
    [_img setImage:image];
}
@end
