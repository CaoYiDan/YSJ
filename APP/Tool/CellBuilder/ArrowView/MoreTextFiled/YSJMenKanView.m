//
//  YSJMenKanView.m
//  SmallPig
//
//  Created by xujf on 2019/6/10.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJMenKanView.h"

@implementation YSJMenKanView
{
    UITextField *_textField;
}

- (void)initUI{
    
    CGFloat h = 50;
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-60, 60)];
    base.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    base.centerX = self.centerX;
    base.centerY = self.centerY - SafeAreaTopHeight;
    base.layer.cornerRadius = 4;
    base.clipsToBounds = YES;
    [self addSubview:base];
    
    CGFloat leftM = kMargin;
    
    int i=0;

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(leftM,5+h*i, 70, 50)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = font(16);
        lab.text = @"门槛  满";
        lab.adjustsFontSizeToFitWidth = YES;
        lab.textColor = KBlack333333;
        [base addSubview:lab];
        
        UITextField *textField = [[UITextField alloc]init];
        [base addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lab.mas_right).offset(10);
            make.width.offset(60);
            make.height.offset(h);
            make.top.equalTo(lab).offset(0);
        }];
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField = textField;
        [textField becomeFirstResponder];
    
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.font = font(16);
    lab2.text = @"元可用";
    lab2.adjustsFontSizeToFitWidth = YES;
    lab2.textColor = KBlack333333;
    [base addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField.mas_right).offset(3);
        make.width.offset(50);
        make.height.offset(h);
        make.top.equalTo(lab).offset(0);
    }];
    
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
    
    [self shat];
    
    self.block(@[[NSString stringWithFormat:@"满%@元可用",_textField.text]]);
}

@end
