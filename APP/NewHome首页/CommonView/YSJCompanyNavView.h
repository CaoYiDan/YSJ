//
//  YSJCompanyNavView.h
//  SmallPig

#import <UIKit/UIKit.h>
@protocol NavDelegate
-(void)navViewSelectedBtn:(UIButton *)btn;
@end

@interface YSJCompanyNavView : UIView
/**代理*/
@property(nonatomic,weak) id<NavDelegate> delegate;
//设置是否关注
@property (nonatomic,assign) BOOL care;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL tittleHiden;
//YES ->”关注“ NO -> "收藏"
@property (nonatomic,assign) BOOL isCare;
@end
