//
//  YSJChildForCareVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSJChildForCareVC : BaseViewController
/**
 用户身份
 */
@property (nonatomic,copy) NSString *identifier;

@property(nonatomic ,strong)UITableView *tableView;

/**
 私教  机构
 */
@property (nonatomic,copy) NSString *type;

@property (nonatomic,assign) YSJMyPublishType cellType;

@end

NS_ASSUME_NONNULL_END
