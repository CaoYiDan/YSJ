//
//  BaseViewController.h
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//  基类控制器

#import <UIKit/UIKit.h>
#import "YSJTeacherHeaderView.h"
#import "HeaderContentView.h"

#define kHeaderViewH 165
#define kPageMenuH 40
#define kNaviH 0

#define isIPhoneX kScreenH==812
#define bottomMargin (isIPhoneX ? (84+34) : 64)

UIKIT_EXTERN NSNotificationName const ChildScrollViewDidScrollNSNotification;
UIKIT_EXTERN NSNotificationName const ChildScrollViewRefreshStateNSNotification;

@interface BaseViewControllera : UIViewController  <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YSJTeacherHeaderView *headerView;
@property (nonatomic, assign) CGPoint lastContentOffset;

@property (nonatomic, assign) BOOL isFirstViewLoaded;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger rowCount;
@end
