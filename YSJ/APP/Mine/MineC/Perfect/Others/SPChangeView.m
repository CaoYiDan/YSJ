//
//  SPAddNewTagView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/9.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChangeView.h"

@implementation SPChangeView
{
    UITextField *_textFiled;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =RGBCOLORA(0, 0, 0, 0.4);
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(20, SCREEN_H2/2-200, SCREEN_W-40, 200)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:baseView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 40));
        make.centerX.offset(0);
        make.top.offset(10);
    }];
    
    
    UILabel *addTagLab = [[UILabel alloc]initWithFrame:CGRectMake(10,baseView.frameHeight
                                                                  /2-20, 100, 40)];
    addTagLab.text = @"请输入内容 |";
    addTagLab.font = BoldFont(18);
    addTagLab.textColor = [UIColor blackColor];
    addTagLab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:addTagLab];
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addTagLab.frame), baseView.frameHeight/2-20, self.frameWidth-CGRectGetMaxX(addTagLab.frame), 40)];
    _textFiled = textFiled;
    [baseView addSubview:textFiled];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
    [okBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 40));
        make.centerX.offset(0);
        make.bottom.offset(-10);
    }];
    
}

-(void)becomeExid{
    //一进来 就进入编辑状态
    [_textFiled becomeFirstResponder];
}

-(void)close{
    [_textFiled endEditing:YES];
    self.originY = SCREEN_H2;
}

-(void)ok{
 [_textFiled endEditing:YES];
 self.originY = SCREEN_H2;
   
   
}
@end
