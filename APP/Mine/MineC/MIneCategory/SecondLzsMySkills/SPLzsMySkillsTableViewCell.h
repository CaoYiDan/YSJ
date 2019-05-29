//
//  SPLzsMySkillsTableViewCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLzsMySkillModel.h"
@protocol SkillsCellDelegate <NSObject>

- (void)deleteBtnClickForVC:(SPLzsMySkillModel *)model;
- (void)changeBtnClickForVC:(SPLzsMySkillModel *)model;
- (void)finishTextWithChangeClick:(SPLzsMySkillModel *)model;

@end
@interface SPLzsMySkillsTableViewCell : UITableViewCell
@property (nonatomic,strong)SPLzsMySkillModel * model;
@property (nonatomic,strong)UIImageView * headIV;//技能图片
@property (nonatomic,strong)UIImageView * skillIV;//技能认证图片
@property (nonatomic,strong)UIImageView * honestMoneyIV;//保证金图标
@property (nonatomic,strong)UILabel * modelLab;//模特和级别
@property (nonatomic,strong)UILabel * serPriceLab;//服务价格
@property (nonatomic,strong)UILabel * getMoneyStatusLab;//赚钱状态变更
@property (nonatomic,strong)UILabel * createTimeLab;//创建时间
@property (nonatomic,strong)UILabel * serTimeLab;//服务时间
@property (nonatomic,strong)UILabel * serInfoLab;//服务介绍
@property (nonatomic,strong)UILabel * serGoodLab;//服务优势
@property (nonatomic,strong)UIButton * getMoneyBtn;//赚钱状态
@property (nonatomic,strong)UIButton * changeBtn;//修改
@property (nonatomic,strong)UIButton * deleteBtn;//删除
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,weak)id<SkillsCellDelegate>delegate;
- (void)initWithModel:(SPLzsMySkillModel *)model;
+ (CGFloat)initWithCellHeight:(SPLzsMySkillModel *)model;

@end
