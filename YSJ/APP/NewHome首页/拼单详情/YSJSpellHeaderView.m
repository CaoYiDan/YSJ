//
//  YSJTeacherHeaderView.m
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJSpellHeaderView.h"
#import "YSJCourseModel.h"
#import "XHStarRateView.h"
#import "YSJCompanyInfoView.h"
#import "YSJCommonBottomView.h"
#import "YSJTagLabel.h"
#import "YSJPayForOrderVC.h"
@implementation YSJSpellHeaderView
{

    UILabel *_name;
    UILabel *_dealCount;
    YSJTagLabel*_tagsLabel;
    UILabel *_describe;
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
    //    _name.backgroundColor = [UIColor whiteColor];
    [self.profileV addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.offset(33);
    }];
    
    _tagsLabel = [[YSJTagLabel alloc]init];
    [self.profileV addSubview:_tagsLabel];
    [_tagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    

    UIImageView *pinImg = [[UIImageView alloc]init];
    pinImg.image = [UIImage imageNamed:@"拼"];
    [self.profileV addSubview:pinImg];
    [pinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        make.width.offset(14);
        make.height.offset(14);
        make.top.equalTo(_name.mas_bottom).offset(40);
    }];
    
    _describe = [[UILabel alloc]init];
    _describe.font = font(14);
    _describe.text = @"";
    _describe.textAlignment = NSTextAlignmentRight;
    _describe.textColor = black666666;
    _describe.backgroundColor = KWhiteColor;
    [self.profileV addSubview:_describe];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pinImg.mas_right).offset(5);
        make.height.offset(20);
        make.centerY.equalTo(pinImg).offset(0);
    }];
    
    UIButton *more = [[UIButton alloc]init];
    [more setTitle:@"立即拼单" forState:0];
    [more setTitleColor:KWhiteColor forState:UIControlStateNormal];
    
    [more setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
    more.titleLabel.font = font(13);
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
    [self.profileV addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(100);
        make.height.offset(31);
        make.centerY.equalTo(_describe).offset(0);
    }];
    
    _dealCount = [[UILabel alloc]init];
    _dealCount.font = font(12);
    _dealCount.text = @"";
    _dealCount.textAlignment = NSTextAlignmentRight;
    _dealCount.textColor = gray999999;
    _dealCount.backgroundColor = KWhiteColor;
    [self.profileV addSubview:_dealCount];
    [_dealCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(20);
        make.centerY.equalTo(_name).offset(0);
    }];
    
    YSJCommonBottomView *bottomView = [[YSJCommonBottomView alloc]initWithFrame:CGRectZero withTitle:@[@"类别",@"适合人群",@"上课人数"]];
    [self.profileV addSubview:bottomView];
    _bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(80);
        make.top.equalTo(_describe.mas_bottom).offset(15);
    }];
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;

    _name.text = model.title;
    
    _dealCount.text = [NSString stringWithFormat:@"已售%@",model.dealcount];
    
    _describe.text = [NSString stringWithFormat:@"%d人拼团价%@元",model.min_user,model.multi_price];
    
    [_bottomView setContent2:model.coursetype content4:[NSString stringWithFormat:@"%@",model.suitable_range] content6:[NSString stringWithFormat:@"%u-%ld",model.min_user,(long)model.max_user]];
    
}

-(void)more{
    
    YSJPayForOrderVC *vc = [[YSJPayForOrderVC alloc]init];
    vc.model = self.model;
    vc.payForType = YSJPayForStartPinDan;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    
}

@end
