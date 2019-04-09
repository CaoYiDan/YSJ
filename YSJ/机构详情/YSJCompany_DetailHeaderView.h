#import <UIKit/UIKit.h>
#import "YSJBaseForDetailView.h"
#define  profileHeight 230

@class YSJCompanysModel,YSJCommonBottomView;

@interface YSJCompany_DetailHeaderView : YSJBaseForDetailView

@property (nonatomic,strong) YSJCompanysModel *model;

@property (nonatomic,strong)  YSJCommonBottomView *bottomView;
@end
