//
//  SPDyDetailBottomView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDyDetailBottomView.h"

@implementation SPDyDetailBottomView
{
    UIButton *_share;
    UIButton *_evaluate;
    UIButton *_prasize;
    
    NSArray *_imgArr;
}
- (instancetype)initWithFrame:(CGRect)frame withCode:(NSString *)code
{
    self = [super initWithFrame:frame];
    if (self) {
        self.feedCode = code;
        self.backgroundColor = [UIColor whiteColor];
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    _imgArr = @[@"d_share",@"d_evaluate",@"d_no_zan"];
    
    for (int i=0; i<3; i++) {
        CGFloat wid = SCREEN_W/3;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*wid, 5, wid, 40)];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setImage:[UIImage imageNamed:_imgArr[i]] forState:0];
        btn.tag = i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        if (i ==0) {
            _share = btn;
        }else if (i == 1){
            _evaluate = btn;
        }else if (i==2){
            _prasize = btn;
            [btn setImage:[UIImage imageNamed:@"d_have_zan"] forState:UIControlStateSelected];
        }
        
        [self addSubview:btn];
    }
}

//设置点赞 评价数量
-(void)setPrasizedCount:(NSInteger)prasizeNum evaluateNum:(NSInteger)evaluateNum ifPrasized:(BOOL)prasized{
    [_prasize setTitle:[NSString stringWithFormat:@" %ld",(long)prasizeNum] forState:0];
    [_evaluate setTitle:[NSString stringWithFormat:@" %ld",(long)evaluateNum] forState:0];
    _prasize.selected = prasized;
    
}

//点击事件
-(void)click:(UIButton *)btn{
    
    if (![SPCommon gotoLogin]) {
        if (btn.tag == 2) {//赞
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:self.feedCode forKey:@"bePraisedCode"];
            [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
            [dict setObject:@"FEED" forKey:@"type"];
            NSString *url = @"";
            if (btn.isSelected) {
                url = kUrlDeletePraise;//取消点赞
            }else{
                url = kUrlAddPraise;//添加点赞
            }
            
            [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                NSLog(@"%@",responseObject);
                
                btn.selected = !btn.isSelected;
                
                //需要实现的帧动画,这里根据自己需求改动
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
                animation.keyPath = @"transform.scale";
                animation.values = @[@1.0,@1.1,@0.9,@1.0];
                animation.duration = 0.3;
                animation.calculationMode = kCAAnimationCubic;
                //添加动画
                [btn.layer addAnimation:animation forKey:nil];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
        else if (btn.tag==0){


        }else if (btn.tag ==1){


        }
        
        !self.toolClick?:self.toolClick(btn.tag);
    }
}

@end
