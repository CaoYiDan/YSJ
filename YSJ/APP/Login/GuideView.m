//
//  GuideView.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "GuideView.h"
@interface GuideView()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
}

@end
@implementation GuideView

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray{

    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H +64)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _scrollView.contentSize = CGSizeMake(SCREEN_W * imageArray.count, 0);
        for (int i = 0; i<imageArray.count; i++) {
            
            UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(i*SCREEN_W, 0, SCREEN_W, SCREEN_H +64) imageName:imageArray[i]];
            
            imageView.userInteractionEnabled = YES;
            
            [_scrollView addSubview:imageView];
            
            self.inputButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W - 60,SafeAreaStateHeight, 50,50) title:nil titleColor:nil imageName:@"2.fw_r2_c2" backgroundImageName:nil target:nil selector:nil];
                [imageView addSubview:self.inputButton];
            [self.inputButton addTarget:self action:@selector(inputButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    return self;
}

- (void)inputButtonClick{

    [self.delegate removeGuideView:YES];
}

#warning mark -  根据引导页数量改变
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    CGFloat X = scrollView.contentOffset.x;
    NSInteger pageIndex = X /SCREEN_W;
    NSLog(@"%ld",pageIndex);
    if (pageIndex==1) {
        [self.delegate removeGuideView:YES];
    }
}

#pragma mark -  开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 5; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                //                [self.nextBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //
                //                self.nextBtn.userInteractionEnabled = YES;
                //[self deleteAdvertisement];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.inputButton setTitle:[NSString stringWithFormat:@"跳过(%.2ds)", seconds] forState:UIControlStateNormal];
                //[self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                //self.getMaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
