//
//  SPMineNeededTableViewCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPMineNeededModel.h"
@interface SPMineNeededTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel * needSkillLab;//需求技能
@property (nonatomic,strong)UILabel * honestMoneyLab;//诚意金
@property (nonatomic,strong)UILabel * needTimeLab;//发布时间
@property (nonatomic,strong)UILabel * needInfoLab;//需求描述
@property (nonatomic,strong)UILabel * needFinishLab;//成交
@property (nonatomic,strong)UIButton * flashDateBtn;//闪约
@property (nonatomic,strong)UIImageView * flashDateIV;//闪约

- (void)initWithModel:(SPMineNeededModel *)model;
@end
