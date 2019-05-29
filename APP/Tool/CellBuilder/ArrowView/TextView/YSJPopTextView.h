//
//  YSJPopTextView.h
//  SmallPig
//
//  Created by xujf on 2019/4/18.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"
#import "LGTextView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^result)(NSString *result);
@interface YSJPopTextView : SPBasePopView

@property (nonatomic,strong) LGTextView *textView;
@property (nonatomic,copy) NSString *placeHodler;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) result block;

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placehodler content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
