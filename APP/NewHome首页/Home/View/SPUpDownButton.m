//
//  SPUpDownButton.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/12.
//  Copyright © 2017年 李智帅. All rights reserved.


#import "SPUpDownButton.h"

@implementation SPUpDownButton

{
    UILabel *_uReadLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = font(14);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setUnReadLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(20, 0, 20, 20);
    
    self.titleLabel.frame = CGRectMake(0, 20, 60, 20);
}
    
-(void)setUnReadLabel
{
        _uReadLabel = [[UILabel alloc]init];
        _uReadLabel.font = kFontNormal;
        _uReadLabel.layer.cornerRadius = 7.5;
        _uReadLabel.clipsToBounds = YES;
        _uReadLabel.adjustsFontSizeToFitWidth = YES;
        _uReadLabel.textColor = [UIColor whiteColor];
        _uReadLabel.backgroundColor = [UIColor redColor];
        _uReadLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_uReadLabel];
        [_uReadLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.imageView.mas_right).offset(-5);
            make.size.mas_offset(CGSizeMake(15, 15));
            make.top.offset(1);
        }];
    _uReadLabel.hidden = YES;
}

-(void)setUReadCount:(NSInteger)uReadCount
{
    _uReadCount = uReadCount;
    if (uReadCount==0)
    {
        _uReadLabel.hidden = YES;
        return;
    }
    _uReadLabel.hidden = NO;
    
    _uReadLabel.text = [NSString stringWithFormat:@"%ld",(long)uReadCount];
    [_uReadLabel transformAnimation];
}
@end
