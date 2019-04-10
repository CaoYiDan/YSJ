//
//  SPLzsGetAddressTableCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLzsGetAddressModel.h"
@interface SPLzsGetAddressTableCell : UITableViewCell
@property (nonatomic,strong) UIImageView * headIV;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * subtilteLab;
@property (nonatomic,strong) UILabel * timeTilteLab;
@property (nonatomic,strong) UIButton * communicateBtn;
@property (nonatomic,strong) UIImageView * btnIV;
- (void)initWithModel:(SPLzsGetAddressModel *)model withSection:(NSInteger )section ;
- (void)initWithDict:(NSMutableDictionary *)dict withSection:(NSInteger )section ;
@end
