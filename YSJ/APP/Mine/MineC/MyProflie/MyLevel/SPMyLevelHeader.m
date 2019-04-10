//
//  SPMyLevelHeader.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyLevelHeader.h"
#import "SPUser.h"

CGFloat const  levelWid = 30;

@implementation SPMyLevelHeader
{
    UIImageView *_pigImg;
    UILabel *_name;
    UILabel *_level;
    UILabel *_information;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    //猪 图片
//    _pigImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/2-165.5/2, 40, 165.5, 160.5)];
    _pigImg = [[UIImageView alloc]init];
    _pigImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_pigImg];
    [_pigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SCREEN_W);
        make.height.equalTo(self).multipliedBy(0.55);
        make.top.offset(30);
        make.left.offset(0);
    }];
    
    //等级
    _level = [[UILabel alloc]init];
    _level.textColor = [UIColor whiteColor];
    _level.layer.cornerRadius = levelWid/2;
    _level.clipsToBounds = YES;
    _level.textAlignment = NSTextAlignmentCenter;
    _level.backgroundColor = RGBCOLOR(72, 103, 218);//蓝色
     [self addSubview:_level];
    [_level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pigImg.mas_bottom).offset(0);
        make.size.mas_offset(CGSizeMake(levelWid, levelWid));
        make.centerX.equalTo(_pigImg);
    }];
    
    //等级对应的昵称
    _name = [[UILabel alloc]init];
    _name.textColor = RGBCOLOR(72, 103, 218); //蓝色
    _name.font = BoldFont(20);
    _name.backgroundColor = [UIColor whiteColor];
    _name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_level.mas_bottom).offset(4);
        make.centerX.equalTo(_pigImg);
    }];
    
    //资讯费用
    _information = [[UILabel alloc]init];
    _information.textColor = RGBCOLOR(72, 103, 218); //蓝色
    _information.font = font(14);
    _information.numberOfLines = 2;
    _information.backgroundColor = [UIColor whiteColor];
    _information.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_information];
    [_information mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_name.mas_bottom).offset(4);
        make.centerX.equalTo(_pigImg);
    }];
}

-(void)setLevelDict:(NSDictionary *)levelDict{
    [_pigImg sd_setImageWithURL:[NSURL URLWithString:levelDict[@"avatar"]]];
    _level.text = [levelDict[@"level"] stringValue];
    _name.text = levelDict[@"name"];
    _information.text = [NSString stringWithFormat:@"资讯费用\n%@元/小时",[levelDict[@"reward"] stringValue]];
}

@end
