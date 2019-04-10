//
//  CardView.m
//  仿陌陌点点切换
//
//  Created by zjwang on 16/3/28.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "CardView.h"
#import "SPShareView.h"
#import "SPNearModel.h"
#import "UILabel+SPText.h"
#import "NSString+getSize.h"
@interface CardView ()

@end

@implementation CardView
{
    UIButton *_imgNum;
    UIButton *_level;
    UIButton *_zan;
    UIButton *_share;
    
    UILabel *_name;
    UILabel *_positionAndExperience;
    UILabel *_districtAndIndustry;
    UIButton *_age;
    UIButton *_constellation;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
    
    CGFloat imgHeight = self.frame.size.width - 10;
    //图片
    [self addSubview:self.imageView];
    _imageView.frame = CGRectMake(5, 5, imgHeight, imgHeight);
    _imageView.contentMode =UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.backgroundColor = [UIColor whiteColor];
    
    //图片个数
    _imgNum = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    [_imgNum setImage:[UIImage imageNamed:@"n_imgnum"] forState:0];
    _imgNum.backgroundColor = RGBCOLORA(1, 1, 1, 0.4);
    _imgNum.layer.cornerRadius = 5;
    _imgNum.clipsToBounds = YES;
    [_imgNum setTitle:@"0" forState:0];
    [self addSubview:_imgNum];
    
    //等级
//    _level = [[UIButton alloc]initWithFrame:CGRectMake(20, imgHeight-40, 43, 36)];
//    [_level setBackgroundImage:[UIImage imageNamed:@"c_level"] forState:0];
//    [self addSubview:_level];
    
    //赞
    _zan = [[UIButton alloc]initWithFrame:CGRectMake(20, imgHeight-40, 34, 36)];
    [_zan setBackgroundImage:[UIImage imageNamed:@"60"] forState:0];
    _zan.titleLabel.font= font(12);
//    [_zan setImage:[UIImage imageNamed:@"d_love_white"] forState:0];
    [self addSubview:_zan];
    
    //分享
    _share = [[UIButton alloc]initWithFrame:CGRectMake(self.frameWidth-50   , imgHeight-40, 40, 40)];
    [_share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
    [_share setImage:[UIImage imageNamed:@"n_share"] forState:0];
    [self addSubview:_share];
    
    //昵称
    CGFloat nameWid = 80;
    _name = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+imgHeight, nameWid, 60)];
    _name.adjustsFontSizeToFitWidth = YES;
    _name.numberOfLines = 0;
    _name.backgroundColor = [UIColor whiteColor];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = BoldFont(20);
    [self addSubview:_name];

    //职位和经验
    _positionAndExperience  = [[UILabel alloc]initWithFrame:CGRectMake(20+nameWid, 15+imgHeight, self.frameWidth-30-nameWid, 20)];
//    _positionAndExperience.backgroundColor = [UIColor redColor];
    _positionAndExperience.numberOfLines=1;
    _positionAndExperience.font = kFontNormal;
    _positionAndExperience.backgroundColor  = [UIColor whiteColor];
    [self addSubview:_positionAndExperience];
    
    //地域和行业
    _districtAndIndustry  = [[UILabel alloc]initWithFrame:CGRectMake(20+nameWid,CGRectGetMaxY(_positionAndExperience.frame), self.frameWidth-30-nameWid, 20)];
    _districtAndIndustry.numberOfLines=1;
