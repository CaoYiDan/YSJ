//
//  SPProfileDynamicToolView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPDynamicModel;
@interface SPProfileDynamicToolView : UIView
+ (instancetype)toolbar;
/**<##>model*/
@property (nonatomic, strong)SPDynamicModel *model;

@end
