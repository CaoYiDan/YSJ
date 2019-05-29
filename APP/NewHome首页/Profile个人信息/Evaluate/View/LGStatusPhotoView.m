//
//  LGStatusPhotoView.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "LGStatusPhotoView.h"
@interface LGStatusPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation LGStatusPhotoView


- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhotoImagePath:(NSString *)photoImagePath{
    _photoImagePath=photoImagePath;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photoImagePath] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.originX = self.frameWidth - self.gifView.frameWidth;
    self.gifView.originY = self.frameHeight - self.gifView.frameHeight;
}


@end
