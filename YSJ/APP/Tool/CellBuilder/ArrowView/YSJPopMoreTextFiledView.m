
//
//  YSJPopMoreTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/28.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopMoreTextFiledView.h"

#import "YSJMoreTextFiledView.h"

@interface YSJPopMoreTextFiledView()

@property (nonatomic,strong) YSJMoreTextFiledView *popView;

@property (nonatomic,strong) NSArray *textArr;

@end

@implementation YSJPopMoreTextFiledView

-(void)zhuanhuanqiWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    [self popViewWithTitle:title subTitle:self.otherStr];
}

- (void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    _textArr = [subTitle componentsSeparatedByString:@","];
    self.popView.originY = 0;
    
    WeakSelf;
    
    self.popView.block = ^(NSMutableArray *chosedArr) {
        weakSelf.rightSubTitle = [chosedArr componentsJoinedByString:@","];
    };
}

- (YSJMoreTextFiledView *)popView{
    
    if (!_popView) {
        _popView = [[YSJMoreTextFiledView
                     alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) arr:_textArr];
        [[SPCommon getCurrentVC].view addSubview:_popView];
    }
    return _popView;
}

@end
