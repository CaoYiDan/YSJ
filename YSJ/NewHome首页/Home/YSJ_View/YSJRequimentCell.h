//
//  YSJRequimentCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJRequimentModel;

static NSString *YSJRequimentCellID = @"YSJRequimentCellID";

@interface YSJRequimentCell : UICollectionViewCell

@property (nonatomic,strong) YSJRequimentModel *model;

@end
