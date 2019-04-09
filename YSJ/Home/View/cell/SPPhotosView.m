//
//  SPPhotosView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPhotosView.h"
#import "SDPhotoBrowser.h"

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
            [img sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"fb_jn_"]];
            
        }
//
        img.tag = i;
        [self addSubview:img];
        img.userInteractionEnabled = YES;
        if (i==2) {
            threeImg = img;
        }
//        //创建手势对象
//        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tap:)];
//        //配置属性
//        //轻拍次数
//        tap.numberOfTapsRequired =1;
//        //轻拍手指个数
//        tap.numberOfTouchesRequired =1;
//        //讲手势添加到指定的视图上
//        [img addGestureRecognizer:tap];
    }
    
    if (imgArr.count>3) {
        [threeImg addSubview:self.moreImg];
        [self.moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
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
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *urlString = self.imgArr[index];
//    return [NSURL URLWithString:urlString];
//}
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    UIImageView *imageView = self.subviews[index];
//    return imageView.image;
//}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    int i =0;
    
    CGFloat icon2= (SCREEN_W-2*kMargin-kMiddleMargin)/2;
    CGFloat iconW3 = (SCREEN_W-3*kMargin-60-2*kMiddleMargin)/3;
    
    for (UIImageView *img in self.subviews) {
        if (self.imgArr.count == 1) {
            
            img.frame = CGRectMake(kMargin, 0, icon2, self.frameHeight);
            
        }else if (i<3){
            
            img.frame = CGRectMake(i*(iconW3+kMiddleMargin), 0, iconW3, iconW3);
            
        }else{
            
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
