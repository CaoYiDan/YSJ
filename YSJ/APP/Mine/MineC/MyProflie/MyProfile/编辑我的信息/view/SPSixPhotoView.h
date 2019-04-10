//
//  SPSixPhotoView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"
typedef void(^sixPhotoViewBlock)(NSString *type,NSInteger tag);
@interface SPSixPhotoView : UIView <SDPhotoBrowserDelegate>
/**图片url数组*/
@property (nonatomic, strong)NSArray  *photosArr;
/**<#Name#>*/
@property(nonatomic,copy)sixPhotoViewBlock sixPhotoViewBlock;

-(void)changePhotos:(NSArray *)changImgArr;
@end
