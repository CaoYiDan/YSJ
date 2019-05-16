//
//  SPPublishLocationVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishLimitVC.h"
#import "SPChosedCell.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface SPPublishLimitVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,copy)NSString *resultStr;
@property(nonatomic ,copy)NSString *resultText;
@end

@implementation SPPublishLimitVC
{
    NSDictionary *_dic;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dic = @{@"0":@"ALL",@"1":@"FOLLOWER",@"2":@"ME"};
    
    [self addRightItem];
    
    [self.view addSubview:self.tableView];
    
    //初始化
    self.resultStr = _dic[[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
    self.resultText = self.listArray[self.selectedIndex];
    //选中
    NSIndexPath * index =  [NSIndexPath   indexPathForRow:self.selectedIndex inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:(UITableViewScrollPositionTop)];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPChosedCell*cell = [SPChosedCell cellWithTableView:tableView indexPath:indexPath];
    cell.textLabel.text = self.listArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = indexPath.row;
    
    self.resultText = self.listArray[indexPath.row];
    
    self.resultStr = _dic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    NSLog(@"%@",self.resultStr);
}

-(void)addRightItem{
    
    self.titleLabel.text = @"谁可以看见";
    
    UIButton*rightBtnItem= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 38)];
    [rightBtnItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchDown];
    [rightBtnItem setTitle:@"完成" forState:0];
    [rightBtnItem setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtnItem];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightItemClick{
    
    !self.publishLimitBLock?:self.publishLimitBLock(self.resultStr,self.resultText,self.selectedIndex);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark - setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = (NSMutableArray *)@[@"所有人可见",@"关注我的人可见",@"仅自己可见"];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        [_tableView registerClass:[SPChosedCell class] forCellReuseIdentifier:SPChosedCellID];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}


@end
