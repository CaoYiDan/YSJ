//
//  YSJTeacherHeaderView.m
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJCompanyCourse_FreeHeaderView.h"
#import "YSJCourseModel.h"
#import "XHStarRateView.h"
#import "YSJCompanyInfoView.h"
#import "YSJCommonBottomView.h"

@implementation YSJCompanyCourse_FreeHeaderView
{
    UIImageView *_img;
   
    UILabel *_name;
   
    UIButton *_dealCount;
   
    UIButton *_buyBtn;
    
    YSJCommonBottomView *_bottomView;
}

#pragma mark - init

- (void)setProfileView{
    
    self.profileV.frameHeight = profileHeight;
    
    //设置左上角和右上角 为圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.profileV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.profileV.bounds;
    maskLayer.path = maskPath.CGPath;
    self.profileV.layer.mask = maskLayer;
    
    _name = [[UILabel alloc]init];
    _name.font = Font(20);
    _name.backgroundColor = [UIColor whiteColor];
    [self.profileV addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.offset(40);
    }];
    
    _dealCount = [[UIButton alloc]init];
    _dealCount.backgroundColor = KWhiteColor;
    _dealCount.layer.cornerRadius = 4;
    _dealCount.clipsToBounds = YES;
    [_dealCount setTitleColor:gray9B9B9B forState:UIControlStateNormal];
    //    [_dealCount setImage:[UIImage imageNamed:@"ic_verified"] forState:0];
    _dealCount.titleLabel.font = font(13);
    [_dealCount setTitle:@"12" forState:0];
    [self.profileV addSubview:_dealCount];
    [_dealCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.top.equalTo(_name.mas_bottom).offset(44);
    }];
    
   
    UIButton *buyBtn = [[UIButton alloc]init];
    
    [buyBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    _buyBtn = buyBtn;
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
    buyBtn.titleLabel.font = font(13);
    [buyBtn setTitle:@"立即预约" forState:0];
    [buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchDown];
    [self.profileV addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(100);
        make.height.offset(31);
        make.centerY.equalTo(_dealCount).offset(0);
    }];
    
    
    YSJCommonBottomView *bottomView = [[YSJCommonBottomView alloc]initWithFrame:CGRectZero withTitle:@[@"类别",@"适合人群",@"上课人数"]];
    
    _bottomView = bottomView;
    [self.profileV addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(80);
        make.top.equalTo(_dealCount.mas_bottom).offset(24);
    }];
    
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;
    
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url2[0]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    [_dealCount setTitle:[NSString stringWithFormat:@"%@人预约过",model.dealcount] forState:0];
    
    _name.text = model.title;
    
    
    [_bottomView setContent2:model.coursetypes content4:[NSString stringWithFormat:@"%@",model.suitable_range] content6:[NSString stringWithFormat:@"%ld-%ld",(long)model.min_user,model.max_user]];
    
    NSArray *arr = [model.lables componentsSeparatedByString:@","];
    int i = 0 ;
    for (NSString *labelStr in arr) {
        if (i>2) {
            return;
        }
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hexColor:@"E8541E"];
        label.font = Font(12);
        label.layer.cornerRadius = 8;
        label.clipsToBounds = YES;
        label.text = labelStr;
        label.backgroundColor = RGBA(253, 135, 197, 0.08);
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i*80+kMargin);
            make.width.offset(70);
            make.height.offset(20);
            make.top.equalTo(_name.mas_bottom).offset(15);
        }];
        i++;
    }
}

-(void)buyClick{
    
}

@end
