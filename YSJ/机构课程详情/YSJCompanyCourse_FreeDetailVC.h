
#import <UIKit/UIKit.h>
@class YSJCourseModel;
typedef void(^profileBlock) (NSDictionary *profileDic);

#import "BaseViewController.h"

@interface YSJCompanyCourse_FreeDetailVC: BaseViewController

/**<##>courseID*/
@property(nonatomic,copy)NSString *courseID;

/**block*/
@property(nonatomic,copy)profileBlock  block;

@property (nonatomic,strong) YSJCourseModel *M;

@end
