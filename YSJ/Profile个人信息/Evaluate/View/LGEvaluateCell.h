//
//  LGEvaluateCell.h
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGEvaluateStatusFrame ;

static NSString *LGEvaluateCellID = @"LGEvaluateCellID";

@interface LGEvaluateCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) LGEvaluateStatusFrame *statusFrame;

/**<##><#Name#>*/
@property(nonatomic,copy) void(^block)(NSString *evaluateId);
@end
