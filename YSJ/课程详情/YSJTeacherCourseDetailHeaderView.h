//
//  SPProfileDetailHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  banHeight SCREEN_W*(164.0/375.0)

#define  proHeight 320

typedef  void(^profileHeaderBlockq) ();

@class YSJTeacherModel;

@interface YSJTeacherCourseDetailHeaderView : UIView
//轮播图图片数组
@property(nonatomic,strong)NSMutableArray *bannerImgArr;
/**<##>模型*/
@property (nonatomic, strong)YSJTeacherModel *profileM;
/**<##>header类型 0 查看他人详情  1 查看自己的个人详情*/
@property(nonatomic,assign)NSInteger type;

/**<##>block*/
@property(nonatomic,copy)profileHeaderBlockq block;
@end
