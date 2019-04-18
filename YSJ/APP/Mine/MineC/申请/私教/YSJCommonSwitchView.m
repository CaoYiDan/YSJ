//
//  YSJCommonSwitchView.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJCommonSwitchView.h"
#define cellH 76
@implementation YSJCommonSwitchView
{
    UILabel *_leftText;
    UISwitch *_switch;
}
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title selected:(BOOL)selected{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithTitle:title selected:selected];
    }
    return self;
}
-(void)initUIWithTitle:(NSString *)title selected:(BOOL)selected{
    _leftText = [[UILabel alloc]init];
    _leftText.font = font(16);
    _leftText.text = @"上门服务";
    [self addSubview:_leftText];
    [_leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(100);
        make.height.offset(cellH);
        make.top.offset(0);
    }];
    
    _switch = [[UISwitch alloc]init];
    _switch.onTintColor = KMainColor;
    [self addSubview:_switch];
    [_switch setOn:selected];
    [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW-50-kMargin);
        make.height.offset(30);
        make.width.offset(50);
        make.centerY.equalTo(_leftText);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(1);
    make.top.equalTo(_leftText.mas_bottom).offset(0);
    }];
    
}

- (void)setSwitchSelected:(BOOL)switchSelected{
    _switchSelected = switchSelected;
    [_switch setOn:switchSelected];
}

@end
