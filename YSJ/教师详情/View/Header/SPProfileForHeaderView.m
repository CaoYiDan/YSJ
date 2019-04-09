//
//  SPProfileForHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPUser.h"
#import "SPAuthenticationView.h"
#import "SPProfileForHeaderView.h"

@implementation SPProfileForHeaderView
{
    UIButton *_age;
    
    UIButton *_constellation;
    SPAuthenticationView *_authentionView;
    UILabel *_title;
    UILabel *_subTitle;
    UIButton *_buyBtn;
    UILabel *_price;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 8, SCREEN_W, 25)];
    _title.font = BoldFont(18);
    [self addSubview:_title];
    
    _subTitle= [[UILabel alloc]init];
    _subTitle.font = kFontNormal;
    
    [self addSubview:_subTitle];
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
 make.top.equalTo(_title.mas_bottom).offset(10);

    }];
    
    _buyBtn = [[UIButton alloc]init];
    _buyBtn.backgroundColor = [UIColor orangeColor];
    [_buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    _buyBtn.layer.cornerRadius = 5;
    _buyBtn.clipsToBounds = YES;
    _buyBtn.titleLabel.font = font(13);
    [self addSubview:_buyBtn];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10); make.top.equalTo(_subTitle.mas_bottom).offset(12);
        make.width.offset(94);
        make.height.offset(24);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = kFontNormal;
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title).offset(0);
    make.centerY.equalTo(_buyBtn).offset(0);
        make.height.offset(30);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = GRAYCOLOR;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.equalTo(_price.mas_bottom).offset(10);
    }];
    
}

-(void)setModel:(SPUser *)model{
    _model = model;
    
    [_age setTitle:[NSString stringWithFormat:@"%d岁",model.age] forState:0];
    _age.selected = model.gender;
    //如果是女的，背景色改为粉红色
    if (!model.gender) {
        _age.backgroundColor = RGBCOLOR(255, 203, 215);
    }
    
    //认证
    [_authentionView setA0:NO A1:NO set2:YES set3:[model.identityStatus isEqualToString:CERTIFIED]];
    
    [_constellation setTitle:model.zodiac forState:0];
    
    _title.text = [NSString stringWithFormat:@"%@ | %@",model.job,model.experience];
    
    _subTitle.text = model.beFrom;
    
    [_buyBtn setTitle:[NSString stringWithFormat:@"%@ | %@",model.distance,model.livenessStatus] forState:0];
    
    _price.text = model.domain;
}

-(void)setType:(NSInteger)type{
    _type = type;
}
@end
