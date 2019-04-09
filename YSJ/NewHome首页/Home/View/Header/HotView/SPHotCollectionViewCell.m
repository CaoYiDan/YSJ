//
//  SPHomeHeaderCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHotCollectionViewCell.h"

@implementation SPHotCollectionViewCell
{
    UIImageView *_imgView;
    UILabel *_rightTitle;
    UILabel *_name;
    UIButton *_age;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
        self.clipsToBounds = YES;
//        self.layer.borderColor = [UIColor grayColor].CGColor;
//        self.layer.borderWidth = 1;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowRadius = 1;
    }
    return self;
}

-(void)setUp{
    CGFloat imgH = self.frameWidth+15;
    //图片
    _imgView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frameWidth, imgH)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.clipsToBounds = YES;
    _imgView.layer.cornerRadius = 5;
    _imgView.clipsToBounds = YES;
    _imgView.contentMode  = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];
    
    //标题
    _rightTitle = [[UILabel alloc]init];
    _rightTitle.backgroundColor = RGBA(248,75,122,0.7);
    _rightTitle.textColor = [UIColor whiteColor];
    _rightTitle.font = font(12);
    _rightTitle.layer.cornerRadius = 4;
    _rightTitle.clipsToBounds = YES;
    _rightTitle.adjustsFontSizeToFitWidth = YES;
    _rightTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightTitle];
//    if (kiPhone5) {
    [_rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.offset(0);
            make.top.offset(0);
            make.height.offset(20);
        }];
//    }else{
//    [_rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(0);
//        make.top.offset(0);
//        make.height.offset(20);
//    }];
//    }
   
    
    
    //昵称
    _name = [[UILabel alloc]init];
    _name.font = kFontNormal;
    _name.clipsToBounds = YES;
    _name.textAlignment = NSTextAlignmentLeft;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(imgH);
        make.left.offset(0);
        make.height.offset(30);
        if (kiPhone5) {
            make.width.offset(self.frameWidth-35);
        }else{
            make.width.offset(self.frameWidth-45);
        }
    }];
    
    //年龄
    _age = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 10, 50, 20)];
    _age.backgroundColor = RGBCOLOR(199, 226, 253);
    _age.layer.cornerRadius = 4;
    _age.clipsToBounds = YES;
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_n"] forState:UIControlStateSelected];
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_nv"] forState:UIControlStateNormal];
    _age.titleLabel.font = font(12);
    _age.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_age];
    [_age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(imgH+5);
        make.left.equalTo(_name.mas_right).offset(0);
        make.height.offset(20);
        make.right.offset(0);
    }];
    
}

-(void)setHotDict:(NSDictionary *)hotDict{
    
    _hotDict = hotDict;
    NSLog(@"%@",hotDict);
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:hotDict[@"avatar"]]];

    
//    _age.text = [NSString stringWithFormat:@"%@岁",hotDict[@"age"]];
    
    [_age setTitle:[NSString stringWithFormat:@"%@岁",hotDict[@"age"]] forState:0];
    _age.selected = [hotDict[@"gender"] boolValue];
    //如果是女的，背景色改为粉红色
    if (![hotDict[@"gender"] boolValue]) {
        _age.backgroundColor = RGBCOLOR(255, 203, 215);
    }else{
        _age.backgroundColor = RGBCOLOR(199, 226, 253);
    }
    
     _name.text = hotDict[@"nickName"];
    
    _rightTitle.text = [NSString stringWithFormat:@"%@ %@",hotDict[@"skill"],hotDict[@"serPrice"]];
    NSLog(@"%@",_rightTitle.text);
    if (isEmptyString(hotDict[@"serPrice"])) {
        _rightTitle.hidden = YES;
    }else{
        _rightTitle.hidden = NO;
    }
  
}
@end

