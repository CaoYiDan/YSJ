//
//  SPSelectionCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSelectionCell : UITableViewCell 
/**<##>数据数组*/
@property (nonatomic, strong)NSArray *listArr;
//cellType
@property (nonatomic,assign) YSJHomeCellType cellType;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andCellType:(YSJHomeCellType)ceType;
@end
