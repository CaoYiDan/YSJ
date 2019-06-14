//
//  YSJTeacherHeaderView.m
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJCommonBottomView.h"
#import "YSJTeacherHeaderView.h"
#import "YSJTeacherModel.h"
#import "XHStarRateView.h"
#import "YSJTeacherInfoView.h"

@implementation YSJTeacherHeaderView
{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *renzheng;
    UILabel *pingfen;
    UILabel *_price;
 
    UILabel *_introduction;
    XHStarRateView *_starRateView;
    
    UILabel *_suportHomeService;//上门服务
    UILabel *_studentCount;//学生数
    UILabel *_getCount;//接单量
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - init

- (void)initUI{
   
    //设置左上角和右上角 为圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CGFloat imgWid = 68;
    CGFloat imgH = 49;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 33, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 5;
    _img.clipsToBounds = YES;
    [self addSubview:_img];
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(20);
//    _name.backgroundColor = [UIColor whiteColor];
    [self addSubview:_name];
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
    

    //介绍
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(14);
    _introduction.numberOfLines = 3;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = KWhiteColor;
    [self addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.right.offset(-kMargin); make.top.equalTo(_name.mas_bottom).offset(12);
    }];
    
    
    UIButton *more = [[UIButton alloc]init];
    [more setTitle:@"查看更多" forState:0];
    [more setTitleColor:KWhiteColor forState:UIControlStateNormal];
    
    [more setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
    more.titleLabel.font = font(13);
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
    [self addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(100);
        make.height.offset(30);
        make.centerY.equalTo(_name).offset(0);
    }];
    
    YSJCommonBottomView *bottomView = [[YSJCommonBottomView alloc]initWithFrame:CGRectZero withTitle:@[@"上门服务",@"接单量",@"学生数"]];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(80);
        make.top.equalTo(_img.mas_bottom).offset(31);
    }];
    
 
}

-(void)setModel:(YSJTeacherModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"120"]];
  
    _name.text = model.realname;
   
    _introduction.text = [NSString stringWithFormat:@"%@ %@ ",model.sale_item,model.sex];
    
    [renzheng setTitle:[NSString stringWithFormat:@"%d",model.reputation] forState:0];
    

    pingfen.text = [NSString stringWithFormat:@"%u分",model.reputation];
    
    [_starRateView setStarLeave:model.reputation];
    
    [_bottomView setContent2:[NSString stringWithFormat:@"%@",model.is_at_home?@"支持":@"不支持"] content4:[NSString stringWithFormat:@"%u",model.dealcount] content6:[NSString stringWithFormat:@"%u",model.fans]];
//    [_bottomView set:@"fdf" a:@"fdfd" a:@"fdfd"];
}

-(void)more{
    
    YSJTeacherInfoView *infoView = [[YSJTeacherInfoView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    infoView.model = self.model;
    [[SPCommon getCurrentVC].view addSubview:infoView];
}

@end
