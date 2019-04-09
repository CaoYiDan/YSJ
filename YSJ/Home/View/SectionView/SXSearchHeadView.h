//
//  SXSearchHeadView.h
//  News Of History
//
//  Created by qingyun on 16/9/28.
//  Copyright © 2016年 付耀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXSearchHeadView : UIView

@property (nonatomic,strong) void(^titleBlock)(NSInteger);
@property (nonatomic,strong) NSString *peomType;
@property (nonatomic,strong) void(^selectBlock)(NSString *);
//处于搜索状态时显示的tableView
@property (nonatomic,strong) UITableView *searchTableView;

@property (nonatomic,strong) UIButton *formButton;
@property (nonatomic,strong) UIButton *dataButton;
@property (nonatomic,strong) UIButton *dynastyButton;

//当前button的值
@property (nonatomic,assign) NSInteger selectIndex;

//标识当前选中的button下标
@property(nonatomic)NSUInteger preIndex;

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)DataSource;


@end
