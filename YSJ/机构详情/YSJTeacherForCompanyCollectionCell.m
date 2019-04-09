//
//  YSJTeacherCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//
//

#import "YSJTeacherForCompanyCollectionCell.h"

#import "YSJCompanysModel.h"

@implementation YSJTeacherForCompanyCollectionCell

{
    UIImageView *_img;
    UILabel *_name;
    UILabel *_introduction;
   
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    CGFloat imgWid = 70;
    
    CGFloat imgH = 70;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 35;
    _img.clipsToBounds = YES;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+17, imgWid, 30)];
    _name.font = Font(16);
    _name.textColor = KBlack333333;
    _name.textAlignment = NSTextAlignmentCenter;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+45, imgWid, 20)];
    _introduction.font = font(12);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
   
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,dic[@"photo"]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    _name.text = dic[@"name"];
    
    _introduction.text = dic[@"teaching_type"];
}



@end
