//
//  LS_SwitchVC.h
//  LS_Small_Switch
//
//  Created by 融合互联-------lisen on 17/6/22.
//  Copyright © 2017年 RTWM. All rights reserved.
//

#import "BaseViewController.h"
#import "LS_SwitchVC.h"
@protocol  LS_SwitchVCDelegate

@required
-(NSArray<__kindof NSString *> *)titleArrInSwitchView;

@required
-(UIViewController*)swithchVCForRowAtIndex:(NSInteger)index;

@end

@interface LS_SwitchVC : BaseViewController <LS_SwitchVCDelegate>
/**代理*/
@property(nonatomic,weak)id <LS_SwitchVCDelegate> delegate ;

-(void)ls_titleHeader;
@end
