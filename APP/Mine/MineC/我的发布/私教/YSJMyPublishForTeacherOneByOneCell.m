//
//  YSJTeacherCell.m
//  SmallPig

//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.

//  YSJHomeTableViewCell.m
//  SmallPig

#import "YSJMyPublishForTeacherOneByOneCell.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJCourseModel.h"

@interface YSJMyPublishForTeacherOneByOneCell ()<YSJBottomMoreButtonViewDelegate>

@end

@implementation YSJMyPublishForTeacherOneByOneCell

{
    UIImageView *_img;
    
    UILabel *_name;
    
    UILabel *xuqiu;
    
    UILabel *_price;
    
    UILabel *_oldPrice;
    
    YSJBottomMoreButtonView *_bottomBtnView;
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
    _img.backgroundColor = grayF2F2F2;
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
        make.height.offset(16);
        make.top.equalTo(_img).offset(0);
    }];
    
    xuqiu = [[UILabel alloc]init];
    xuqiu.backgroundColor = KWhiteColor;
    xuqiu.textColor = gray9B9B9B;
    xuqiu.font = font(12);
    [self addSubview:xuqiu];
    [xuqiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.right.offset(-kMargin);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(18);
    _price.textColor = yellowEE9900;
    _price.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(xuqiu.mas_bottom).offset(7);
    }];
    
//    _oldPrice = [[UILabel alloc]init];
//    _oldPrice.font = font(12);
//    _oldPrice.textColor = gray999999;
//    _oldPrice.backgroundColor = KWhiteColor;
//    [self.contentView addSubview:_oldPrice];
//    [_oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(150);
//         make.centerY.equalTo(_price).offset(0);
//            make.height.offset(30);
//    }];
    
    YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
    bottomView.btnTextArr = @[@"删除",@"查看"];
    [self.contentView addSubview:bottomView];
    bottomView.delegate = self;
    _bottomBtnView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(45+6);
        make.bottom.offset(0);
    }];
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;
    
    if (model.pic_url2.count>0) {
        
         [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url2[0]]]placeholderImage:[UIImage imageNamed:@"120"]];
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url2[0]]);
    _name.text = model.title;
    
    xuqiu.text = [NSString stringWithFormat:@"%@ | %@ ",model.coursetype,model.coursetypes];
    _price.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    _oldPrice.text = [NSString stringWithFormat:@"¥%@",model.old_price];
    [_oldPrice addMiddleLine];
    
    _bottomBtnView.courseModel = model;
    _bottomBtnView.orderType = OrderTypePublish;
}
@end
