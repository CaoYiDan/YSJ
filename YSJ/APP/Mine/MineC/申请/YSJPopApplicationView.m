//
//  YSJPopApplicationView.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.


#import "YSJApplication_firstVC.h"
#import "YSJPopApplicationView.h"
#import "YSJApplicationCompany_FirstVC.h"
@implementation YSJPopApplicationView

{
    UIImageView *_img;
    
}
- (void)initUI{
    
    CGFloat imgWid = (kWindowW-50);
    CGFloat imgH = imgWid*(1176.0/750.0);
    
    
    _img =  [[UIImageView alloc]init];
    _img.backgroundColor = [UIColor clearColor];
   
  
    _img.contentMode = UIViewContentModeScaleToFill;
    _img.layer.cornerRadius = 8;
    _img.clipsToBounds = YES;
    _img.userInteractionEnabled = YES;
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.offset(imgWid);
        make.height.offset(imgH);
       
    }];
    [self setBottomBtn];
    [self setCloseButton];
}

-(void)setBottomBtn{
    
    UIButton *iKnowBtn = [[UIButton alloc]init];
    iKnowBtn.backgroundColor = KMainColor;
    [iKnowBtn setTitle:@"我已知晓,去申请" forState:0];
    iKnowBtn.layer.cornerRadius = 5;
    iKnowBtn.clipsToBounds = YES;
    [iKnowBtn addTarget:self action:@selector(applicationClick) forControlEvents:UIControlEventTouchDown];
    [_img addSubview:iKnowBtn];
    [iKnowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.height.offset(50);
        make.bottom.offset(-45);
    }];
}

-(void)setCloseButton{
    UIButton *shatBtn = [[UIButton alloc]init];
    [shatBtn setImage:[UIImage imageNamed:@"close"] forState:0];
    [shatBtn addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    [self addSubview:shatBtn];
    [shatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(40);
        make.height.offset(40);
        make.top.equalTo(_img.mas_bottom).offset(-15);
    }];
}

-(void)applicationClick{
    
    //退出主界面
    [UIView animateWithDuration:0.4 animations:^{
        self.originX= (SCREEN_H+100);
    }completion:^(BOOL finished) {
        
    }];
    
    //私教申请
    if (self.type==0) {
        YSJApplication_FirstVC *vc = [[YSJApplication_FirstVC alloc]init];
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else{
        
    //机构申请
    YSJApplicationCompany_FirstVC *vc = [[YSJApplicationCompany_FirstVC alloc]init];
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)setType:(int)type{
    _type = type;
    if (self.type == 0) {
        _img.image  = [UIImage imageNamed:@"pop"];
    }else{
        _img.image  = [UIImage imageNamed:@"jigou_shenqing"];
    }
}
@end
