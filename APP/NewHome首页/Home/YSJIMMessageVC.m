//
//  YSJIMMessageVC.m
//  SmallPig
//
//  Created by xujf on 2019/6/5.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJIMMessageVC.h"
#import "YSJOrderCourseView.h"
#import "NIMMessageCell.h"
#import "NIMSessionTimestampCell.h"
@interface YSJIMMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YSJIMMessageVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 102)];
//    view.backgroundColor = KWhiteColor;
//    self.tableView.tableHeaderView = view;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 此回调的 UITableViewCell 只可能回调 `NIMMessageCell` 和 `NIMSessionTimestampCell` 两种 cell
    NSLog(@"李森");
    if ([cell isKindOfClass:[NIMMessageCell class]])
    {
        //自定义 消息气泡 样式
        NIMMessageCell *ce = (NIMMessageCell*)cell;
        
        ce.nameLabel.textColor = [UIColor redColor];  //修改气泡昵称字体颜色
        
    }
    if ([cell isKindOfClass:[NIMSessionTimestampCell class]])
    {
        //自定义 消息时间戳 样式
        
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 102;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}

@end
