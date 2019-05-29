//
//  SPSecondMineFocusVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSecondMineFocusVC.h"
#import "HomeModel.h"
#import "SPProfileVC.h"
#import "SPMyFoucsTableCell.h"
#import "SPKitExample.h"
@interface SPSecondMineFocusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
    
    int _start;
    int _end;
}

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation SPSecondMineFocusVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    
    [self createUI];
    
    [self createRefresh];
    
    // Do any additional setup after loading the view.
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //
    [_tableView.mj_header beginRefreshing];
    //_tableView.mj_footer.hidden =YES;
    
}
//下拉刷新
- (void)loadNewData{
    
    
    _start = 1;
    //_end = 8;
    [self loadData];
    
}
//上啦加载
- (void)loadMoreData{
    
    _start ++;
    //_end = _end +8;
    
    NSLog(@"%zd,%zd",_end,_start);
    
    [self getMoreData];
    
}

#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    NSString * kurl;
    if (!self.code) {//0是我的预约  我的关注
        
        kurl = MineFollowUrl;
    }else{
        
        kurl = FollowMineUrl;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"关注%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        if (self.dataArr.count==0) {
            Toast(@"暂无数据");
            [self haveNoMessage];
            _tableView.hidden = YES;
        }else{
        
            _tableView.hidden = NO;
            _tableView.mj_footer.hidden = NO;
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        
        //        NSNumber *pages = responseObject[@"pages"];
        //        NSNumber *pageNum = responseObject[@"pageNum"];
        //        if ([pages integerValue] == [pageNum integerValue]) {
        //            _tableView.mj_footer.hidden = YES;
        //        }else{
        //            _tableView.mj_footer.hidden = NO;
        //        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - haveNoMessage
- (void)haveNoMessage{
    
    UILabel * messageLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-30, SCREEN_H/2-15, 60, 30)];
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = Font(14);
    messageLab.textColor = [UIColor lightGrayColor];
    messageLab.text = @"暂无数据";
    [self.view addSubview:messageLab];
}

- (void)getMoreData{
    
    NSString * kurl;
    
    if (!self.code) {//0是 我的关注
        
        kurl = MineFollowUrl;
    }else{// 关注我的
        
        kurl = FollowMineUrl;
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        if (tempArr.count==0) {
            Toast(@"已到底了");
            _tableView.mj_footer.hidden = YES;
            return ;
        }
        
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        [_tableView reloadData];
        
        [_tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_tableView.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark - createUI
- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-40)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = WC;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UIView * footView = [[UIView alloc]init];
    _tableView.tableFooterView = footView;
    [self.view addSubview:_tableView];

    
}
#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * myFoucsCell = @"myFoucsCell";
    
    //SPMineNeededTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPMyFoucsTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SPMyFoucsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myFoucsCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WC;
    }
    
    if (self.dataArr.count) {
        if (self.dataArr) {
            
            HomeModel * model = self.dataArr[indexPath.row];
            [cell refreshUI:model withCode:self.code];
        }
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    //服务时间
    //CGFloat cellHeight = 100;//[SPLzsMySkillsTableViewCell initWithCellHeight:model];
    
    return 60;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转到个人详细
    HomeModel *model = self.dataArr[indexPath.row];
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.titleName = model.nickName;
    vc.code = model.code;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}
@end
