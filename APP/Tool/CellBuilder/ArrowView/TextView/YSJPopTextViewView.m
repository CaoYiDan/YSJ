//
//  YSJPopTextFiledView.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopTextViewView.h"
#import "YSJPopTextView.h"

#define cellH 76

@interface YSJPopTextViewView()

@property (nonatomic,strong) YSJPopTextView *textFiled;

@end

@implementation YSJPopTextViewView

- (void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    self.textFiled.title = title;
    self.textFiled.originY = 0;
    self.textFiled.content = self.textFiled.textView.text;
    WeakSelf;
    self.textFiled.block = ^(NSString *reslut){
        
        weakSelf.rightSubTitle = reslut;
    };
}

- (YSJPopTextView *)textFiled{
    if (!_textFiled) {
        _textFiled = [[YSJPopTextView
                       alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) placeHolder:@"" content:@""];
        [[SPCommon getCurrentVC].view addSubview:_textFiled];
    }
    return _textFiled;
}


@end
