//
//  SPUserNavTitleView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPDynamicModel;
@interface SPUserNavTitleView : UIView
/**模型*/
@property (nonatomic, strong)SPDynamicModel *model;

-(void)setDict:(NSDictionary *)dict;
@property(nonatomic, assign) CGSize intrinsicContentSize;
@end
