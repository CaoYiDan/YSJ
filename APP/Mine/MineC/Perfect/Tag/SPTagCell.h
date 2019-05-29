//
//  SPTagCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//


#import <UIKit/UIKit.h>
@class  SPKungFuModel;

static NSString *const SPTagCellID = @"SPTagCellID";

@interface SPTagCell : UITableViewCell
/**<##>模型*/
@property (nonatomic, strong)SPKungFuModel *model;
//行数
@property(nonatomic ,assign)NSInteger indexRow;

-(void)setMyCenterModel:(SPKungFuModel *)model;
@end
