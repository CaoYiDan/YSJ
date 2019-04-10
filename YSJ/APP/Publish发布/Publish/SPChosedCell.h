//
//  SPChosedCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SPChosedCellID = @"SPChosedCellID";

@interface SPChosedCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
-(void)setSelected;
@end
