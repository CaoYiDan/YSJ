//
//  SPSelectionCategoryTableViewCell.h
//  SmallPig
//
//  Created by 李智帅 on 2017/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSelectionCategoryModel.h"
#import "SPSelectionCategoryView.h"

@interface SPSelectionCategoryTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton * chatBtn;//左边是沟通
@property(nonatomic,strong)UIButton * focusBtn;//右边是关注
@property(nonatomic,strong)SPSelectionCategoryView * topView;
@property(nonatomic,copy) NSString * codeStr;
- (void)initWithModel:(SPSelectionCategoryModel *)model;

@end
