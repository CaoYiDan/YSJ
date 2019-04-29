//
//  YSJPopTextView.m
//  SmallPig
//
//  Created by xujf on 2019/4/18.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "LGTextView.h"
#import "YSJPopTextView.h"

@implementation YSJPopTextView
{
    UILabel *_name;
}
- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placehodler content:(NSString *)content
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIPlaceHolder:placehodler content:content];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIPlaceHolder:@"" content:@""];
    }
    return self;
}
-(void)setUIPlaceHolder:(NSString *)placehodler content:(NSString *)content{
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-60, 250)];
    base.backgroundColor = grayF2F2F2;
    base.center = self.center;
    base.layer.cornerRadius = 4;
    base.clipsToBounds = YES;
    [self addSubview:base];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW-60, 50)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = font(16);
    _name = lab;
    lab.textColor =KWhiteColor;
    lab.backgroundColor = KMainColor;
    [base addSubview:lab];
    
    LGTextView *view = [[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 50, kWindowW-60-2*kMargin, 200)];
    view.placeholder = placehodler;
    view.text = content;
    view.font = font(14);
    view.textColor = black666666;
    _textView = view;
    view.backgroundColor = grayF2F2F2;
    [base addSubview:view];
    
    UIButton *sure = [[UIButton alloc]init];
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchDown];
    [sure setTitle:@"确定" forState:0];
    sure.titleLabel.font = font(16);
    [base addSubview:sure];
    sure.backgroundColor = KMainColor;
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.right.offset(-10);
        make.height.offset(50);
        make.top.offset(0);
    }];
}

-(void)sure{
    [_textView resignFirstResponder];
    !self.block?:self.block(_textView.text);
    [self shat];
}

- (void)setPlaceHodler:(NSString *)placeHodler{
    _placeHodler = placeHodler;
    _textView.placeholder = placeHodler;
}

- (void)setContent:(NSString *)content{
    _content = content;
    _textView.text = content;
    [_textView becomeFirstResponder];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _name.text = title;
}
@end
