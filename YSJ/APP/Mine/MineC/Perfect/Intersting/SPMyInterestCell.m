//
//  SPMyInterestCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/9.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyInterestCell.h"
#import "SPKungFuModel.h"
#import "SPCommon.h"
@implementation SPMyInterestCell
{
    UIView *_baseForTag;
    UIImageView *_imgForTag;
    UILabel *_textForTag;
    
    UILabel *_textForSkill;
    
    UIImageView *_chooseImg;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];

        if (self.gestureRecognizers == nil) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAction:)];
            [self addGestureRecognizer:tap];
        }
    }
    return self;
}

-(void)clickedAction:(UIGestureRecognizer *)gesture{
    if (_model.selected) {
        _chooseImg.hidden = YES;
        _model.selected = 0;
    }else{
        _chooseImg.hidden = NO;
        _model.selected = 1;
    }
}

-(void)createUI{
    
    CGFloat tagWid = 70;
    //我的标签 的背景
    UIView *base = [[UIView alloc]init];
    _baseForTag = base;
    base.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:base];
    [_baseForTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(tagWid, tagWid));
        make.center.offset(0);
    }];
    
    //标签图片
    _imgForTag = [[UIImageView alloc]init];
    _imgForTag.contentMode = UIViewContentModeScaleAspectFit;
    [_baseForTag addSubview:_imgForTag];
    [_imgForTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(50, 50));
        make.top.offset(5);
        make.centerX.offset(0);
    }];
    
    //标签字
    _textForTag = [[UILabel alloc]init];
    _textForTag.textAlignment = NSTextAlignmentCenter;
    _textForTag.backgroundColor = [UIColor clearColor];
    _textForTag.textColor = [UIColor blackColor];
    [_baseForTag addSubview:_textForTag];
    _textForTag.font = font(13);
    [_textForTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(55);
        make.size.mas_offset(CGSizeMake(tagWid, 20));
        make.left.offset(0);
    }];
 
    CGFloat skillWid = 50;
    //武功类型的textLabel
    _textForSkill = [[UILabel alloc]init];
    _textForSkill .textAlignment  =NSTextAlignmentCenter;
    _textForSkill.font = font(12);
    _textForSkill.numberOfLines = 2;
    _textForSkill.textColor = [UIColor whiteColor];
    _textForSkill.backgroundColor = [UIColor redColor];
    _textForSkill.layer.cornerRadius = skillWid/2;
    _textForSkill.clipsToBounds =YES;
    [base addSubview:_textForSkill];
    [_textForSkill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(skillWid, skillWid));
        make.top.offset(5);
        make.centerX.offset(0);
    }];
    
    //选中的对勾
    _chooseImg = [[UIImageView alloc]init];
    [_chooseImg setImage:[UIImage imageNamed:@"grxx6_r4_c5"]];
    [self.contentView addSubview:_chooseImg];
    [_chooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30, 30));
        make.left.equalTo(_textForSkill.mas_right).offset(-15);
        make.top.equalTo(_textForSkill.mas_top).offset(-15);
    }];
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(self.frameWidth-0.5, -1, 0.5, self.frameHeight+1)];
    [self.contentView addSubview:rightLine];
    
}

-(void)setModel:(SPKungFuModel *)model{
    _model = model;
    //根据不同的类型，显示不同的控件
    if ([model.rootType  isEqualToString:@"SKILL"]) {//武功类型
        _baseForTag.hidden = NO;
        _textForSkill.hidden =NO;
        _textForSkill.text = model.value;
        
        _textForSkill.backgroundColor = [SPCommon colorWithHexString:model.bgColor];
        _textForSkill.textColor = [SPCommon colorWithHexString:model.fontColor];
    }else if ([model.rootType  isEqualToString:@"TAG"]){//标签类型
        _textForSkill.hidden = YES;
        _baseForTag.hidden = NO;
        [_imgForTag sd_setImageWithURL:[NSURL URLWithString:model.hobbyImg]];
        _textForTag .text = model.value;
//        _textForTag.textColor = [SPCommon colorWithHexString:model.color];
    }
    
    //设定选中状态
    if (_model.selected) {
        _chooseImg.hidden = NO;
    }else{
        _chooseImg.hidden = YES;
    }
}

-(void)setBaseColor:(UIColor *)baseColor{
    _baseColor = baseColor;
//    _textForSkill.backgroundColor = baseColor;
}

@end
