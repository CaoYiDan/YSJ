//
//  SPPerfectBirthDayVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPerfectBirthDayVC.h"

#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
#import "SPPerfectNameVC.h"
@interface SPPerfectBirthDayVC ()

@end

@implementation SPPerfectBirthDayVC
{
    UILabel *_birthLabel;
    NSString *_result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景图片
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_birthday"]];
    
    //创建UI
    [self createUI];
    
}

-(void)createUI{
    
    CGFloat wid =300;
    CGFloat height = wid/8*5.5;
    
    //base
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wid, height)];
    baseView.center = self.view.center;
    baseView.layer.cornerRadius =20.0f;
    [self.view addSubview:baseView];
    
    //上半部分
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wid, height/2)];
    [topImg setImage:[UIImage imageNamed:@"gr_bir_top"]];
    [baseView addSubview:topImg];
    
    //点击按钮
    UIButton *choseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height/2, wid, height/2)];
    [choseBtn setBackgroundImage:[UIImage imageNamed:@"gr_bir_down"] forState:0];
    [choseBtn addTarget:self action:@selector(chose) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:choseBtn];
    
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2-5, wid, 60)];
    showLabel.numberOfLines = 2;
    _birthLabel = showLabel;
    showLabel.font = [UIFont boldSystemFontOfSize:17];
    showLabel.textColor = [UIColor blackColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:showLabel];
    
    if (self.formMyCenter) {
        if (isEmptyString(self.user.birthday)) {
            _result = @"1990-01-01";
            showLabel.text = @"Birthday\n1990/01/01";
        }else{
        _result = self.user.birthday;
        showLabel.text = [NSString stringWithFormat:@"Birthday\n%@",self.user.birthday];
           
        }
    }else{
    //获取之前存储的用户信息
    NSDictionary *userDict = [StorageUtil getUserDict];
    if (!isEmptyString(userDict[@"birthday"]) ) {
        //初始化
        _result = userDict[@"birthday"];
         showLabel.text = [NSString stringWithFormat:@"Birthday\n%@",userDict[@"birthday"]];
     }else{
        //初始化
        _result = @"1990-01-01";
         showLabel.text = @"Birthday\n1990/01/01";
     }
    }
    
}

//弹出日历选择
-(void)chose{
    
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date:@"2017-09-14 00:30:46 +0000" WithFormat:@"yyyy-MM-dd HH:mm"] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
         ;
        _result = [startDate stringWithFormat:@"yyyy-MM-dd"];
        _birthLabel.text = [NSString stringWithFormat:@"Birthday\n%@",[startDate stringWithFormat:@"yyyy/MM/dd"]];
//        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }];
 
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.dateType = DateTypeStartDate;
//    datepicker.minLimitDate = [NSDate date:@"2017-2-28 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"2018-2-28 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
}

-(void)next{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_result forKey:@"birthdayStr"];
    [self postMessage:dict pushToVC:NSStringFromClass([SPPerfectNameVC class])];
}

-(void)jump{
     [self pushViewCotnroller:NSStringFromClass([SPPerfectNameVC class])];
}
@end
