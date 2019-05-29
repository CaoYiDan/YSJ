//
//  YSJCollectionVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSJCollectionVC : BaseViewController
/**
 用户身份
 */
@property (nonatomic,copy) NSString *identifier;

@property(nonatomic ,strong)UITableView *tableView;

@property (nonatomic,copy) NSString *city;

@property (nonatomic,assign) YSJMyPublishType cellType;

@end

NS_ASSUME_NONNULL_END
