//
//  SPDyDetailImgCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDyDetailImgCell.h"

@implementation SPDyDetailImgCell

{
    UIImageView*_img;
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
    
    //图片
    _img =  [[UIImageView alloc]init];
    _img.clipsToBounds = YES;
    _img.contentMode  = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_img];

    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [_img sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

//-(void)prepareForReuse{
//    [super prepareForReuse];
//    //将图片view上的图片移除，不然错乱
//    [_img sd_setImageWithURL:[NSURL URLWithString:@""]];
//    
//    [self layoutIfNeeded];
////    [cell configureWithItem:nil];
//}

@end
