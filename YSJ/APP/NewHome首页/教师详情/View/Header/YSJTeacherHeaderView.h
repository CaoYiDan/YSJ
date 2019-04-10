//
//  YSJTeacherHeaderView.h
//  SmallPig
//
//  Created by xujf on 2019/3/22.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSJTeacherModel,YSJCommonBottomView;
//#define kHeaderViewH 200
@interface YSJTeacherHeaderView : UIView
@property (nonatomic,strong) YSJTeacherModel *model;
@property (nonatomic,strong)  YSJCommonBottomView *bottomView;
@end
