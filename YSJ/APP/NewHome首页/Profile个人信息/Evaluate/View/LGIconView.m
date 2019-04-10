//
//  LGIconView.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//
//#import "UIImage+SCImage.h"
#import "LGIconView.h"
@interface LGIconView ()
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation LGIconView

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
//        verifiedView.backgroundColor = HomeBaseColor;
        [self addSubview:verifiedView];
        verifiedView.contentMode = UIViewContentModeScaleAspectFill;
        self.verifiedView = verifiedView;
        
    }
    return _verifiedView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.verifiedView.frame=CGRectMake(0, 0, self.frameWidth, self.frameHeight);
}

-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
}

@end
