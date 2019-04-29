//
//  YSJPopTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopSheetView.h"

//#import "YSJPopTextView.h"

@interface YSJPopSheetView()


@end

@implementation YSJPopSheetView

-(void)zhuanhuanqiWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    [self popViewWithTitle:title subTitle:self.otherStr];
}

-(void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
        message:@""
        preferredStyle:UIAlertControllerStyleAlert];
    
    NSArray *arr = [subTitle componentsSeparatedByString:@","];
    NSLog(@"%@",arr);
    for (NSString *str in arr) {
        WeakSelf;
        UIAlertAction* action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
               weakSelf.rightSubTitle = action.title;
           }];
        [alert addAction:action];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消按钮");
        }]];
    [[SPCommon getCurrentVC] presentViewController:alert animated:YES completion:nil];
}


@end
