//
//  YSJPopCourserCellView.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJPopTeachTypeView.h"

#import "YSJPopCourserCellView.h"

@interface YSJPopCourserCellView()

@property (nonatomic,strong) YSJPopTeachTypeView *popView;

@end

@implementation YSJPopCourserCellView

- (void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
   
    self.popView.originY = 0;
    
    WeakSelf;
    
    self.popView.block = ^(NSMutableArray *chosedArr) {
        weakSelf.rightSubTitle = [chosedArr componentsJoinedByString:@","];
    };
}

- (YSJPopTeachTypeView *)popView{
    if (!_popView) {
        _popView = [[YSJPopTeachTypeView
                       alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [[SPCommon getCurrentVC].view addSubview:_popView];
    }
    return _popView;
}


@end
