//
//  SPMyFoucsTableCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface SPMyFoucsTableCell : UITableViewCell
@property (nonatomic,strong) UIImageView * headIV;//
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UIImageView * focusStatusIV;

- (void)refreshUI:(HomeModel *)model withCode:(NSInteger)code;
@end
