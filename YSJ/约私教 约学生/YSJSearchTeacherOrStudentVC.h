//
//  YSJSearchTeacherVC.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface YSJSearchTeacherOrStudentVC : BaseViewController

@property(nonatomic ,strong)UITableView *tableView;

@property (nonatomic,copy) NSString *city;

@property (nonatomic,assign) YSJHomeCellType cellType;

@end
