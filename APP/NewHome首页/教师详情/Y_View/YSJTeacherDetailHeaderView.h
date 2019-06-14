#import <UIKit/UIKit.h>
#import "YSJBaseForDetailView.h"

#define  profileHeight 195+32

typedef  void(^profileHeaderBlock) (NSString *action);

@class YSJTeacherModel;

@interface YSJTeacherDetailHeaderView : YSJBaseForDetailView

@property (nonatomic,strong) YSJTeacherModel *model;
/**<##>block*/
@property(nonatomic,copy)profileHeaderBlock block;
@end
