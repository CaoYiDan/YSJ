//
//  YSJHomeWorkTypeListCell.m
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJSaiShiCell.h"
#import "YSJHuoDongModel.h"

@implementation YSJSaiShiCell
{
    UILabel *_title;
    UILabel *_name;
    UILabel *_introduction;
    UILabel *_time;
    UILabel *_time2;
    UIImageView *_icon;
    UIImageView *_img;
}

- (void)initUI{
   
    UIView *base = [[UIView alloc]init];
    base.backgroundColor = KWhiteColor;
    [self.contentView addSubview:base];
    base.layer.shadowOffset = CGSizeMake(1, 1);
    base.layer.shadowOpacity = 0.2;
    base.layer.shadowColor = [UIColor hexColor:@"27347d"].CGColor;
    base.layer.cornerRadius = 5;
    [base mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(UIEdgeInsetsMake(12, 12, 12, 12));
    }];
    
    
    _img =  [[UIImageView alloc]init];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.clipsToBounds = YES;
    _img.image = [UIImage imageNamed:@"120"];
    [base addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(182);
        make.top.offset(0);
    }];
    
    _icon =  [[UIImageView alloc]init];
    _icon.backgroundColor = grayF2F2F2;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.clipsToBounds = YES;
    _icon.layer.cornerRadius = 15;
    _icon.image = [UIImage imageNamed:@"120"];
    [_img addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.width.offset(30);
        make.bottom.offset(-29);
     }];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(13);
//    _name.backgroundColor = RGBA(0, 0, 0, 0.2);
    _name.text = @"senfdjsdksd";
    _name.textColor = KWhiteColor;
    [_img addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(_icon.mas_right).offset(10);
        make.height.offset(30);
        make.bottom.offset(-29);
    }];
    
    _title = [[UILabel alloc]init];
    _title.font = Font(18);
    _title.backgroundColor = [UIColor whiteColor];
    _title.text = @"大煞风景几点开始";
    _title.numberOfLines = 2;
    _title.textColor = KBlack333333;
    [base addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(50);
        make.right.offset(-kMargin); make.top.equalTo(_img.mas_bottom).offset(15);
    }];
    
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(13);
    _introduction.textColor = black666666;
    _introduction.backgroundColor = [UIColor whiteColor];
    _introduction.numberOfLines = 2;
    _introduction.text = @"haole ，怎么了";
    [base addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(50);
        make.right.offset(-kMargin); make.top.equalTo(_title.mas_bottom).offset(10);
    }];
    
    
   
    _time = [[UILabel alloc]init];
    _time.font = font(11);
    _time.textColor = gray999999;
    _time.text = @"2019.08.09";
    [base addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(30);
        make.top.equalTo(_introduction.mas_bottom).offset(10);
    }];
   
}

-(void)get{
    
}


-(void)setModel:(YSJHuoDongModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.match_pic]]placeholderImage:[UIImage imageNamed:@"120"]];
    _title.text = model.match_title;
    _introduction.text = model.match_intorduction;
    _time.text = [NSString stringWithFormat:@"%@   %@",[SPCommon getTimeFromTimestamp:[model.match_time integerValue]],model.match_place];
}

@end
