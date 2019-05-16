//
//  YSJBottomMoreButtonView.m
//  SmallPig
//
//  Created by xujf on 2019/5/9.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJEvaluateVC.h"
#import "YSJOrderDeatilVC.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJOrderModel.h"
#import "YSJDrawBackVC.h"
#import "YSJDrawBackDeatilVC.h"

@implementation YSJBottomMoreButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = grayF2F2F2;
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(0);
            make.height.offset(1);
            make.top.offset(0);
        }];
        
        {
            UIView *bottomLine = [[UIView alloc]init];
            bottomLine.backgroundColor = grayF2F2F2;
            [self addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(6);
                make.bottom.offset(0);
            }];
        }
        
    }
    return self;
}

- (void)setBtnTextArr:(NSArray *)btnTextArr{
    
    _btnTextArr = btnTextArr;
    
    int i =0;
    
    UIView *rightView = self;
    
    for (NSString *str in btnTextArr) {
        
        UIButton *btn = [FactoryUI createButtonWithtitle:str titleColor:[UIColor hexColor:@"666666"] imageName:nil backgroundImageName:nil target:self selector:@selector(btnClick:)];
        btn.layer.cornerRadius = 11;
        btn.clipsToBounds = YES;
        btn.layer.borderColor = [UIColor hexColor:@"E6E6E6"].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.tag = i;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                 make.right.offset(-kMargin);
            }else{
            make.right.equalTo(rightView.mas_left).offset(-10);
            }
           
            make.width.offset(67);
            make.height.offset(22);
            make.centerY.offset(0);
        }];
        
        rightView = btn;
        
        i++;
    }
}

- (void)setMoreColorBtnArr:(NSArray<NSDictionary *> *)moreColorBtnArr{
    
    _moreColorBtnArr = moreColorBtnArr;
    
    int i =0;
    
    UIView *rightView = self;
    //字体颜色
    NSArray *textColorArr = @[[UIColor hexColor:@"666666"],[UIColor hexColor:@"E8541E"]];
    //边框颜色
    NSArray *borderColorArr = @[[UIColor hexColor:@"E6E6E6"],[UIColor hexColor:@"FFD1BE"]];
    
    for (NSDictionary *dic in moreColorBtnArr) {
        
        
        UIButton *btn = nil;
        
        NSString *title = dic[@"title"];
        NSInteger type = [dic[@"type"] integerValue];
        
        btn = [FactoryUI createButtonWithtitle:title titleColor:textColorArr[type] imageName:nil backgroundImageName:nil target:self selector:@selector(btnClick:)];
        UIColor *borderColor = borderColorArr[type];
        btn.layer.borderColor = borderColor.CGColor;
        
        btn.layer.cornerRadius = 11;
        btn.clipsToBounds = YES;
        
        btn.layer.borderWidth = 1.0;
        btn.tag = i;
        [self addSubview:btn];
        
        CGFloat width= [title sizeWithFont:font(12) maxW:200].width+30;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.right.offset(-kMargin);
            }else{
            make.right.equalTo(rightView.mas_left).offset(-10);
            }
            make.width.offset(width);
            make.height.offset(22);
            make.centerY.offset(0);
        }];
        
        rightView = btn;
        
        i++;
    }
}

-(void)btnClick:(UIButton *)btn{
    
    YSJDrawBackVC *vc = [[YSJDrawBackVC alloc]init];
    vc.model = self.model;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    return;
    
//    YSJEvaluateVC *vc = [[YSJEvaluateVC alloc]init];
//    vc.orderId = self.model.orderId;
//    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    return;
    
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"评价"]) {
        YSJEvaluateVC *vc = [[YSJEvaluateVC alloc]init];
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"查看"]){
        
        if ([self.model.order_status containsString:@"退款"]) {
            YSJDrawBackDeatilVC *vc = [[YSJDrawBackDeatilVC alloc]init];
            vc.model = self.model;
            [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        }else{
           YSJOrderDeatilVC *vc = [[YSJOrderDeatilVC alloc]init];
          vc.model = self.model;
          [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
            
        }
    }else if ([title isEqualToString:@"申请退款"]){
        YSJDrawBackVC *vc = [[YSJDrawBackVC alloc]init];
        vc.model = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"删除"] ||[title isEqualToString:@"确认授课完成"] ){
        [self popAlterViewWithTitle:title];
    }
    
    return;
    
    [self.delegate bottomMoreButtonViewClickWithIndex:btn.tag andTitle:btn.titleLabel.text];
}

- (void)popAlterViewWithTitle:(NSString *)title
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@？",title]
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
          handler:^(UIAlertAction * action) {
              [self readyTodoSomething:title];
          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
         handler:^(UIAlertAction * action) {
             //响应事件
             NSLog(@"action = %@", action);
         }];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    
    [[SPCommon getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

-(void)readyTodoSomething:(NSString *)title{
    if ([title isEqualToString:@"删除"] || [title isEqualToString:@"取消订单"]) {
        
    }else if ([title isEqualToString:@"确认授课完成"]){
        
    }
}
@end
