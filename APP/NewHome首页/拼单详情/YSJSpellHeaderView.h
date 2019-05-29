#import <UIKit/UIKit.h>
#import "YSJBaseForDetailView.h"

#define  profileHeight 205

@class YSJCourseModel,YSJCommonBottomView;

@interface  YSJSpellHeaderView: YSJBaseForDetailView

@property (nonatomic,strong) YSJCourseModel *model;

@property (nonatomic,strong)  YSJCommonBottomView *bottomView;
@end
