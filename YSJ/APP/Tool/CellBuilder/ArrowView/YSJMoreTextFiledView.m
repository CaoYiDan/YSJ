//
//  YSJMoreTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJMoreTextFiledView.h"

@implementation YSJMoreTextFiledView
{
    NSMutableArray *_textArr;
    NSMutableArray *_textFiledArr;
}
- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray*)arr{
    self = [super initWithFrame:frame];
    if (self) {
        _textArr = arr;
        [self setViewWithArr:arr];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setViewWithArr:(NSArray*)arr{
    
    _textFiledArr = @[].mutableCopy;
    CGFloat h = 50;
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-60, h*arr.count+20)];
    base.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    base.center = self.center;
    base.layer.cornerRadius = 4;
    base.clipsToBounds = YES;
    [self addSubview:base];
    
    CGFloat leftM = kMargin;
    
    int i=0;
    
    for (NSString *str in arr) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(leftM,10+h*i, 60, 50)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = font(16);
        lab.text = str;
        lab.textColor = KBlack333333;
        [base addSubview:lab];
        
        UITextField *textField = [[UITextField alloc]init];
        [base addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lab.mas_right).offset(10);
            make.right.offset(-60);
            make.height.offset(h);
            make.top.equalTo(lab).offset(0);
        }];
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [_textFiledArr addObject:textField];
        if (i==0) {
            [textField becomeFirstResponder];
        }
        i++;
    }
    
 
    UIButton *sure = [[UIButton alloc]init];
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchDown];
    [sure setTitle:@"确定" forState:0];
    sure.titleLabel.font = font(15);
    sure.layer.cornerRadius = 5;
    sure.clipsToBounds = YES;
    [base addSubview:sure];
    sure.backgroundColor = KMainColor;
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(60);
        make.right.offset(-10);
        make.height.offset(50);
        make.centerY.offset(0);
    }];
}

-(void)sure{
 
    NSMutableArray *arr = @[].mutableCopy;
    int i = 0;
    
    for (UITextField *textFiled in _textFiledArr) {
        
        if (isEmptyString(textFiled.text)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            //例如 现价:23,原价:34
            [arr addObject:[NSString stringWithFormat:@"%@:%@",_textArr[i],textFiled.text]];
        }
        i++;
    }
    !self.block?:self.block(arr);
    
    [self shat];
    
}

@end
