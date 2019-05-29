//
//  SPKungFuCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPKungFuModel;
static NSString *const SPKungFuCellID = @"SPKungFuCellID";

@interface SPKungFuCell : UITableViewCell
/**<##>模型--在个人信息完善*/
@property (nonatomic, strong)SPKungFuModel *model;
/**<##>模型--在个人中心编辑*/
@property (nonatomic, strong)SPKungFuModel *model2;
//行数
@property(nonatomic ,assign)NSInteger indexRow;
//行数2
@property(nonatomic ,assign)NSInteger indexRow2;
@end
