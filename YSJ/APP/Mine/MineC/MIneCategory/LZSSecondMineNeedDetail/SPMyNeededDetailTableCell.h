//
//  SPMyNeededDetailTableCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPMineNeededDetailModel.h"
@protocol SkillsCellDelegate <NSObject>

- (void)sendMessageBtnClickForVC:(SPMineNeededDetailModel *)model;
- (void)getMoneyBtnClickForVC:(SPMineNeededDetailModel *)model;

@end

@interface SPMyNeededDetailTableCell : UITableViewCell
@property (nonatomic,strong)SPMineNeededDetailModel * model;
@property (nonatomic,strong)UIImageView * headIV;//技能图片
@property (nonatomic,strong)UIImageView * skillIV;//技能认证图片
@property (nonatomic,strong)UIImageView * identiIV;//身份认证图片
@property (nonatomic,strong)UIImageView * iphoneIV;//手机认证图片
@property (nonatomic,strong)UILabel * modelLab;//模特和级别
@property (nonatomic,strong)UILabel * serPriceLab;//服务价格
@property (nonatomic,strong)UILabel * delStutasLab;//成交状态
@property (nonatomic,strong)UILabel * nickNameLab;//昵称
@property (nonatomic,strong)UILabel * serTimeLab;//服务时间
@property (nonatomic,strong)UILabel * serInfoLab;//服务介绍
@property (nonatomic,strong)UILabel * farAwayLab;//距离
@property (nonatomic,strong)UIButton * getMoneyBtn;//赚钱状态
@property (nonatomic,strong)UIButton * changeBtn;//修改
@property (nonatomic,strong)UIButton * sendMessageBtn;//删除
//@property (nonatomic,strong)UIView * backView;

@property (nonatomic,weak)id<SkillsCellDelegate>delegate;
- (void)initWithModel:(SPMineNeededDetailModel *)model;
+ (CGFloat)initWithCellHeight:(SPMineNeededDetailModel *)model;
@end
