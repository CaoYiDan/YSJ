//
//  YSJPushVCArrowView.m
//  SmallPig
//
//  Created by xujf on 2019/5/5.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPushVCArrowView.h"
#import "YSJChoseTagsVC.h"

@implementation YSJPushVCArrowView
//转换器
-(void)zhuanhuanqiWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    [self popViewWithTitle:title pushVCString:self.otherStr];
}

- (void)popViewWithTitle:(NSString *)title pushVCString:(NSString *)pushVCString{
    
    NSLog(@"%@",pushVCString);
    
//    Class class = NSClassFromString(pushVCString);
//    UIViewController *vc = [(UIViewController *)[class alloc]init];
//    WeakSelf;
//    [[NSNotificationCenter defaultCenter]addObserverForName:[NSString stringWithFormat:@"%@%@",CB_NSNotification,pushVCString] object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        NSDictionary *info = note.userInfo;
//        weakSelf.rightSubTitle = info[@"result"];
//    }];
    
    YSJChoseTagsVC *vc = [[YSJChoseTagsVC alloc]init];
    vc.type = self.otherStr;
    WeakSelf;
    vc.block = ^(NSMutableArray *arr) {
        weakSelf.rightSubTitle = [arr componentsJoinedByString:@","];
    };
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
