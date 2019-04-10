//
//  SPChooseCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPKungFuModel;
static NSString *const SPChooseCellID =@"SPChooseCellID";

@interface SPChooseCell : UITableViewCell
/**<##><#Name#>*/
@property(nonatomic,strong)SPKungFuModel *model;

@end
