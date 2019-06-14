
//
//  YSJPopMoreTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/28.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopMenKanView.h"

#import "YSJMenKanView.h"

@interface YSJPopMenKanView()

@property (nonatomic,strong) YSJMenKanView *popView;

@property (nonatomic,strong) NSArray *textArr;

@end

@implementation YSJPopMenKanView

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

- (YSJMenKanView *)popView{
    
    if (!_popView) {
        _popView = [[YSJMenKanView
                     alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) ];
        [[SPCommon getCurrentVC].view addSubview:_popView];
    }
    return _popView;
}

@end
