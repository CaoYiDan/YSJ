//
//  SPLzsSwichVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/9/15.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

@protocol  LZS_SwitchVCDelegate

@required
-(NSArray<__kindof NSString *> *)titleArrInSwitchView;

@required
-(UIViewController*)swithchVCForRowAtIndex:(NSInteger)index;

@end
@interface SPLzsSwichVC : BaseViewController<LZS_SwitchVCDelegate>
/**代理*/
@property(nonatomic,weak)id <LZS_SwitchVCDelegate> delegate ;

-(void)ls_titleHeader;

@end
