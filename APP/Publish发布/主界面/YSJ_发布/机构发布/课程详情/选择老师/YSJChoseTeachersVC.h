//
//  YSJChoseTeachersVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/5.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

@protocol ChoseTeacherDelegate

/**
 选择老师完毕
 */
-(void)choseTeacherFinishWithArr:(NSMutableArray *)teacherArr;

@end


NS_ASSUME_NONNULL_BEGIN

@interface YSJChoseTeachersVC : BaseViewController

@property (nonatomic,weak) id<ChoseTeacherDelegate> delegate;

/**
 选中的老师
 */
@property (nonatomic,strong) NSMutableArray *selectedArr;

@end

NS_ASSUME_NONNULL_END
