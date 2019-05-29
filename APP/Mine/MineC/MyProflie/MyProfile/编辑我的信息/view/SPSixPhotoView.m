//
//  SPSixPhotoView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSixPhotoView.h"
#import "SDPhotoBrowser.h"

@implementation SPSixPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    CGFloat margin = 4;
    CGFloat unitWid =(self.frameWidth-4*margin)/3;
    
    for (int i=0; i<6; i++) {
        
        UIImageView *img = [[UIImageView alloc]init];
        img.backgroundColor = [UIColor whiteColor];
        img.userInteractionEnabled = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.tag = i;
        [self addSubview:img];
        
        //创建手势对象
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self   action:@selector(tapAction:)];
        //配置属性
        //轻拍次数
        tap.numberOfTapsRequired =1;
        //轻拍手指个数
        tap.numberOfTouchesRequired =1;
        //讲手势添加到指定的视图上
        [img addGestureRecognizer:tap];
    
        if (i==0) {
            img.frame = CGRectMake(margin, 0, 2*unitWid+5,2*unitWid+5);
            }else if (i==1){
            img.frame = CGRectMake(3*margin+2*unitWid, 0, unitWid,unitWid);
            }else if (i==2){
                img.frame = CGRectMake(3*margin+2*unitWid, unitWid+margin, unitWid,unitWid);
            }else if (i==3){
                img.frame = CGRectMake(margin,2*unitWid+2*margin, unitWid,unitWid);
            }else if (i==4){
                img.frame = CGRectMake(unitWid+2*margin,2*unitWid+2*margin , unitWid,unitWid);
            }else if (i==5){
                img.frame = CGRectMake(2*unitWid+3*margin,2*unitWid+2*margin, unitWid,unitWid);
            }
    }
}

-(void)setPhotosArr:(NSArray *)photosArr{
    _photosArr = photosArr;
    int i=0;
    
    for (UIImageView *img in self.subviews) {
        if (photosArr.count >i) {
            NSDictionary *dic  = photosArr[i];
            [img sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]]placeholderImage:[UIImage imageNamed:@"fb_jn_"]];
        }else{
            [img setImage:[UIImage imageNamed:@"fb_jn_"]];
        }
        i++;
    }
}

-(void)changePhotos:(NSArray *)changImgArr{
//    _photosArr = changImgArr;
    int i=0;
    for (UIImageView *img in self.subviews) {
        if (changImgArr.count >i) {
            
            [img sd_setImageWithURL:[NSURL URLWithString:changImgArr[i]]];
        }else{
            [img setImage:[UIImage imageNamed:@"fb_jn_"]];
        }
        i++;
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    
    UIView *img = tap.view;
    
    if (self.photosArr.count > img.tag ) {
//        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
//        photoBrowser.delegate = self;
//        photoBrowser.currentImageIndex = img.tag;
//        photoBrowser.imageCount = self.photosArr.count;
//        photoBrowser.sourceImagesContainerView = self;
//        [photoBrowser show];
         !self.sixPhotoViewBlock?:self.sixPhotoViewBlock(@"替换",img.tag);
    }else{
        !self.sixPhotoViewBlock?:self.sixPhotoViewBlock(@"添加",img.tag);
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSDictionary *dic = self.photosArr[index];
    NSString *urlString = dic[@"url"];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]init];
    NSDictionary *dic = self.photosArr[index];
    NSString *urlString = dic[@"url"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    return imageView.image;
}

@end
