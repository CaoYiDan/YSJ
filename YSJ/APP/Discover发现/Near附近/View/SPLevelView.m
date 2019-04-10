//
//  SPLevelView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLevelView.h"
#import "SPLevelModel.h"

@implementation SPLevelView
{
    UIScrollView *_scrollView;
    
    NSMutableArray *_levelArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self sUI];
        [self load];
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view.tag==11) {
        return YES;
    }
    
    return  NO;
}

-(void)load{
    
  [[HttpRequest sharedClient]httpRequestGET:kUrlGetAllLevel parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
      _levelArr = @[].mutableCopy;
      _levelArr = [SPLevelModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
      [self sLevleBtn];
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
  }];
}

-(void)sLevleBtn{
    CGFloat margin =  20;
    CGFloat wid = (_scrollView.frameWidth
                   -60)/2;
    for (int i=0; i<_levelArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(margin+i%2*(margin+wid), 10+i/2*(10+40), wid, 30)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(levelClick:) forControlEvents:UIControlEventTouchDown];
        [btn setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"] forState:0];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        btn.titleLabel.font = kFontNormal;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"] forState:UIControlStateSelected];
        SPLevelModel *model  = _levelArr[i];
        
        [btn setTitle:model.name forState:0];
        [_scrollView addSubview:btn];
        
    }
    [_scrollView setContentSize:CGSizeMake(0, 50*_levelArr.count/2+_levelArr.count%2*10+20)];
}

-(void)levelClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
}

-(void)sUI{
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(30, 40, SCREEN_W-60, 385)] ;
    base.layer.cornerRadius= 5;
    base.clipsToBounds = YES;
    base.center = self.center;
    base.layer.borderColor = MyBlueColor.CGColor;
    base.layer.borderWidth = 1;
    base.backgroundColor = [UIColor whiteColor];
    [self addSubview:base];
    
    UIButton *shat = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-20, 5, 40, 40)];
    [shat setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    [shat addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    [base addSubview:shat];
    
    _scrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, base.frameWidth, base.frameHeight-100)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [base addSubview:_scrollView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, base.frameHeight-50 , SCREEN_W, 1)];
    line.backgroundColor = GRAYCOLOR;
    [base addSubview:line];
    
    UIButton *ok = [[UIButton alloc]initWithFrame:CGRectMake(base.frameWidth/2-20,base.frameHeight-45 , 40, 40)];
    [ok setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
    [ok addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchDown];
    [base addSubview:ok];

}

//关闭
-(void)shat{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }];
}

//点击 确认按钮 退下
-(void)ok{
    
    NSMutableArray *chooseArr = [[NSMutableArray alloc]init];
    
    for (UIView *vi  in _scrollView.subviews) {
        if ([vi isKindOfClass:[UIButton class]]) {
            UIButton *btn  = (UIButton *)vi;
            if (btn.isSelected) {
                SPLevelModel *model = _levelArr[btn.tag];
                [chooseArr addObject:model];
            }
        }
    }
    
    !self.levelBlock?:self.levelBlock(chooseArr);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }];
}
@end
