//
//  SPMyInterestCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/9.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPKungFuModel;

static NSString *const SPMyInterestCellID = @"SPMyInterestCellID";

@interface SPMyInterestCell : UICollectionViewCell
/**<##>模型*/
@property (nonatomic, strong)SPKungFuModel *model;
/**<##>字体背景颜色*/
@property (nonatomic, strong) UIColor *baseColor;

@end
