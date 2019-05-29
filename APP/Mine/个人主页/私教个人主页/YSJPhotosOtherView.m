//
//  LGComposePhotosView.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/15.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "YSJPhotosOtherView.h"
#import "YSJDeleteImgV.h"

@implementation YSJPhotosOtherView
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
    
    [btn setImage:[UIImage imageNamed:@"addsen"] forState:UIControlStateNormal];
    btn.tag = 120;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    self.btn=btn;
    [self addSubview:btn];
}

-(void)click{
    self.clickblock(110);
}

-(void)setPhotoImg:(NSArray *)imgs{
    
    for (UIView *vi in self.subviews) {
        if (vi.tag!=120) {
            [vi removeFromSuperview];
        }
    }

    int i=0;
    
    for (NSString *url in imgs) {
        
        YSJDeleteImgV *photoView = [[YSJDeleteImgV alloc] init];
        photoView.url = url;
        [photoView.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url]]];
        photoView.tag = i;
        WeakSelf;
        photoView.deleteblock = ^(NSInteger tag){
           weakSelf.clickblock((_iconW+30)*(imgs.count/3+1));
        };
        photoView.clipsToBounds = YES;
        [self addSubview:photoView];
        i++;
    }
    
  self.clickblock((_iconW+30)*(imgs.count/3+1));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    NSLog(@"个数%lu",(unsigned long)count);
    int maxCol = 3;
    
    CGFloat imageWH = (SCREEN_W-40-kMargin*2)/3;
    
    CGFloat imageMargin = 10;
    CGRect lastphonoframe=CGRectZero;
    
    if (count==1) {
        
     lastphonoframe=CGRectMake(imageMargin+5, 15, imageWH-5, imageWH-5);
        
    }else{
        
        for (int i = 1; i<count; i++) {
            
            UIView *photoView = self.subviews[i];
            
            if ([photoView isKindOfClass:[YSJDeleteImgV class]]) {
                int col = (i-1) % maxCol;
                photoView.originX = col * (imageWH + imageMargin)+imageMargin;
                
                int row = (i-1) / maxCol;
                photoView.originY = row * (imageWH + imageMargin)+10;
                photoView.frameWidth = imageWH;
                photoView.frameHeight= imageWH;
                
                lastphonoframe=CGRectMake( i % maxCol * (imageWH + imageMargin)+imageMargin, i / maxCol * (imageWH + imageMargin)+10, imageWH, imageWH);
              
            }else{
                
            }
        }
    }
    self.btn.frame=CGRectMake(lastphonoframe.origin.x+5, lastphonoframe.origin.y+5, lastphonoframe.size.width-10, lastphonoframe.size.height-10);
}

@end
