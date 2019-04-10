//
//  SPMyBaseProfileVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class  SPUser;

@protocol SPEditMyProfileVCDelegate
-(void)backLastUser:(SPUser *)user;
@end

@interface SPEditMyProfileVC : BaseViewController
/**<##><#Name#>*/
@property (nonatomic, strong)SPUser *user;
/**代理回传*/
@property(nonatomic,weak) id <SPEditMyProfileVCDelegate> delegate;
@end

