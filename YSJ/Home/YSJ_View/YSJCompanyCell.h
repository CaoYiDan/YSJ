//
//  YSJCompanyCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJCompanysModel;
static NSString *YSJCompanyCellID = @"YSJCompanyCellID";
@interface YSJCompanyCell : UICollectionViewCell

@property (nonatomic,strong) YSJCompanysModel *model;

@end
