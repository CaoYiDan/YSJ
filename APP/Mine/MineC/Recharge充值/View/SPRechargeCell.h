//
//  SPRechargeCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SPRechargeCellID = @"SPRechargeCellID";

@class SPRechargeModel;

@interface SPRechargeCell : UICollectionViewCell

/**<##>模型*/
@property (nonatomic, strong)SPRechargeModel *rechargeModel;
/***/
@property(nonatomic,assign)NSInteger  indexRow;

@end
