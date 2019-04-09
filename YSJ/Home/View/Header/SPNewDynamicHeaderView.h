//
//  SPNewDynamicHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  bannerHeight (SCREEN_W-2*kMargin)/700*300
#define  categotyH  98
#define  activityH  140

@protocol SPNewDynamicHeaderViewDelegate

-(void)SPNewDynamicHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index;

@end

@interface SPNewDynamicHeaderView : UIView 
//轮播图图片数组
@property(nonatomic,strong)NSMutableArray *bannerImgArr;
//测试
@property (nonatomic,copy) NSString *testBannerUrl;
//广播数组
@property(nonatomic,strong)NSMutableArray *boradArr;
//活动数组
@property(nonatomic,strong)NSMutableArray *activityArr;
/**<##>代理*/
@property(nonatomic,weak)id<SPNewDynamicHeaderViewDelegate> delegate;

@end
