#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol SPNewDynamicReloadDelegate

-(void)SPNewDynamicReloadLocation;

@end

@interface SPNewHomeVC : BaseViewController
/**<##>代理 让主页刷新位置信息*/
@property(nonatomic,weak)id<SPNewDynamicReloadDelegate> delegate;

-(void)reloadTableView;
@end
