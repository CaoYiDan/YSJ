//
//  SPProfileDetailVC.h
//  SmallPig


#import <UIKit/UIKit.h>

typedef void(^profileBlocka) (NSDictionary *profileDic);

#import "BaseViewController.h"

@interface YSJTeacherCourseDetailVC : UIViewController

/**<##>code*/
@property(nonatomic,copy)NSString *code;

/**block*/
@property(nonatomic,copy)profileBlocka  block;

@end
