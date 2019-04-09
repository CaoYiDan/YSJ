//
//  SPDynamicSectionView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^homeSectionClick) (NSString *str);
@interface SPHomeSectionView : UIView
/**<##>nlock*/
@property(nonatomic,copy)homeSectionClick block;
@end

