//
//  YSJPopCourserCellView.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJYouXiaoView.h"

#import "YSJPopYouXiaoDateView.h"

@interface YSJPopYouXiaoDateView()

@property (nonatomic,strong) YSJYouXiaoView *popView;

@end

@implementation YSJPopYouXiaoDateView

- (void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    self.popView.originY = 0;
    
    WeakSelf;
    
    self.popView.block = ^(NSMutableArray *chosedArr) {
        weakSelf.rightSubTitle = [chosedArr componentsJoinedByString:@" 至 "];
    };
}

- (YSJYouXiaoView *)popView{
    if (!_popView) {
        _popView = [[YSJYouXiaoView
                     alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [[SPCommon getCurrentVC].view addSubview:_popView];
    }
    return _popView;
}


@end
