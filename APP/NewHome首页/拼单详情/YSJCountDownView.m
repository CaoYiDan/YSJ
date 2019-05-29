//
//  YSJCountDownView.m
//  SmallPig
//
//  Created by xujf on 2019/5/18.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJCountDownView.h"
#import "YSJSpellListModel.h"

@interface YSJCountDownView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YSJCountDownView
{
    UILabel *_timeLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self setUpTimer];
    }
    return self;
}

-(void)initUI{
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = font(12);
    _timeLabel.textColor = KWhiteColor;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

-(void)setMyTimer{
    __weak id weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        NSLog(@"block %@",weakSelf);
        [weakSelf timerEvent];
    }];
}

//计时器
- (void)setUpTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {

        if (_leftTime <= 0) {
            return;
        }
        
        _leftTime--;
    
        [self updateTime];
    
}

#pragma mark - 刷新时间

-(void)refreshTime{
    
    NSInteger countDownTime = _leftTime;
    NSString *timeText = @"";
    if (countDownTime <= 0) {
        timeText = @"系统将自动为您退款";
    } else {
       
        timeText = [NSString stringWithFormat:@"剩余时间 %@小时%@分%@秒",[NSString stringWithFormat:@"%02ld", countDownTime/3600],[NSString stringWithFormat:@"%02ld", countDownTime%3600/60],[NSString stringWithFormat:@"%02ld", countDownTime%60]];
    }
    
    _timeLabel.text = timeText;
}

//刷新时间
- (void)updateTime {
    
    [self refreshTime];
}

//倒计时完成
- (void)countDownFinish {
    
    if (_leftTime > 0) {
        return;
    }
}

- (void)dealloc {
    NSLog(@"销毁");
    if (_timer) {
        if ([_timer isValid]) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}
@end


@implementation NSTimer(BlockTimer)
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats blockTimer:(void (^)(NSTimer *))block{
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timered:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)timered:(NSTimer*)timer {
    void (^block)(NSTimer *timer)  = timer.userInfo;
    block(timer);
}
@end
