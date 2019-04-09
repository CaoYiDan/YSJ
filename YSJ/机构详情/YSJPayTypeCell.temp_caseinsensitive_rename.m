//
//  YSJpayTypeCell.m
//  SmallPig
//
//  Created by xujf on 2019/4/1.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPayTypeCell.h"

@implementation YSJPayTypeCell
{
    UIImageView *_img;
    UILabel *leftText;
    UIImageView *_rightImg;
}
- (void)initUI{
    leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 140, self.frameHeight)];
    leftText.font = font(16);
    leftText.text = @"";
    [self addSubview:leftText];
    
    _img =[[UIImageView alloc]init];
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(28);
        make.height.offset(24);
        make.centerY.offset(0);
    }];
    
    _rightImg =[[UIImageView alloc]init];
    [self addSubview:_rightImg];
    _rightImg .image = [UIImage imageNamed:@"未选中"];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(10);
        make.height.offset(10);
        make.centerY.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    NSString *imgS = selected?@"选中":@"未选中";
    _rightImg .image = [UIImage imageNamed:imgS];
    
}

- (void)setIcon:(NSString *)icon{
    _img.image = [UIImage imageNamed:icon];
}
@end
