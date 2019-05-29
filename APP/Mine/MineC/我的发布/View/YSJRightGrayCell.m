//
//  YSJRightYellowCell.m
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJRightGrayCell.h"

@implementation YSJRightGrayCell

- (instancetype)initWithFrame:(CGRect)frame cellH:(CGFloat)cellH title:(NSString *)title rightText:(NSString *)rightText
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUICellH:cellH title:title rightText:rightText];
    }
    return self;
}

-(void)setUICellH:(CGFloat)cellH title:(NSString *)title rightText:(NSString *)rightText{
    
    UILabel *leftTitle = [[UILabel alloc]init];
    leftTitle.font = font(16);
    leftTitle.text = title;
    leftTitle.textColor = KBlack333333;
    leftTitle.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftTitle];
    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(cellH);
        make.top.offset(0);
    }];
    
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.font = font(15);
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.textColor = gray999999;
    rightLabel.text  = rightText;
    rightLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.left.offset(kWindowW-100-12);
        make.height.offset(cellH);
        make.top.equalTo(leftTitle).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}
@end
