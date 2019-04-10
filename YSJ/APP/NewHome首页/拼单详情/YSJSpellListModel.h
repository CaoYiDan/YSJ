//
//  YSJSpellListModel.h
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CZHUpdateTimeNotification = @"CZHUpdateTimeNotification";
static NSString *const CZHCountDownFinishNotification = @"CZHCountDownFinishNotification";

@class YSJSpellPersonModel;

@interface YSJSpellListModel : NSObject

@property (nonatomic,strong) YSJSpellPersonModel *creater;

@property (nonatomic,strong) NSMutableArray *member;

@property (nonatomic, assign) NSInteger create_time;

///当前时间
@property (nonatomic, assign) NSInteger currentTime;

@property (nonatomic,assign) int count;

///开始倒计时时间
@property (nonatomic, assign) NSInteger startTime;

@property (nonatomic, assign) BOOL isFinished;

//倒计时操作
- (void)countDown;

@end
