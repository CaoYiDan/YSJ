//
//  SPMyMessageTableCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/9/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPMyMessageModel.h"
@interface SPMyMessageTableCell : UITableViewCell

@property (nonatomic,strong) UIImageView * headIV;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * subtilteLab;
@property (nonatomic,strong) UILabel * timeTilteLab;
@property (nonatomic,strong) UIImageView * markIV;
@property (nonatomic,strong) UIImageView * otherHeadIV;
- (void)initWithModel:(SPMyMessageModel *)model withType:(NSInteger)number;
@end
