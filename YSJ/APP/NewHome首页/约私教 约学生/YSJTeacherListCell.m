//
//  YSJTeacherCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//


#import "YSJTeacherModel.h"

#import "XHStarRateView.h"

#import "YSJTeacherListCell.h"

@implementation YSJTeacherListCell

{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *renzheng;
    UILabel *_getOrderCount;//接单数量 和评分
    UILabel *_price;
    UILabel *_introduction;
    XHStarRateView *_starRateView;
    
    YSJTagsView *_introductionView;
}

#pragma mark - init

- (void)initUI{
  
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(16);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    renzheng = [[UIButton alloc]init];
    renzheng.backgroundColor = KWhiteColor;
    renzheng.layer.cornerRadius = 4;
    renzheng.clipsToBounds = YES;
    [renzheng setTitleColor:gray9B9B9B forState:UIControlStateNormal];
    [renzheng setImage:[UIImage imageNamed:@"ic_verified"] forState:0];
    renzheng.titleLabel.font = font(12);
    [self addSubview:renzheng];
    [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_right).offset(5);
        make.width.offset(12);
        make.height.offset(14);
        make.centerY.equalTo(_name);
    }];
    
    _distance = [[UILabel alloc]init];
    _distance.font = Font(12);
    _distance.textColor = gray999999;
    _distance.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_name);
        make.height.offset(30);
    }];
    
    //评分
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 40, 70, 30) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
    _starRateView = starRateView;
    starRateView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:starRateView];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.width.offset(70);
        make.height.offset(30);
        make.top.equalTo(_name.mas_bottom).offset(6);
    }];
    
    _getOrderCount = [[UILabel alloc]init];
    _getOrderCount.font = font(12);
    _getOrderCount.textAlignment = NSTextAlignmentCenter;
    _getOrderCount.textColor = gray999999;
    _getOrderCount.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_getOrderCount];
    [_getOrderCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starRateView.mas_right).offset(5);
        make.height.offset(20);
        make.centerY.equalTo(_starRateView);
    }];
    
    //上课类型
    _teacherType = [[UILabel alloc]init];
    _teacherType.font = font(12);
    _teacherType.textAlignment = NSTextAlignmentCenter;
    _teacherType.textColor = gray999999;
    _teacherType.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_teacherType];
    [_teacherType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.top.equalTo(_starRateView.mas_bottom).offset(7);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(20);
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = [UIColor hexColor:@"FE8600"];
    _price.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_teacherType);
        make.height.offset(30);
    }];
    
    //介绍
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(12);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
    make.top.equalTo(_starRateView.mas_bottom).offset(7);
    }];
    
    //介绍
    _introductionView = [[YSJTagsView alloc]init];
    [self.contentView addSubview:_introductionView];
    [_introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(30);
        make.top.equalTo(_introduction.mas_bottom).offset(5);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

-(void)setModel:(YSJTeacherModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    _distance.text = [SPCommon changeKm:model.distance];
    [_starRateView setStarLeave:model.reputation];
    _name.text = model.realname;
    _teacherType.text = model.sale_item;
    [renzheng setTitle:[NSString stringWithFormat:@"%.1f",model.reputation] forState:0];
    _getOrderCount.text = [NSString stringWithFormat:@"%.1f分   已售%u",model.reputation,model.dealcount];
    
    _price.text = [NSString stringWithFormat:@"¥%u 起",model.price];
    [_price setAttributeTextWithString:_price.text range:NSMakeRange(_price.text.length-1, 1) WithColour:gray999999 andFont:12];
     _introduction.text = [NSString stringWithFormat:@"%@ | %@ | %@",model.coursetype,model.coursetypes,model.sex];
    
   _introductionView.tagsArr = [model.lables componentsSeparatedByString:@","];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView *vi in _introductionView.subviews)
    {
        [vi removeFromSuperview];
    }
}
@end
