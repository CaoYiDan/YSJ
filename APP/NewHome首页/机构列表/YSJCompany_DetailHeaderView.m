//
//  YSJTeacherHeaderView.m
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJCompany_DetailHeaderView.h"
#import "YSJCompanysModel.h"
#import "XHStarRateView.h"
#import "YSJCompanyInfoView.h"
#import "YSJCommonBottomView.h"
#import "YSJGBModel.h"
#import "YSJShowHongBaoView.h"

@implementation YSJCompany_DetailHeaderView
{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    
    UILabel *pingfen;
    UILabel *_price;
    YSJCommonBottomView *_bottomView;
    UILabel *_score;
    XHStarRateView *_starRateView;
    UILabel *_location;
    UILabel *_companyType;//上门服务
    UILabel *_studentCount;//学生数
    UILabel *_getCount;//接单量
    
    UIImageView *_hbImg;
    UILabel *_hbPrice;
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
    
    CGFloat imgWid = 68;
    CGFloat imgH = 49;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 33, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 5;
    _img.clipsToBounds = YES;
    [self.profileV addSubview:_img];
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(20);
    //    _name.backgroundColor = [UIColor whiteColor];
    [self.profileV addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    //评分
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(kMargin *2+imgWid, 60, 70, 20) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
    _starRateView = starRateView;
    starRateView.backgroundColor = KWhiteColor;
    
    [self.profileV addSubview:starRateView];
    //    [starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_name).offset(0);
    //        make.width.offset(70);
    //         make.top.equalTo(_name.mas_bottom).offset(10);
    //    }];
    
    //评分label
    _score = [[UILabel alloc]init];
    _score.font = font(14);
    _score.textAlignment = NSTextAlignmentCenter;
    _score.textColor = gray999999;
    _score.backgroundColor = KWhiteColor;
    [self.profileV addSubview:_score];
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starRateView.mas_right).offset(5);
        make.centerY.equalTo(_starRateView).offset(0);
    }];
    
    UIImageView *hongBao = [[UIImageView alloc]init];
    hongBao.userInteractionEnabled = YES;
    hongBao.image = [UIImage imageNamed:@"个人-领取"];
    _hbImg = hongBao;
    [self.profileV addSubview:hongBao];
    [hongBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.width.offset(75);
        make.height.offset(22);
        make.top.equalTo(_score.mas_bottom).offset(10);
    }];
    
    
    UILabel *hongBPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 22)];
    //    hongBPrice.userInteractionEnabled = NO;
    hongBPrice.font = font(12);
    hongBPrice.textColor = KWhiteColor;
    _hbPrice = hongBPrice;
    hongBPrice.textAlignment = NSTextAlignmentCenter;
    [hongBao addSubview:hongBPrice];
    
    UILabel *hongBLing = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 30, 22)];
    //    hongBLing.userInteractionEnabled = NO;
    hongBLing.font = font(12);
    hongBLing.textColor = KWhiteColor;
    hongBLing.text = @"领";
    hongBLing.textAlignment = NSTextAlignmentCenter;
    [hongBao addSubview:hongBLing];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0,0,75,22);
    btn.backgroundColor = [UIColor clearColor];
    [hongBao addSubview:btn];
    [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        YSJShowHongBaoView*infoView = [[YSJShowHongBaoView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        infoView.model = self.model;
        [[SPCommon getCurrentVC].view addSubview:infoView];
    }];
    
    [hongBao addSubview:btn];
    
    UIButton *more = [[UIButton alloc]init];
    [more setTitle:@"查看更多" forState:0];
    [more setTitleColor:KWhiteColor forState:UIControlStateNormal];
    
    [more setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
    more.titleLabel.font = font(13);
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
    [self.profileV addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(100);
        make.height.offset(31);
        make.centerY.equalTo(_name).offset(0);
    }];
    
    
    _location = [[UILabel alloc]init];
    _location.font = font(13);
    _location.textColor = [UIColor hexColor:@"666666"];
    _location.numberOfLines = 0;
    _location.text = @"地址";
    _location.backgroundColor = KWhiteColor;
    [self.profileV addSubview:_location];
    [_location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.width.offset(kWindowW-30-kMargin-50);
        make.top.equalTo(hongBao.mas_bottom).offset(13);
    }];
    
    UIImageView *locationImg = [[UIImageView alloc]init];
    locationImg.image = [UIImage imageNamed:@"dizhi-2"];
    [self.profileV addSubview:locationImg];
    [locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img);
        make.width.offset(13);
        make.height.offset(16);
        make.centerY.equalTo(_location).offset(0);
    }];
    
    _distance = [[UILabel alloc]init];
    _distance.font = font(12);
    _distance.text = @"df";
    _distance.textAlignment = NSTextAlignmentRight;
    _distance.textColor = gray999999;
    _distance.backgroundColor = KWhiteColor;
    [self.profileV addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(20);
        make.centerY.equalTo(_location).offset(0);
    }];
    
    YSJCommonBottomView *bottomView = [[YSJCommonBottomView alloc]initWithFrame:CGRectZero withTitle:@[@"机构类型",@"接单量",@"学生数"]];
    [self.profileV addSubview:bottomView];
    _bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(80);
        make.top.equalTo(_location.mas_bottom).offset(15);
    }];
}

-(void)setModel:(YSJCompanysModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.venue_pic]]placeholderImage:[UIImage imageNamed:@"120"]];
    
    _name.text = model.name;
    
    _score.text = [NSString stringWithFormat:@"%.1f 分",model.reputation];
    
    [_starRateView setStarLeave:model.reputation];
    
    _distance.text = [NSString stringWithFormat:@"%ukm",model.distance];
    
    if (_model.red_packet.count==0) {
        
        _hbImg.hidden = YES;
        
    }else{
        
        YSJGBModel *hBModel = _model.red_packet[0];
        
        _hbPrice.text = [NSString stringWithFormat:@"¥%@",hBModel.amount];
    }
    
    
    _location.text = model.address;
    
    [_bottomView setContent2:model.sale_items content4:[NSString stringWithFormat:@"%u",model.dealcount] content6:[NSString stringWithFormat:@"%u",model.fans]];
    
    
}

-(void)more{
    
    YSJCompanyInfoView *infoView = [[YSJCompanyInfoView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    infoView.model = self.model;
    [[SPCommon getCurrentVC].view addSubview:infoView];
}

@end
