//
//  YSJCommonself.m
//  SmallPig
//
//  Created by xujf on 2019/4/1.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJCommonBottomView.h"

@implementation YSJCommonBottomView
{
    NSArray *_titleArr;
    UILabel *_lab1;
    UILabel *_lab2;
    UILabel *_lab3;
    UILabel *_lab4;
    UILabel *_lab5;
    UILabel *_lab6;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = titleArr;
        [self initUI];
    }
    return self;
}

-(void)initUI{
   

    CGFloat wid = kWindowW/3;

    UILabel *_lab1 = [[UILabel alloc]init];
    _lab1.font = font(12);
    _lab1.textAlignment = NSTextAlignmentCenter;
    _lab1.textColor = gray999999;
    _lab1.backgroundColor = KWhiteColor;
    _lab1.textAlignment = NSTextAlignmentCenter;
    _lab1.text = _titleArr[0];
    [self addSubview:_lab1];
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(0);
        make.height.offset(30);
        make.top.offset(7.5);
    }];

     _lab2 = [[UILabel alloc]init];
    _lab2.numberOfLines = 0;
    _lab2.font = font(16);
    _lab2.textAlignment = NSTextAlignmentCenter;

    _lab2.backgroundColor = KWhiteColor;
    _lab2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab2];
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(0);
        make.height.offset(30);
        make.top.equalTo(_lab1.mas_bottom).offset(0);
    }];

    //接单量
    UILabel *_lab3 = [[UILabel alloc]init];
    _lab3.font = font(12);
    _lab3.textAlignment = NSTextAlignmentCenter;
    _lab3.textColor = gray999999;
    _lab3.backgroundColor = KWhiteColor;
    _lab3.textAlignment = NSTextAlignmentCenter;
    _lab3.text = _titleArr[1];
    [self addSubview:_lab3];
    [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(wid);
        make.height.offset(30);
        make.top.offset(7.5);
    }];

    _lab4 = [[UILabel alloc]init];
    _lab4.numberOfLines = 0;
    _lab4.font = font(16);
    _lab4.textAlignment = NSTextAlignmentCenter;
    //    _lab4.textColor = KWhiteColor;
    _lab4.backgroundColor = [UIColor whiteColor];
    _lab4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab4];
    [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(wid);
        make.height.offset(30);
        make.top.equalTo(_lab1.mas_bottom).offset(0);
    }];

    //接单量
    UILabel *_lab5 = [[UILabel alloc]init];
    _lab5.font = font(12);
    _lab5.textAlignment = NSTextAlignmentCenter;
    _lab5.textColor = gray999999;
    _lab5.backgroundColor = KWhiteColor;
    _lab5.textAlignment = NSTextAlignmentCenter;
    _lab5.text = _titleArr[2];
    [self addSubview:_lab5];
    [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(wid*2);
        make.height.offset(30);
        make.top.offset(7.5);
    }];

    _lab6 = [[UILabel alloc]init];
    _lab6.font = font(16);
    _lab6.textAlignment = NSTextAlignmentCenter;
    //    _lab6.textColor = KWhiteColor;
    _lab6.backgroundColor = [UIColor whiteColor];
    _lab6.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab6];
    [_lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(wid);
        make.left.offset(wid*2);
        make.height.offset(30);
        make.top.equalTo(_lab1.mas_bottom).offset(0);
    }];

    UIView *bottomLine1 = [[UIView alloc]init];
    bottomLine1.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.top.equalTo(self).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

-(void)setContent2:(NSString *)content2 content4:(NSString *)content4 content6:(NSString *)content6{
    NSLog(@"%@",content2);
    _lab2.text = content2;
    _lab4.text = content4;
    _lab6.text = content6;
}

@end
