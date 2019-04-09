//
//  SPActivityCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SPHotCollectionViewCellID = @"SPHotCollectionViewCellID";

@interface SPHotCollectionViewCell : UICollectionViewCell
/**<##>数据字典*/
@property (nonatomic, strong) NSDictionary *hotDict;
@end

