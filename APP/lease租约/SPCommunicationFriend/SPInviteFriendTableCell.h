//
//  SPInviteFriendTableCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPIviteModel.h"
@interface SPInviteFriendTableCell : UITableViewCell
@property (nonatomic,strong) UIImageView * headIV;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * subtilteLab;
@property (nonatomic,strong) UILabel * timeTilteLab;
@property (nonatomic,strong) UIButton * communicateBtn;
@property (nonatomic,strong) UIImageView * btnIV;
- (void)initWithModel:(SPIviteModel *)model ;
@end
