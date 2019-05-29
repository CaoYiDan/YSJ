//
//  LGComposePhotosView.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/15.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//
typedef  void(^btnblock)(NSInteger tag);

#import <UIKit/UIKit.h>

@interface YSJPhotosOtherView : UIView

@property(nonatomic,strong)UIButton*btn;

@property(nonatomic,copy)btnblock clickblock;

@property(nonatomic,strong)NSMutableArray *photosAsset;

-(void)setPhotoImg:(NSArray *)imgs;


@end
