//
//  SPHomeCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class SPNewHomeCellFrame,SPHomeModel,SPProfileDynamicFrame;
//
@class SPLeaseModel;
static NSString *SPLeaseCellID = @"SPLeaseCellID";

@protocol SPLeaseCellDelegate <NSObject>

/**
  点击按钮 代理回传

 @param indexRow 第几行Cell
 @param type 即按钮的text

 */
-(void)SPLeaseCellSelectedIndex:(NSInteger)indexRow andType:(NSString *)type;

@end

@interface SPLeaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath;

/**模型*/
@property (nonatomic, strong)SPLeaseModel *leaseM;

/**lease类型*/
@property(nonatomic,copy)NSString*leaseType;

/**行数*/
@property(nonatomic,assign)NSInteger  indexRow;

/**代理*/
@property(nonatomic,weak)id <SPLeaseCellDelegate>  delegate;


@end

