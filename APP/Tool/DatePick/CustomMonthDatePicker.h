//
//  CustomMonthDatePicker.h
//  IntelligentRestaurant
//
//  Created by xgm on 17/5/5.
//  Copyright © 2017年 xiegm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMonthDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,assign)int currentYear;
@property(nonatomic,assign)int currentMonth;
@property(nonatomic)int year;
@property(nonatomic)int month;
@end
