//
//  FirstViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

// ----------- 分页菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
// ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------

#import "BaseViewControllera.h"
#import "MJRefresh.h"

NSNotificationName const ChildScrollViewDidScrollNSNotification = @"ChildScrollViewDidScrollNSNotification";
NSNotificationName const ChildScrollViewRefreshStateNSNotification = @"ChildScrollViewRefreshStateNSNotification";

@interface BaseViewControllera ()

@property (nonatomic, strong) HeaderContentView *placeholderHeaderView;

@end

@implementation BaseViewControllera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.rowCount==0) {
        self.rowCount = 20;
    }
  
    self.tableView.tableHeaderView = self.placeholderHeaderView;
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
}

// 设置头视图
- (void)setHeaderView:(YSJTeacherHeaderView *)headerView {
    _headerView = headerView;
    CGRect headerFrame = self.headerView.frame;
    // 修正origin
    headerFrame.origin.y = 0;
    headerFrame.origin.x = 0;
    self.headerView.frame = headerFrame;
    [self.placeholderHeaderView addSubview:headerView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetDifference = scrollView.contentOffset.y - self.lastContentOffset.y;
    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ChildScrollViewDidScrollNSNotification object:nil userInfo:@{@"scrollingScrollView":scrollView,@"offsetDifference":@(offsetDifference)}];
    self.lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.rowCount);
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-bottomMargin) style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight =  10;
        _tableView.layer.masksToBounds = NO;
    }
    return _tableView;
}

- (HeaderContentView *)placeholderHeaderView {
    
    if (!_placeholderHeaderView) {
        _placeholderHeaderView = [[HeaderContentView alloc] init];
        _placeholderHeaderView.frame = CGRectMake(0, 0, kScreenW, kHeaderViewH+kPageMenuH);
    }
    return _placeholderHeaderView;
}


@end
