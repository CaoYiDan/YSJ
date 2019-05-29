//
//  YSJChildProfileLeftVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class YSJUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface YSJChildProfileLeftVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) YSJUserModel *model;

@end

NS_ASSUME_NONNULL_END
