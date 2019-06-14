//
//  YSJOrderCourseView.m
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJOrderModel.h"
#import "YSJOrderCourseView.h"

@implementation YSJOrderCourseView
{
    UIImageView *_img;
    UILabel *_name;
    UILabel *_introduction;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    _introduction = [[UILabel alloc]init];
    _introduction.backgroundColor = KWhiteColor;
    _introduction.textColor = gray9B9B9B;
    _introduction.font = font(12);
    [self addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        
        make.height.offset(14);
        make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(16);
    _price.textColor = yellowEE9900;
    _price.backgroundColor = [UIColor whiteColor];
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(_introduction.mas_bottom).offset(7);
    }];
    _price.hidden = YES;
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(_img.mas_bottom).offset(25);
    }];
}

-(void)setModel:(YSJOrderModel *)model{
    _model = model;
    if (self.model.pic_url.count!=0) {
        [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,self.model.pic_url[0]]]placeholderImage:[UIImage imageNamed:@"120"]];
    }
    
    _name.text = self.model.title;
    
    _introduction.text = [NSString stringWithFormat:@" %@ | %@",self.model.coursetype,self.model.coursetypes];
    _price.text = [NSString stringWithFormat:@"¥%.2f",self.model.real_amount];
}
@end
