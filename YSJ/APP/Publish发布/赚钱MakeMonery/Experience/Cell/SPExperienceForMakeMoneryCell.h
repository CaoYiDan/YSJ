//
//  SPExperienceCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPExperienceCellDelegate <NSObject>

/**
 <#Description#>

 @param indexPath cell所在indexPath
 @param type  0 ：开始时间 1 ：结束时间
 */
-(void)SPExperienceCellDelegateDidSelectedIndexPath:(NSIndexPath *)indexPath WithType:(NSInteger)type andStringType:(NSString *)stringType;
@end

@class SPSkillWorkExp;

static NSString *SPExperienceForMakeMoneryCellID = @"SPExperienceForMakeMoneryCellID";

@interface SPExperienceForMakeMoneryCell :UITableViewCell

/**<##>模型*/
@property (nonatomic, strong)SPSkillWorkExp *expModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**indexPath*/
@property(nonatomic,strong)NSIndexPath *indexPath;

/***/
@property(nonatomic,weak)id<SPExperienceCellDelegate>  delegate;

/**<##>公司输入框*/
@property (nonatomic, strong) UITextField *textFiledForCompany;

/**<##>职位输入框*/
@property (nonatomic, strong) UITextField *textFiledForJob;
@end
