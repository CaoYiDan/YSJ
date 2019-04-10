//
//  SPPersonalDynamicCollectionVCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/9/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface SPPersonalDynamicCollectionVCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * headIV;
@property (nonatomic,strong) UILabel * nickLab;

- (void)initWithModel:(HomeModel *)model AndCount:(NSInteger)number;
@end
