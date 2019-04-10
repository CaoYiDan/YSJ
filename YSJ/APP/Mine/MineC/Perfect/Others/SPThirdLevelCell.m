//
//  SPThirdLevelCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPThirdLevelCell.h"

@implementation SPThirdLevelCell
{
    UILabel *_textLab;
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
    _textLab = [[UILabel alloc]init];
    _textLab .textAlignment  =NSTextAlignmentCenter;
    _textLab.font = font(12);
    _textLab.adjustsFontSizeToFitWidth = YES;
    _textLab.layer.cornerRadius = 5;
    _textLab.clipsToBounds =YES;
    [self.contentView addSubview:_textLab];
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.height.offset(22);
        make.centerY.offset(0);
        make.width.equalTo(self);
    }];
}

-(void)setText:(NSString *)text{
    text = [NSString stringWithFormat:@"%@ ",text];
    _textLab.text = text;
}

-(void)setBaseColor:(UIColor *)baseColor{
    if (baseColor ==nil) {
        return;
    }
    _baseColor = baseColor;
    _textLab.backgroundColor = baseColor;
}

@end
