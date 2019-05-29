//
//  SPHomeHeaderCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPActivityCell.h"

@implementation SPActivityCell
{
    UIImageView*_activityImgView;
    UILabel*_name;
    UILabel*_subName;
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
    
    _activityImgView =  [[UIImageView alloc]initWithFrame:CGRectMake(0,10, self.frameWidth, self.frameHeight-50)];
    _activityImgView.backgroundColor = [UIColor whiteColor];
    _activityImgView.layer.cornerRadius = 5;
    _activityImgView.clipsToBounds = YES;
    _activityImgView.contentMode = UIViewContentModeScaleAspectFill;
    _activityImgView.clipsToBounds = YES;
    [self.contentView addSubview:_activityImgView];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frameHeight-40, self.frameWidth, 20)];
    _name.font = kFontNormal;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _subName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frameHeight-20, self.frameWidth, 20)];
    _subName.font = font(13);
    _subName.textColor = [UIColor lightGrayColor];
    _subName.backgroundColor = WC;
    [self.contentView addSubview:_subName];
}

-(void)setActivityDict:(NSDictionary *)activityDict{
    
    //https://gtd.alicdn.com/bao/uploaded/i2/666512320/TB2QjcYlCJjpuFjy0FdXXXmoFXa_!!666512320.jpg_480x480.jpg
    _activityDict = activityDict;
    [_activityImgView sd_setImageWithURL:[NSURL URLWithString:activityDict[@"imgUrl"]]];
    
    _name.text = activityDict[@"title"];
    
    _subName.text = activityDict[@"subTitle"];
}

@end

