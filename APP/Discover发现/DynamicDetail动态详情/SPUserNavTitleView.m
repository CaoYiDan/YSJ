//
//  SPUserNavTitleView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPDynamicModel.h"
#import "SPProfileVC.h"
#import "SPUserNavTitleView.h"
#import "SPCommon.h"
@interface SPUserNavTitleView ()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 和发布地点*/
@property (nonatomic, weak) UILabel *timeAndAreaLabel;
/** 等级图标 */
@property (nonatomic, weak) UIButton *levelImg;
/** 男女性别图标 */
@property (nonatomic, strong) UIImageView *sexImg;
@end

@implementation SPUserNavTitleView
{
    NSDictionary *_profileDic;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    /** 头像 */
    CGFloat iconW = 40;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, iconW, iconW)];
    iconView.backgroundColor = HomeBaseColor;
    iconView.layer.cornerRadius  = iconW/2;
    iconView.clipsToBounds = YES;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.userInteractionEnabled = YES;
    [self addSubview:iconView];
    self.iconImg = iconView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    tap.numberOfTapsRequired = 1;
    [iconView addGestureRecognizer:tap];
    
    //性别图标
    CGFloat sexImgW = 10;
    CGFloat sexImgH = 15;
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(iconW-sexImgW, iconW-sexImgH,sexImgW, sexImgH)];
    [iconView addSubview:self.sexImg];

    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = kFontNormal_14;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).mas_offset(15);
        make.top.offset(2);
        make.height.offset(20);
    }];
    
//    /** 等级图标*/
//    UIButton *level = [[UIButton alloc]init];
//    [level setBackgroundImage:[UIImage imageNamed:@""] forState:0];
//    [self addSubview:level];
//    self.levelImg = level;
//    [level mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(nameLabel.mas_right).offset(4);
//        make.size.mas_offset(CGSizeMake(10, 10));
//        make.centerY.equalTo(nameLabel);
//    }];
    
    /** 时间  和 发布地点*/
    UILabel *timeAndAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconW+15, 22, self.frameWidth-iconW-15, 20)];
    timeAndAreaLabel.font = Font(12);
    timeAndAreaLabel.textColor  = [UIColor lightGrayColor];
    timeAndAreaLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:timeAndAreaLabel];
    self.timeAndAreaLabel = timeAndAreaLabel;
}

//导航栏赋值
-(void)setModel:(SPDynamicModel *)model{
    
    if (!model) return;
    
    _model = model;
    
    if (isEmptyString(model.promulgatorAvatar)) {
        //头像
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@""]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
    }else{
     //头像
     [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.promulgatorAvatar]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
    }
    //姓名
    self.nameLabel .text = model.promulgatorName;
    
    //时间和发布地区
    [self.timeAndAreaLabel setMyText:[NSString stringWithFormat:@"%@  %@",model.time,isEmptyString(model.locationValue)?@"":model.locationValue]];
}

//评价赋值
-(void)setDict:(NSDictionary *)dict{
    NSLog(@"%@",dict);
    _profileDic = dict;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:dict[@"commentorAvatar"]]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];

    self.nameLabel.text = dict[@"commentorName"];
    
    self.timeAndAreaLabel .text = [NSString stringWithFormat:@"%@ %@",isEmptyString(dict[@"commentedTime"])?@"":dict[@"commentedTime"],@""];
}

-(void)iconTap{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    NSLog(@"%@",self.model.promulgator);
    if (self.model) {
         vc.code = self.model.promulgator;
        vc.titleName = self.model.promulgatorName;
    }else{
        vc.code = _profileDic[@"commentor"];
        vc.titleName = _profileDic[@"commentorName"];
    }
   
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (CGSize)intrinsicContentSize
{
//    if (@available(iOS 11.0, *)){
//        return UILayoutFittingExpandedSize;
//    }
    return _intrinsicContentSize;
    
}
@end
