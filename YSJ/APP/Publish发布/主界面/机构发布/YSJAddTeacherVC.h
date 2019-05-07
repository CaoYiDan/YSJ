//
//  YSJAddTeacherVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddTeacherDelegate

/**
 添加老师成功
 */
-(void)addTeacherSucceed;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YSJAddTeacherVC : BaseViewController
@property (nonatomic,weak) id<AddTeacherDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
