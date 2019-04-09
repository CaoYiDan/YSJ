//
//  YSJTeacherCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//
//
//  SPSelectionCollectionCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "YSJRequimentCell.h"

#import "YSJRequimentModel.h"

@implementation YSJRequimentCell

{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_introduction;
    UIButton *xuqiu;
    UILabel *_price;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    CGFloat imgWid = self.frameWidth;
    CGFloat imgH = 83;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _distance = [[UILabel alloc]initWithFrame:CGRectMake(_img.frameWidth-45, 10,40, 16)];
    _distance.font = Font(11);
    _distance.layer.cornerRadius = 4;
    _distance.clipsToBounds = YES;
    _distance.textColor = KWhiteColor;
    _distance.textAlignment = NSTextAlignmentCenter;
    _distance.backgroundColor = RGBA(0, 0, 0, 0.2);
    [_img addSubview:_distance];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+17, imgWid, 20)];
    _name.font = Font(15);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+40, imgWid, 20)];
    _introduction.font = font(11);
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
    //需求
    xuqiu = [[UIButton alloc]init];
    xuqiu.backgroundColor = KWhiteColor;
    xuqiu.layer.cornerRadius = 4;
    xuqiu.clipsToBounds = YES;
    [xuqiu setTitleColor:gray9B9B9B forState:UIControlStateNormal];
    [xuqiu setImage:[UIImage imageNamed:@"xu"] forState:0];
    xuqiu.titleLabel.font = font(12);
    [self addSubview:xuqiu];
    [xuqiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.height.offset(20);
        make.top.equalTo(_introduction.mas_bottom).offset(8);
    }];
    
//    _price = [[UILabel alloc]initWithFrame:CGRectMake(50, imgH+70, 60, 20)];
//    _price.font = font(11);
//    _price.textAlignment = NSTextAlignmentCenter;
//    _price.textColor = yellowEE9900;
//    _price.backgroundColor = KWhiteColor;
//    [self.contentView addSubview:_price];
}

-(void)setModel:(YSJRequimentModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    _distance.text = [SPCommon changeKm:model.distance];
    _name.text = model.nickname;
     _introduction.text = [NSString stringWithFormat:@"%@ | %@ ",model.coursetype,model.coursetypes];
    [xuqiu setTitle:[NSString stringWithFormat:@" %@",model.title] forState:0];
    
//    _price.text = [NSString stringWithFormat:@"¥%u起",model.price];
    
    
    //    xuqiu.selected = userModel.gender;
    //
    //    [_constellation setTitle:model.realname forState:0];
}

@end
