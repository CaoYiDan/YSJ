//
//  YSJHomeWorkTypeListCell.m
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJHomeWorkTypeListCell.h"

@implementation YSJHomeWorkTypeListCell
{
    UIImageView *_img;
    UILabel *_name;
    UILabel *_introduction;
}

- (void)initUI{
    
    CGFloat imgWid = 24;
    CGFloat imgH = 24;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(16, 20, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 12;
    _img.clipsToBounds = YES;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(56, 18, 200, 22)];
    _name.font = Font(16);
    _name.backgroundColor = [UIColor whiteColor];
    _name.textColor = [UIColor hexColor:@"1D1E2C"];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(56, 45, 200, 18)];
    _introduction.font = font(13);
    _introduction.textColor =[UIColor hexColor:@"69707F"];
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    self.contentView.backgroundColor = KWhiteColor;
    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentView.layer.shadowOpacity = 0.2;
    self.contentView.layer.shadowColor = [UIColor hexColor:@"27347d"].CGColor;
    
}

- (void)setFrame:(CGRect)frame{
    
    CGRect newFrame = frame;
    
    newFrame.origin.x = 16;
//    newFrame.origin.y-=17;
    newFrame.size.width -= 2*16;
    newFrame.size.height-=17;
    
    [super setFrame: newFrame];
 }

-(void)setDic:(NSDictionary *)dic{
    _img.image =[UIImage imageNamed:dic[@"img"]];
    _name.text = dic[@"name"];
    
}

-(void)setSubText:(NSString *)subText{
    _subText = subText;
    _introduction.text = subText;
}
@end
