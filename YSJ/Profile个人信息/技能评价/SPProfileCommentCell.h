//
//  LGEvaluateCell.h
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPProfileCommentFrame ;

static NSString *SPProfileCommentCellID = @"SPProfileCommentCellID";

@interface SPProfileCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  SPProfileCommentFrame*statusFrame;

/**<##><#Name#>*/
@property(nonatomic,copy) void(^block)(NSString *evaluateId);
@end

