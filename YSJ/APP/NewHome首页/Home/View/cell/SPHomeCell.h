//
//  SPHomeCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPNewHomeCellFrame,SPHomeModel,SPProfileDynamicFrame;

static NSString *SPHomeCellID = @"SPHomeCellID";

@interface SPHomeCell : UITableViewCell

//首页动态Frame
@property (nonatomic, strong) SPNewHomeCellFrame*statusFrame;
/**<#title#>*/
@property(nonatomic,assign)DynamicCellType  cellType;

//个人动态Frame
@property (nonatomic, strong) SPProfileDynamicFrame *profileStatusFrame;

@property (nonatomic, strong) SPHomeModel*statue;
/**<##>block回传*/
@property(nonatomic,copy) void(^block)(NSString *evaluateId);

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath;

@end

