//
//  SPMineWalletDetailCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/12/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLzsMineWalletDetailModel.h"
@interface SPMineWalletDetailCell : UITableViewCell
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * moneyLab;
@property (nonatomic,strong) UILabel * timeTilteLab;

- (void)initWithModel:(SPLzsMineWalletDetailModel *)model;
@end
