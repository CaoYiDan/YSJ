//
//  YSJTeacherCell.m
//  SmallPig

//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.

//  YSJHomeTableViewCell.m
//  SmallPig

#import "YSJMyPublishForCompanyCourseCell.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJCourseModel.h"

@interface YSJMyPublishForCompanyCourseCell ()<YSJBottomMoreButtonViewDelegate>

@end

@implementation YSJMyPublishForCompanyCourseCell

{
    UIImageView *_img;
    
    UILabel *_name;
    
    UILabel *xuqiu;
    
    UILabel *_price;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
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
    
    UIImageView *xuImg =[[UIImageView alloc]init];
    xuImg.image = [UIImage imageNamed:@"xu"];
    [self addSubview:xuImg];
    [xuImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.width.offset(14); make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    xuqiu = [[UILabel alloc]init];
    xuqiu.backgroundColor = KWhiteColor;
    xuqiu.textColor = gray9B9B9B;
    xuqiu.font = font(12);
    [self addSubview:xuqiu];
    [xuqiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xuImg.mas_right).offset(5);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(16);
    _price.textColor = yellowEE9900;
    _price.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(xuqiu.mas_bottom).offset(7);
    }];
    
    YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
    bottomView.btnTextArr = @[@"删除",@"查看"];
    [self.contentView addSubview:bottomView];
    bottomView.delegate = self;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(45+6);
        make.bottom.offset(0);
    }];
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url2[0]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    _name.text = model.times;
    
    xuqiu.text = [NSString stringWithFormat:@" %@",model.title];
    _price.text = [NSString stringWithFormat:@"¥%@/h",model.price];
}
/**
 底部点击按钮事件
 
 @param index 从右向左数（0，1....）
 */
-(void)bottomMoreButtonViewClickWithIndex:(NSInteger)index andTitle:(NSString *)title{
    NSLog(@"fds");
}
@end