//    _districtAndIndustry.backgroundColor  =[UIColor orangeColor];
    _districtAndIndustry.backgroundColor = [UIColor whiteColor];
    _districtAndIndustry.font = kFontNormal;
    [self addSubview:_districtAndIndustry];
   
    //年龄
   _age  = [[UIButton alloc]initWithFrame:CGRectMake(20+nameWid, CGRectGetMaxY(_districtAndIndustry.frame), 50, 20)];
    _age.backgroundColor = RGBCOLOR(199, 226, 253);
    _age.layer.cornerRadius = 4;
    _age.clipsToBounds = YES;
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_n"] forState:UIControlStateSelected];
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_nv"] forState:UIControlStateNormal];
    _age.titleLabel.font = font(12);
    [self addSubview:_age];
    
    //星座
    _constellation = [[UIButton alloc]initWithFrame:CGRectMake(20+nameWid+60, CGRectGetMaxY(_districtAndIndustry.frame), 50, 20)];
    _constellation.layer.cornerRadius = 4;
    _constellation.clipsToBounds = YES;
    _constellation.backgroundColor = RGBCOLOR(216, 199, 253);
    
    _constellation.titleLabel.font = font(12);
    [self addSubview:_constellation];
}

- (UILabel *)labelTitle
{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
    }
    return _labelTitle;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(void)setType:(NSInteger)type{
    _type = type;
    if (type == 0) {
        self.backgroundColor = [UIColor redColor];
    }else if (type == 1){
        self.backgroundColor = [UIColor orangeColor];
    }else{
        self.backgroundColor = [UIColor purpleColor];
    }
}

-(void)setModel:(SPNearModel *)model{
    _model = model;
    
    if (model.avatarList.count>0) {
        //主图片
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarList[0][@"url"]]];
        //图片几张
        [_imgNum setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)model.avatarList.count] forState:0];
    }else{
        _imageView.layer.borderColor = MyBlueColor.CGColor;
        _imageView.layer.borderWidth = 1;
        _imageView.image = [UIImage imageNamed:@"placeholder2"];
    }
    
    //
//    [_level setTitle:[NSString stringWithFormat:@"%lu",model.likedNum]forState:0];
//
     //被赞数目
    [_zan setTitle:[NSString stringWithFormat:@"%lu",(long)model.likedNum] forState:0];
    
    //昵称
//    _name.text = model.nickName;
    
    _name.myText = model.nickName;
    
    //职位和经验
    _positionAndExperience.myText = [NSString stringWithFormat:@"%@ | %@",model.domain,model.experience];
  
    //地域和行业
    _districtAndIndustry.myText = [NSString stringWithFormat:@"%@ | %@",model.beFrom,model.job];
    
    //年龄和星座
    [_age setTitle:[NSString stringWithFormat:@"%@岁",model.age] forState:0];
    _age.selected = model.gender;
    //如果是女的，背景色改为粉红色
    if (!model.gender) {
        _age.backgroundColor = RGBCOLOR(255, 203, 215);
    }
    
    [_constellation setTitle:model.zodiac forState:0];
   
    
    //武功标签
    CGFloat wid = (SCREEN_W-60-20-20)/3;
    
    NSMutableArray *textArr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<model.skills.count; i++) {
        [textArr addObject:model.skills[i]];
    }
    
    for (int i=0; i<model.tags.count; i++) {
        [textArr addObject:model.tags[i]];
    }
    
    NSArray *colorArr = @[LIGHTPURPLECOLOR,LIGHTPRINKCOLOR,LIGHTGREENCOLOR,LIGHTBULECOLOR,LIGHTBLUECOLOR2,LIGHTORANGECOLOR];
    
    for (int i=0; i<(textArr.count>6?6:textArr.count); i++) {
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10+i%3*(wid+10), CGRectGetMaxY(_age.frame)+10+i/3*35, wid, 25)];
        
        lab.textAlignment= NSTextAlignmentCenter;
        lab.adjustsFontSizeToFitWidth = YES;
        lab.textColor = [UIColor blackColor];
        lab.layer.cornerRadius = 5;
        lab.text = textArr[i];
        lab.backgroundColor = colorArr[i];
        lab.clipsToBounds  = YES;
        lab.font = font(12);
        [self addSubview:lab];
        
        //更改一下self的高度，适配
//        if (i==textArr.count-1) {
//             self.frameHeight = CGRectGetMaxY(lab.frame)+20;
//        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate cardViewClick];
}

-(void)share{
    [self.delegate clickShareWithImage:_imageView.image];
}
@end
