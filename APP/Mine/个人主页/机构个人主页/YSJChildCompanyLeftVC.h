//
//  YSJChildCompanyLeftVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/22.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"
@class YSJUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface YSJChildCompanyLeftVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) YSJUserModel *model;
@end

NS_ASSUME_NONNULL_END
