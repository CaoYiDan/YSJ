//
//  YSJBaseForDetailView.h
//  SmallPig
//
//  Created by xujf on 2019/4/3.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  bannerHeight (SCREEN_W*(205.0/375.0))+15

@interface YSJBaseForDetailView : UIView
//轮播图图片数组
@property(nonatomic,strong)NSMutableArray *bannerImgArr;
@property (nonatomic,strong) UIView *profileV;
-(void)setProfileView;
@end
