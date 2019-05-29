//
//  SPSelectionCategoryView.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSelectionCategoryView.h"

@implementation SPSelectionCategoryView
{
    UIImageView *_headerImg;
    
    UILabel *_name;
    UILabel *_positionAndExperience;
    UILabel *_districtAndIndustry;
    UILabel *_ageAndConstellation;
    UIButton *_insterest;
    
    UIView *_signBaseView;//签名的背景View;
    UIButton *_level;
    UIButton *_zan;
    UITextField *_signTextFiled;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}

#pragma  mark - UI
-(void)configUI{
    [self sTop];
    [self sLeft];
    [self sRight];
    [self sBottom];
}

-(void)sTop{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kMargin, 20, SCREEN_W-2*kMargin, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    
}

-(void)sLeft{
    //头像
    CGFloat headerWid = 150;;
    _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 60, headerWid,headerWid)];
    _headerImg.contentMode = UIViewContentModeScaleAspectFill;
    _headerImg.backgroundColor = [UIColor whiteColor];
    _headerImg.clipsToBounds = YES;
    _headerImg.layer.cornerRadius = 5;
    [self addSubview:_headerImg];
}

-(void)sRight{
    
    CGFloat vMargin = 15;
    CGFloat hMargin  = 5;
    
    
    //昵称
    //CGFloat nameWid = 120;
    
    _name = [[UILabel alloc]init];
    _name.adjustsFontSizeToFitWidth = YES;
    _name.backgroundColor = [UIColor whiteColor];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.font = BoldFont(16);
    [self addSubview:_name];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_headerImg).offset(10);
        make.left.equalTo(_headerImg.mas_right).offset(vMargin);
        make.height.offset(30);
        
    }];
    
    //职位和经验
    _positionAndExperience  = [[UILabel alloc]init];
    _positionAndExperience.font = kFontNormal;
    [self addSubview:_positionAndExperience];
    [_positionAndExperience mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImg).offset(50);
        make.left.equalTo(_headerImg.mas_right).offset(vMargin);
        make.right.offset(-5);
    }];
    
    //地域和行业
    _districtAndIndustry  = [[UILabel alloc]init];
    _districtAndIndustry.font = kFontNormal;
    [self addSubview:_districtAndIndustry];
    [_districtAndIndustry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_positionAndExperience.mas_bottom).offset(hMargin);
        make.left.equalTo(_positionAndExperience);
        make.right.offset(-5);
        
    }];
    
    //年龄和星座
    _ageAndConstellation  = [[UILabel alloc]init];
    _ageAndConstellation.font = kFontNormal;
    [self addSubview:_ageAndConstellation];
    [_ageAndConstellation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_districtAndIndustry.mas_bottom).offset(hMargin);
        make.left.equalTo(_positionAndExperience);
        make.right.offset(-5);
    }];
    
    //兴趣
    _insterest = [[UIButton alloc]init];
    [_insterest setTitleColor:[UIColor blackColor] forState:0];
    _insterest .titleLabel.font = kFontNormal;
    [_insterest setImage: [UIImage imageNamed:@"c_interest"] forState:0];
    [self addSubview:_insterest];
    [_insterest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ageAndConstellation.mas_bottom).offset(hMargin);
        make.left.equalTo(_positionAndExperience);
        make.height.offset(30);
//        make.right.offset(-5);
    }];
    
    //编辑
    //    UIButton *edit = [[UIButton alloc]init];
    //    [edit setBackgroundImage:[UIImage imageNamed:@"c_edit"] forState:0];
    //    [edit addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchDown];
    //    [self addSubview:edit];
    //    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.offset(-10);
    //        make.size.mas_offset(CGSizeMake(40, 40));
    //        make.centerY.equalTo(_insterest);
    //    }];
}

-(void)sBottom{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(_headerImg.frame)+30, SCREEN_W/2-kMargin-38, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    //等级
    CGFloat levelWid = 40;
//    _level = [[UIButton alloc]init];
//    [_level addTarget:self action:@selector(myLevel) forControlEvents:UIControlEventTouchDown];
//    [_level setBackgroundImage:[UIImage imageNamed:@"c_level"] forState:0];
//    [self addSubview:_level];
//    [_level mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(SCREEN_W/2-33);
//        make.size.mas_offset(CGSizeMake(levelWid+5, levelWid));
//        make.centerY.equalTo(line);
//    }];
    
    //点赞
    _zan = [[UIButton alloc]init];
    [_zan addTarget:self action:@selector(myLevel) forControlEvents:UIControlEventTouchDown];
    [_zan setBackgroundImage:[UIImage imageNamed:@"60"] forState:0];
//    [_zan setImage:[UIImage imageNamed:@"c_love"] forState:0];
    [self addSubview:_zan];
    [_zan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCREEN_W/2-20);
        make.size.mas_offset(CGSizeMake(levelWid, levelWid));
        make.centerY.equalTo(line);
    }];
    
    
    UIView *lineSecond = [[UIView alloc]init];
    lineSecond.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineSecond];
    
    [lineSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_top);
        make.left.equalTo(_zan.mas_right).offset(10);
        make.right.offset(-10);
        make.height.offset(1);
        
    }];
    
    //铅笔图片
    //    UIImageView *editImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame)+31, 20, 20)];
    //    editImg.backgroundColor = [UIColor whiteColor];
    //    [editImg setImage:[UIImage imageNamed:@"c_textedit"]];
    //    [self addSubview:editImg];
    //
    //    //签名
    //    UITextField *signFiled = [[UITextField alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(line.frame)+21, SCREEN_W-50, 40)];
    //    _signTextFiled = signFiled;
    //    signFiled.backgroundColor = [UIColor whiteColor];
    //    signFiled.userInteractionEnabled = NO;
    //    [self addSubview:signFiled];
}

#pragma  mark - action
//点击编辑
-(void)edit{
    !self.proflieHeaderBLock?:self.proflieHeaderBLock(0);
}

-(void)myLevel{
    //!self.proflieHeaderBLock?:self.proflieHeaderBLock(1);
}

#pragma  mark - 模型赋值
-(void)setUser:(SPSelectionCategoryModel *)user{
    _user = user;
    NSLog(@"%@%@%@",user.avatar,user.domain,user.experience);
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"bg"]];
    //_headerImg.image = [UIImage imageNamed:@"pic3"];
    _name.text = user.nickName;
    
    //职位和经验
    _positionAndExperience.text = [NSString stringWithFormat:@"%@ | %@",user.domain,user.experience];
    
    //地域和行业
    _districtAndIndustry.text = [NSString stringWithFormat:@"%@ | %@",user.beFrom,user.job];
    
    //年龄和星座
    NSString * genderStr;
    if (user.gender) {
        genderStr = @"男";
    }else{
        
        genderStr = @"女";
    }
    _ageAndConstellation.text = [NSString stringWithFormat:@"%@ | %@岁 | %@",genderStr,user.age,user.zodiac];
    
    //等级
    //    if (isEmptyString(user.level)) {
    //         [_level setTitle:@"0" forState:0];
    //    }else{
    //         [_level setTitle:[user.level[@"level"] stringValue] forState:0];
    //    }
    
    //点赞
    [_zan setTitle:[NSString stringWithFormat:@"%d",user.likedNum] forState:0];
    
//    [_level setTitle:[NSString stringWithFormat:@"%d",user.level]forState:0];
    //签名
    //_signTextFiled.text = user.signature;
    
    //兴趣
    [_insterest setTitle:[NSString stringWithFormat:@"%@ %@",user.distance,user.livenessStatus] forState:0];
}

@end
