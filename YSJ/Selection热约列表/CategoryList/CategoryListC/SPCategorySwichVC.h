//
//  SPCategorySwichVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/8/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"
#import "SPCategorySwichVC.h"
@protocol  LS_SwitchVCDelegate

@optional
-(NSArray<__kindof NSString *> *)titleArrInSwitchView;

@optional
-(UIViewController*)swithchVCForRowAtIndex:(NSInteger)index;

@end

@interface SPCategorySwichVC : BaseViewController<LS_SwitchVCDelegate>
/**代理*/
@property(nonatomic,weak)id <LS_SwitchVCDelegate> delegate ;

@property(nonatomic,copy)NSString * titleString;

-(void)ls_titleHeader;

- (void)createNav;



@end
