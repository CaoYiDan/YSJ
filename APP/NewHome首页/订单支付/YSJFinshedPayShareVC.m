//
//  YSJFinshedPayShareVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJFinshedPayShareVC.h"
#import "YSJSpellListModel.h"
#import "YSJSpellPersonModel.h"
@interface YSJFinshedPayShareVC ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YSJFinshedPayShareVC

{
    UILabel *_leftTime;
    NSString *_hour;
    NSString *_minute;
    NSString *_second;
    UILabel *_bottomTip1;
    UILabel *_bottomTip2;
    
}

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"分享";
    
    [self setUI];
    
    [self setMyTimer];
    
}

-(void)setMyTimer{
    
    __weak id weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        NSLog(@"block %@",weakSelf);
        [weakSelf timerEvent];
    }];
}

- (void)dealloc {
    
    if (_timer) {
        
        if ([_timer isValid]) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}


- (void)timerEvent {
   
    [self.model countDown];
    
    [self refreshTimeWithModel:self.model];
}

-(void)setUI{
    
    _leftTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, kWindowW, 20)];
    _leftTime.textAlignment = NSTextAlignmentCenter;
    _leftTime.font = font(18);
    _leftTime.textColor = [UIColor hexColor:@"262628"];
    [self.view addSubview:_leftTime];
    
    
    CGFloat iconW = (kWindowW-6*kMargin)/5;
    UIImageView *lastImg = nil;
    
    int iconNum = 0;
    if (self.needNum<=self.model.count) {
        iconNum = self.model.count +1;
    }else{
        iconNum = self.needNum;
    }
    
    for (int i =0 ; i<iconNum; i++) {
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin +(iconW+kMargin)*(i%5), 20*(i/5)+70,iconW, iconW)];
        icon.layer.cornerRadius = iconW/2;
        icon.clipsToBounds = YES;
        icon.contentMode  = UIViewContentModeScaleAspectFill;
        [self.view addSubview:icon];
        
        if (i==0) {//团长头像
            
            [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,self.model.creater.photo]]];
            
            //团长标签
            UIImageView *tuanzhangImg = [[UIImageView alloc]initWithFrame:CGRectMake(12,45,36, 15)];
            
            tuanzhangImg.image = [UIImage imageNamed:@"tuanzhang"];
            tuanzhangImg.clipsToBounds = YES;
            
            [icon addSubview:tuanzhangImg];
            
        }else if (i<=self.model.member.count){//之前的成员图标
            
            YSJSpellPersonModel *mod = self.model.member[i-1];
             [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,mod.photo]]];
        }else if (i==self.model.member.count+1){//自己的图标
            icon.backgroundColor = grayF2F2F2;
            ImgWithUrl(icon, [StorageUtil getPhotoUrl])
        }else{//” ？“图标
            icon.image = [UIImage imageNamed:@"yonghu5"];
        }
        
        //获取最后一个icon为下边的控件布局作为参照，
        if (i == self.needNum-1) {
            lastImg = icon;
        }
    }
    
    _bottomTip1 = [[UILabel alloc]init];
    _bottomTip1.textAlignment = NSTextAlignmentCenter;
    _bottomTip1.font = font(18);
    
    int leftCount = self.needNum-self.model.count-1;
    
    if(leftCount<=0){
          _bottomTip1.text = @"拼单已成功！";
    }else{
          _bottomTip1.text = [NSString stringWithFormat:@"还差%d人,赶快邀请好友来拼单吧~",leftCount];
    }
  
    _bottomTip1.textColor = KBlackColor;
    [self.view addSubview:_bottomTip1];
    [_bottomTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(20);
        make.top.equalTo(lastImg.mas_bottom).offset(28);
    }];
    
    
    UIButton *inviteBtn = [[UIButton alloc]init];
    inviteBtn.backgroundColor = KMainColor;
    [inviteBtn setTitle:@"邀请好友拼单" forState:0];
    inviteBtn.layer.cornerRadius = 5;
    inviteBtn.titleLabel.font = font(16);
    inviteBtn.clipsToBounds = YES;
    [inviteBtn addTarget:self action:@selector(inviteClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.top.equalTo(_bottomTip1.mas_bottom).offset(28);
    }];
    
    _bottomTip2 = [[UILabel alloc]init];
    _bottomTip2.textAlignment = NSTextAlignmentCenter;
    _bottomTip2.font = font(14);
    
    if(leftCount<=0){
        _bottomTip2.text = [NSString stringWithFormat:@"最少%d人拼单成功，拼单不成功退款",self.needNum];;
    }else{
        _bottomTip2.text = @"";
    }
   
    _bottomTip2.textColor = black666666;
    [self.view addSubview:_bottomTip2];
    [_bottomTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(20);
        make.top.equalTo(inviteBtn.mas_bottom).offset(18);
    }];
    
}

-(void)inviteClick{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 刷新时间
-(void)refreshTimeWithModel:(YSJSpellListModel*)timeModel{
    
    NSInteger countDownTime = timeModel.startTime - timeModel.currentTime;
    
    if (countDownTime <= 0) {
        _hour = @"00";
        _minute = @"00";
        _second = @"00";
    } else {
        _hour = [NSString stringWithFormat:@"%02ld", countDownTime/3600];
        _minute = [NSString stringWithFormat:@"%02ld", countDownTime%3600/60];
        _second = [NSString stringWithFormat:@"%02ld", countDownTime%60];
    }
    
    _leftTime.text = [NSString stringWithFormat:@"剩余 %@ : %@ : %@",_hour,_minute,_second];
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
