//
//  SPPhotosView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//
//#import "GKPhotoBrowser.h"

#import "YSJVideoShowVC.h"
#import "SPPhotosView.h"
#import "SDPhotoBrowser.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
@interface SPPhotosView() <SDPhotoBrowserDelegate>

@property(nonatomic,strong)UIImageView *moreImg;

@end

@implementation SPPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self sUI];
    }
    return self;
}

-(void)sUI{
 
}

-(void)setImgArr:(NSArray *)imgArr{
    
    _imgArr = imgArr;
    
    UIImageView *threeImg = nil;
    
    dispatch_group_t group =dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    
  
    for (int i =0; i<imgArr.count; i++) {
        
        NSLog(@"%@",imgArr);
        UIImageView *img = [[UIImageView alloc]init];
        
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        
        NSObject *object = imgArr[i];
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = (NSDictionary *)object;
            [img sd_setImageWithURL:[NSURL URLWithString:dict[@"url"]]placeholderImage:[UIImage imageNamed:@"fb_jn_"]];
            
        }else{
            
            NSString *str = (NSString *)object;
            
            if ([str containsString:@".mp4"]) {
                
                dispatch_group_enter(group);
                
                dispatch_group_async(group, globalQueue, ^{
                    
                    UIImage *img1 = [SPCommon thumbnailImageForVideo:[NSURL URLWithString:str] atTime:0];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [img setImage:img1];
                        
                        UIImageView*playImageView = [[UIImageView alloc] init];
                        playImageView.image = [UIImage imageNamed:@"zl_playVideo"];
                        [img addSubview:playImageView];
                        [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.width.offset(30);
                            make.height.offset(30);
                            make.center.equalTo(img).offset(0);
                        }];
                        dispatch_group_leave(group);
                        //回调或者说是通知主线程刷新，
                    });
                });
                
               
                
            }else{
                
              [img sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"fb_jn_"]];
            }
        }
        
        img.tag = i;
        [self addSubview:img];
        img.userInteractionEnabled = YES;
        if (i==2) {
            threeImg = img;
        }
//        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tap:)];
        //配置属性
        //轻拍次数
        tap.numberOfTapsRequired =1;
        //轻拍手指个数
        tap.numberOfTouchesRequired =1;
        //讲手势添加到指定的视图上
        [img addGestureRecognizer:tap];
    }
    
//    if (imgArr.count>3) {
//
//    }
}


-(void)tap:(UITapGestureRecognizer*)gesture{

     UIImageView *img = (UIImageView *)gesture.view;
    
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = img.tag;
    photoBrowser.imageCount = _imgArr.count;
    photoBrowser.sourceImagesContainerView = img.superview;
    [photoBrowser show];
}

//#pragma mark - SDPhotoBrowserDelegate
//

- (NSString *)photoBrowser:(SDPhotoBrowser *)browser stringUrlForIndex:(NSInteger)index{
    return   self.imgArr[index];
    
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.imgArr[index];
   
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    int i =0;
    
    CGFloat icon2= (SCREEN_W-2*kMargin-kMiddleMargin)/2;
    CGFloat iconW3 = (SCREEN_W-3*kMargin-60-2*kMiddleMargin)/3;
    
    for (UIImageView *img in self.subviews) {
        if (self.imgArr.count == 1) {
            
            img.frame = CGRectMake(kMargin, 0, icon2, self.frameHeight);
            
        }else {
        
             img.frame = CGRectMake(i%3*(iconW3+kMiddleMargin),(iconW3+kMiddleMargin)*(i/3) , iconW3, iconW3);
//            img.frame = CGRectMake(0, 0, 0, 0 );
        }
        i++;
        }
}

//更多的图片
-(UIImageView*)moreImg{
    if (!_moreImg) {
        _moreImg = [[UIImageView alloc]init];
        [_moreImg setImage:[UIImage imageNamed:@"fx_tj"]];
    }
    return _moreImg;
}
@end
