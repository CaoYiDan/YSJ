//
//  YSJPopTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopTextFiledView.h"

#define cellH 76

@implementation YSJPopTextFiledView

- (void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    WeakSelf;
    [SPCommon creatAlertControllerTitle:title subTitle:@"" _alertSure:^(NSString *text) {
        weakSelf.rightSubTitle = text;
    }];
    
}

@end
