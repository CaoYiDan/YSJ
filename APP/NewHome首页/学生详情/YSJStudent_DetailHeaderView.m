//
//  YSJTeacherHeaderView.m
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJCommonBottomView.h"
#import "YSJStudent_DetailHeaderView.h"
#import "YSJRequimentModel.h"
#import "XHStarRateView.h"
#import "YSJTeacherInfoView.h"
#import "YSJCommonBottomView.h"
@implementation YSJStudent_DetailHeaderView
{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *_dealCount;
    UILabel *pingfen;
    UILabel *_price;
    UILabel *_oldPrice;
    UILabel *_score;
    XHStarRateView *_starRateView;
    UILabel *_location;
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
    _name.text = @"名字";
    _name.backgroundColor = [UIColor whiteColor];
    [self.profileV addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.offset(33);
    }];
    
    CGFloat imgWid = 50;
    CGFloat imgH = 50;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kWindowW-imgWid-kMargin, 20, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 25;
    _img.clipsToBounds = YES;
    [self.profileV addSubview:_img];
    
    
    _price = [[UILabel alloc]init];
    _price.font = font(20);
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = yellowEE9900;
    _price.backgroundColor = KWhiteColor;
    _price.text = @"299";
    [self.profileV addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.top.equalTo(_name.mas_bottom).offset(44);
        //        make.height.offset(30);
    }];
    
   
//
//    UIButton *buyBtn = [[UIButton alloc]init];
//    [buyBtn setTitle:@"查看更多" forState:0];
//    [buyBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
//
//    [buyBtn setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
//    buyBtn.titleLabel.font = font(13);
//    [buyBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
//    [self.profileV addSubview:buyBtn];
//    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-kMargin);
//        make.width.offset(100);
//        make.height.offset(31);
//        make.centerY.equalTo(_price).offset(0);
//    }];
    
    
    YSJCommonBottomView *bottomView = [[YSJCommonBottomView alloc]initWithFrame:CGRectZero withTitle:@[@"上门服务",@"需求种类",@"上课时间"]];
    
    _bottomView = bottomView;
    [self.profileV addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(80);
        make.top.equalTo(_price.mas_bottom).offset(24);
    }];
}

-(void)setModel:(YSJRequimentModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]];
    
    _name.text = model.title;

    [_bottomView setContent2:model.is_at_home?@"接受":@"不接受" content4:model.coursetype content6:model.course_time];

    _price.text = [NSString stringWithFormat:@"¥%@-¥%@",model.lowprice,model.highprice];


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

-(void)moreClick{
    
//    YSJTeacherInfoView *infoView = [[YSJTeacherInfoView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
//    infoView.model = self.model;
//    [[SPCommon getCurrentVC].view addSubview:infoView];
}

@end
