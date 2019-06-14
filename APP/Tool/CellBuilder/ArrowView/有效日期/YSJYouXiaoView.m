//
//  YSJYouXiaoView.m
//  SmallPig
//
//  Created by xujf on 2019/6/10.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJYouXiaoView.h"
#import "HZQDatePickerView.h"

@implementation YSJYouXiaoView
{
    UIButton *startDate;
    UIButton *endDate;
}
- (void)initUI{
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(20,40, kWindowW-40,240)];
    base.layer.cornerRadius = 5;
    base.clipsToBounds= YES;
    base.backgroundColor = [UIColor whiteColor];
    base.centerX = self.centerX;
    base.centerY = self.centerY - SafeAreaTopHeight;
    [self addSubview:base];
    
    
    startDate = [[UIButton alloc]initWithFrame:CGRectMake(60, 40, kWindowW-160, 40)];
    startDate.layer.cornerRadius = 5;
    startDate.clipsToBounds = YES;
    [startDate setTitle:@"开始时间" forState:0];
    startDate.titleLabel.adjustsFontSizeToFitWidth = YES;
    [startDate setTitleColor:KWhiteColor forState:0];
    WeakSelf;
    [startDate addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf setupDateView:DateTypeOfStart];
    }];
    startDate.backgroundColor = KMainColor;
    [base addSubview:startDate];
    
    
    endDate = [[UIButton alloc]initWithFrame:CGRectMake(60, 100, kWindowW-160, 40)];
    endDate.layer.cornerRadius = 5;
    endDate.clipsToBounds = YES;
    [endDate setTitle:@"结束时间" forState:0];
     endDate.titleLabel.adjustsFontSizeToFitWidth = YES;
    [endDate setTitleColor:KWhiteColor forState:0];
    [endDate addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf setupDateView:DateTypeOfEnd];
    }];
    endDate.backgroundColor = KMainColor;
    [base addSubview:endDate];
    
    
  UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(80, 190, kWindowW-200, 40)];
    sure.layer.cornerRadius = 5;
    sure.layer.borderColor = KMainColor.CGColor;
    sure.layer.borderWidth = 1.0f;
    sure.clipsToBounds = YES;
    [sure setTitle:@"确定" forState:0];
    [sure setTitleColor:KMainColor forState:0]; sure.titleLabel.adjustsFontSizeToFitWidth = YES;
  
    [sure addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        
        NSArray *startArr = [startDate.titleLabel.text componentsSeparatedByString:@":"];
        
        
         NSArray *endArr = [endDate.titleLabel.text componentsSeparatedByString:@":"];
       
        
        if (endArr.count!=2||startArr.count!=2) {
            Toast(@"请选择完整信息");
            return ;
        }
        weakSelf.block(@[startArr[1],endArr[1]]);
        
        [weakSelf shat];
    }];
    
    sure.backgroundColor = KWhiteColor;
    [base addSubview:sure];
}

- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, kWindowW, kWindowH + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    // 今天开始往后的日期
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    // 在今天之前的日期
    //    [_pikerView.datePickerView setMaximumDate:[NSDate date]];
    [self addSubview:_pikerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:

            [startDate setTitle:[NSString stringWithFormat:@"开始日期:%@", date] forState:0];
            break;
            
        case DateTypeOfEnd:

            [endDate setTitle:[NSString stringWithFormat:@"结束日期:%@", date] forState:0];
            break;
            
        default:
            break;
    }
}

@end
