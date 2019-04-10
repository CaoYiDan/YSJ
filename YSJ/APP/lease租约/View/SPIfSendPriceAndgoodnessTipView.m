//
//  SPPopTipView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPIfSendPriceAndgoodnessTipView.h"

@implementation SPIfSendPriceAndgoodnessTipView
{
    UITextField *_priceFiledView;
    UILabel *_priceUnitLabel;
    UITextView *_goodnessTextView;
}

-(instancetype)initWithPrice:(NSString *)price priceUnit:(NSString *)priceUnit goodnessText:(NSString *)goodness frame:(CGRect)frame complment:(sendPriceAndgoodnessTipViewComplment)complment{
    self = [super initWithFrame:frame];
    if (self) {
        _complmentBlock = complment;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self setUIWithPrice:price priceUnit:priceUnit goodnessText:goodness];
    }
    return self;
}

-(void)setUIWithPrice:(NSString *)price priceUnit:(NSString *)priceUnit goodnessText:(NSString *)goodness{
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, SCREEN_W-60, 340)];
    baseView.backgroundColor = WC;
    baseView.layer.cornerRadius = 5;
    baseView.clipsToBounds = YES;
    baseView.center = self.center;
    [self addSubview:baseView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-60, 40)];
    title.font = font(16);
    title.text = @"提示信息";
    title.textAlignment =NSTextAlignmentCenter;
    [baseView addSubview:title];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-60, 0.8)];
    line.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:line];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_W-80, 40)];
    content.numberOfLines = 0;
//    content.textAlignment = NSTextAlignmentCenter;
    content.text = @"如下内容将发给需求方，请确认";
    content.font = font(14);
    [baseView addSubview:content];
    
    //服务价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,80 ,70 , 40)];
    priceLabel.text = @"服务价格";
    priceLabel.font = kFontNormal;
    [baseView addSubview:priceLabel];

    //价格输入框
    UITextField *priceFiledView = [[UITextField alloc]initWithFrame:CGRectMake(85, 85, 60, 30)];
    _priceFiledView = priceFiledView;
    priceFiledView.delegate = self;
    priceFiledView.textAlignment = NSTextAlignmentCenter;
    priceFiledView.borderStyle =  UITextBorderStyleRoundedRect;
    priceFiledView.text = price;
    [baseView addSubview:priceFiledView];
    
    //价格单位
    UILabel *priceUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+90,80 ,70 , 40)];
    priceUnitLabel.font = kFontNormal;
    if ([priceUnit isEqualToString:@"HOUR"]) {
        priceUnitLabel.text = @" 元/次";
    }else if([priceUnit isEqualToString:@"TIME"]){
        priceUnitLabel.text = @" 元/小时";
    }
    
    _priceUnitLabel = priceUnitLabel;
    [baseView addSubview:priceUnitLabel];
    
    //服务优势标题
    UILabel *goodnessLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,120,70 ,40)];
    goodnessLabel.font = kFontNormal;
    goodnessLabel.text = @"服务优势";
    [baseView addSubview:goodnessLabel];
    
    //服务优势编辑框
    UITextView *goodnessTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 160, SCREEN_W-80, 60)];
    goodnessTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    goodnessTextView.layer.borderWidth = 1;
    goodnessTextView.text = goodness;
    goodnessTextView.font = Font(14);
    _goodnessTextView = goodnessTextView;
    [baseView addSubview:goodnessTextView];
    
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, (SCREEN_W-60)/2-30, 30)];
    cancel.backgroundColor = [UIColor grayColor];
    [cancel setTitle:@"取消" forState:0];
    cancel.titleLabel.font = font(14);
    cancel.layer.cornerRadius =4;
    cancel.clipsToBounds = YES;
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:cancel];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-60)/2+10, 250,(SCREEN_W-60)/2-30, 30)];
    sure.backgroundColor = [UIColor redColor];
    [sure setTitle:@"确定" forState:0];
    sure.titleLabel.font = font(14);
    sure.layer.cornerRadius =4;
    sure.clipsToBounds = YES;
    [sure addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:sure];
}

-(void)cancel{
    
     _complmentBlock(NO,@"",@"");
    
    [self quit];
}

-(void)sure:(UIButton *)btn{
    
    _complmentBlock(YES,[NSString stringWithFormat:@"%@%@",_priceFiledView.text,_priceUnitLabel.text],_goodnessTextView.text);
    
    [self quit];
    
}

//退出
-(void)quit{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
@end

