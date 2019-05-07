//
//  YSJChoseTagsVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
typedef  void(^choseResult) (NSMutableArray *arr);
NS_ASSUME_NONNULL_BEGIN

@interface YSJChoseTagsVC : BaseViewController

@property (nonatomic,copy) choseResult block;

@property (nonatomic,copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
