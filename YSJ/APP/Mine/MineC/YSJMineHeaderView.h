//
//  SPNewDynamicHeaderView.h

#import <UIKit/UIKit.h>


#define  categotyH  98
#define  activityH  81
#define bgImgH  (240-20+SafeAreaStateHeight)

@protocol MineHeaderViewDelegate

-(void)mineHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index;

@end

@class YSJUserModel;

@interface YSJMineHeaderView: UIView

@property (nonatomic,strong) UIImageView *bgImgView;

@property (nonatomic,strong) NSMutableDictionary *numberDic;

@property (nonatomic,strong) YSJUserModel *model;

/**<##>代理*/
@property(nonatomic,weak)id<MineHeaderViewDelegate> delegate;

@end
