//
//  YSJTeacherCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//


#import "YSJCourseModel.h"

#import "XHStarRateView.h"

#import "YSJTeacherCourseCell.h"

@implementation YSJTeacherCourseCell
{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *renzheng;
    UILabel *_getOrderCount;//接单数量 和评分
    UILabel *_price;
     UILabel *_oldPrice;
    UILabel *_introductionView;
    XHStarRateView *_starRateView;
}

#pragma mark - init

- (void)initUI{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    

    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
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
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 40, 70, 20) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
    _starRateView = starRateView;
    starRateView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:starRateView];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.width.offset(70);
        make.height.offset(20);
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
    _price.textColor = yellowEE9900;
    _price.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.top.equalTo(_teacherType.mas_bottom).offset(5);
//        make.height.offset(30);
    }];
    
    _oldPrice = [[UILabel alloc]init];
    _oldPrice.font = font(12);
    _oldPrice.textAlignment = NSTextAlignmentRight;
    _oldPrice.textColor = gray999999;
    _oldPrice.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_oldPrice];
    [_oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_price.mas_right).offset(10);
        make.centerY.equalTo(_price).offset(0);
//        make.height.offset(30);
    }];
    
    //介绍
    _introductionView = [[UILabel alloc]init];

    _introductionView.textAlignment = NSTextAlignmentCenter;
    _introductionView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_introductionView];
    [_introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(30);
        make.width.offset(200); make.top.equalTo(_price.mas_bottom).offset(5);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url2[0]]]placeholderImage:[UIImage imageNamed:@"120"]];
//    _distance.text = [SPCommon changeKm:model.distance];
    [_starRateView setStarLeave:model.reputation];
    _name.text = model.title;
    _teacherType.text = [NSString stringWithFormat:@"%@ | %@",model.coursetype,model.coursetypes];

    _getOrderCount.text = [NSString stringWithFormat:@"%.1f分   已售%@",model.reputation ,model.dealcount];
    
    _price.text = [NSString stringWithFormat:@"¥%@",model.price];

    _oldPrice.text = [NSString stringWithFormat:@"¥%@",model.old_price];;
    
    [_oldPrice addMiddleLine];
    
    NSArray *arr = [model.labels componentsSeparatedByString:@","];
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
        [_introductionView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i*80);
            make.width.offset(70);
            make.height.offset(20);
            make.top.offset(5);
        }];
        i++;
    }
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
