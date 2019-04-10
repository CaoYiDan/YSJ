//
//  SPNewDynamicVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol SPNewDynamicReloadDelegate

-(void)SPNewDynamicReloadLocation;

@end

@interface SPNewDynamicVC : BaseViewController
/**<##>代理 让主页刷新位置信息*/
@property(nonatomic,weak)id<SPNewDynamicReloadDelegate> delegate;

-(void)reloadTableView;
@end
