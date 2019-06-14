//
//  YSJTextFiledCellView.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJTextFiledCellView.h"
#define cellH 76
@implementation YSJTextFiledCellView
{
    UILabel *_title;
    UITextField *_textFiled;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //titile
        UILabel *leftText = [[UILabel alloc]init];
        leftText.font = font(16);
        _title = leftText;
        leftText.text = title;
        [self addSubview:leftText];
        [leftText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.width.offset(120);
            make.height.offset(cellH);
            make.top.offset(0);
        }];
        
        UITextField *identifierFiled = [[UITextField alloc]init];
        identifierFiled.keyboardType = UIKeyboardTypeDefault                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ;
        _textFiled = identifierFiled;
        identifierFiled.backgroundColor = KWhiteColor;
        identifierFiled.placeholder = placeholder;
        identifierFiled.font = font(14);
        
        identifierFiled.textAlignment = NSTextAlignmentCenter;
        [self addSubview:identifierFiled];
        [identifierFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-kMargin-20);
            make.width.offset(200);
            make.height.offset(cellH);
            make.centerY.equalTo(leftText).offset(0);
        }];
        
        UIImageView *arrowImg2 = [[UIImageView alloc]init];
        arrowImg2.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowImg2];
        [arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.width.offset(8);
            make.height.offset(14);
            make.centerY.equalTo(identifierFiled).offset(0);
        }];
        
        
        UIView *bottomLine2 = [[UIView alloc]init];
        bottomLine2.backgroundColor = grayF2F2F2;
        [self addSubview:bottomLine2];
        [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.height.offset(1);
            make.bottom.equalTo(identifierFiled.mas_bottom).offset(0);
        }];
        
    }
    return self;
}

- (NSString *)getContent{
    return  _textFiled.text;
}
@end
