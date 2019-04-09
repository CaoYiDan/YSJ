//
//  SPProfileDetailHeaderView.h
//  SmallPig


#import <UIKit/UIKit.h>

#define  bannerHeight (SCREEN_W*(205.0/375.0))+15

#define  profileHeight 195

#define  visterHeight 80

#define  bottomToolHeight 60

typedef  void(^profileHeaderBlock) ();

@class YSJTeacherModel;

@interface SPProfileDetailHeaderView : UIView
//轮播图图片数组
@property(nonatomic,strong)NSMutableArray *bannerImgArr;
/**<##>模型*/
@property (nonatomic, strong)YSJTeacherModel *profileM;
/**<##>header类型 0 查看他人详情  1 查看自己的个人详情*/
@property(nonatomic,assign)NSInteger type;

/**<##>block*/
@property(nonatomic,copy)profileHeaderBlock block;
@end
