//
//  YSJStudentInfoView.h
//  SmallPig
//
//  Created by xujf on 2019/4/8.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"
@class YSJRequimentModel;
@interface YSJStudentInfoView:SPBasePopView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) YSJRequimentModel *model;

@end
