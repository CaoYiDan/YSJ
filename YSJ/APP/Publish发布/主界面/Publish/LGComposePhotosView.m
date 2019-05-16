//
//  LGComposePhotosView.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/15.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "LGComposePhotosView.h"
#import "SPCanDeleteImgView.h"


@implementation LGComposePhotosView
{
    CGFloat _iconW;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int maxCol = 3;
        _iconW = (SCREEN_W-40)/maxCol;
        [self addBtn];
    }
    return self;
}

-(void)addBtn{
    UIButton*btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"add6"] forState:UIControlStateNormal];
    btn.tag = 120;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    self.btn=btn;
    [self addSubview:btn];
}

-(void)click{
    
    if (self.subviews.count>9) {
        Toast(@"最多可上传9张哦");
        return;
    }
    self.clickblock(110);
}

-(void)setImgs:(NSArray *)imgs{
    
    for (UIView *vi in self.subviews) {
        if (vi.tag!=120) {
            [vi removeFromSuperview];
        }
    }
    
    int i=0;
    for (UIImage *img in imgs) {
        SPCanDeleteImgView *photoView = [[SPCanDeleteImgView alloc] init];
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.image = img;
        photoView.tag = i;
        WeakSelf;
        photoView.deleteblock = ^(NSInteger tag){
            //[weakSelf.photosAsset removeObjectAtIndex:tag];
            weakSelf.clickblock(tag);
        };
        photoView.clipsToBounds = YES;
        [self addSubview:photoView];
        i++;
    }
    
    if (self.subviews.count>3 && self.subviews.count <=6) {
        //回传 ，更改父控件 frame;
        self.clickblock(_iconW*2+10*4);
    }else if (self.subviews.count>6) {
        //回传 ，更改父控件 frame;
        self.clickblock(_iconW*3+10*5);
    }else{
        //回传 ，更改父控件 frame;
        self.clickblock(_iconW+10*3);
    }
}

- (void)addPhoto:(UIImage *)photo
{
    if (self.subviews.count>=3 && self.subviews.count <5) {
        //回传 ，更改父控件 frame;
        self.clickblock(240);
    }
    
    if (self.subviews.count>=6) {
        //回传 ，更改父控件 frame;
        self.clickblock(320);
    }
    
    SPCanDeleteImgView *photoView = [[SPCanDeleteImgView alloc] init];
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.image = photo;
    photoView.clipsToBounds = YES;
    [self addSubview:photoView];
    
    // 存储图片
    //     [_photos addObject:photo];
    //    [self.photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    
    int maxCol = 3;
    CGFloat imageWH = (SCREEN_W-40)/3;
    CGFloat imageMargin = 10;
    CGRect lastphonoframe=CGRectZero;
    
    if (count==1) {
        
        lastphonoframe=CGRectMake(imageMargin, 10, imageWH, imageWH);
        
    }else{
        
        for (int i = 1; i<count; i++) {
            
            UIView *photoView = self.subviews[i];
            
            if ([photoView isKindOfClass:[UIImageView class]]) {
                int col = (i-1) % maxCol;
                photoView.originX = col * (imageWH + imageMargin)+imageMargin;
                
                int row = (i-1) / maxCol;
                photoView.originY = row * (imageWH + imageMargin)+10;
                photoView.frameWidth = imageWH;
                photoView.frameHeight= imageWH;
                
                lastphonoframe=CGRectMake( i % maxCol * (imageWH + imageMargin)+imageMargin, i / maxCol * (imageWH + imageMargin)+10, imageWH, imageWH);
                //第一张有主图标识
                if (i==1 && count!=1) {
                    UIImageView *mainImg = [[UIImageView alloc]init];
                    mainImg.image = [UIImage imageNamed:@"zhutu"];
                    [photoView addSubview:mainImg];
                    [mainImg mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(10);
                        make.width.offset(34);
                        make.height.offset(17);
                        make.bottom.offset(-7);
                    }];
                }
                
            }else{
                
            }
        }
    }
    self.btn.frame=lastphonoframe;
}

@end
