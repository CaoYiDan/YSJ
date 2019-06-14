//
//  YSJAlpplication_ThirdVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSJCreateHBVC : BaseViewController

//从上个界面传过来的资质证书字符串（仅在本界面提交，并不显示）
@property (nonatomic,copy) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
