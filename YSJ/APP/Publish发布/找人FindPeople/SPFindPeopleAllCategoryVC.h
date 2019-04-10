//
//  SPAllCategoryVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//
//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) ();

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SPFindPeopleAllCategoryVC : BaseViewController

//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;


@end

