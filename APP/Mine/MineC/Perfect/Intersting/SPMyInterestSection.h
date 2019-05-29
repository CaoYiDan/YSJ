//
//  SPMyInterestSection.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMyInterestSection : UIView
/**<##>title*/
@property(nonatomic,copy)NSString*title;
/**<##>箭头*/
@property (nonatomic, strong) UIImageView *arrow;//箭头;
/**<##>箭头 上下*/
@property(nonatomic,copy)NSString*flag;
//字体颜色
@property(nonatomic,strong)UIColor *baseColor;

@end
