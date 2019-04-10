//
//  SPMineNeededVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMineNeededVC.h"
#import "SPMineNeededTableViewCell.h"
#import "SPMineNeededModel.h"
#import "SPMineNeededDetailVC.h"
#import "SPFindPeopleAllCategoryVC.h"
@interface SPMineNeededVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    int _start;
    int _end;
}

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * myNeededTableView;

@end

@implementation SPMineNeededVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGBCOLOR(239, 239, 239);
    [self initNav];
    [self initUI];
    [self initFreshData];
    // Do any additional setup after loading the view.
}

#pragma mark - initFreshData

- (void)initFreshData{
    
    self.myNeededTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myNeededTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.myNeededTableView.mj_header beginRefreshing];
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
   
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    NSLog(@"%@",dict);
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [[HttpRequest sharedClient]httpRequestPOST:MyNeedListUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"我的需求%@",responseObject);
        NSMutableArray *arr = @[].mutableCopy;
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            SPMineNeededModel * model = [[SPMineNeededModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [arr addObject:model];
        }
        self.dataArr = arr;
        if (self.dataArr.count==0)
        {
            self.myNeededTableView.mj_footer.hidden = YES;
        }else
        {
            self.myNeededTableView.mj_footer.hidden = NO;
        }
        
        [_myNeededTableView reloadData];
        [_myNeededTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - getMoreData
- (void)getMoreData{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    NSLog(@"%@",dict);
    
    [[HttpRequest sharedClient]httpRequestPOST:MyNeedListUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的需求%@",responseObject);
        NSMutableArray *arr =  responseObject[@"data"];
        if (arr.count==0) {
            self.myNeededTableView.mj_footer.hidden = YES;
            
        }
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            SPMineNeededModel * model = [[SPMineNeededModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self.dataArr addObject:model];
        }
        [self.myNeededTableView.mj_footer endRefreshing];
        [self.myNeededTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - initUI
- (void)initUI{
    
    self.myNeededTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight - 100) style:UITableViewStylePlain];
    self.myNeededTableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.myNeededTableView.delegate=self;
    self.myNeededTableView.dataSource=self;
    
    //self.myNeededTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.myNeededTableView.backgroundColor = WC;
    self.myNeededTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myNeededTableView.showsHorizontalScrollIndicator = NO;
    self.myNeededTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.myNeededTableView];
    
    UIView * footView = [[UIView alloc]init];
    self.myNeededTableView.tableFooterView = footView;
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-SafeAreaTopHeight-100, SCREEN_W, 100)];
    bottomView.backgroundColor = WC;
    [self.view addSubview:bottomView];
    
    UIButton * pushSkillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushSkillBtn setBackgroundColor:RGBCOLOR(250, 28, 82)];
    [pushSkillBtn setTitle:@"发布需求" forState:UIControlStateNormal];
    [pushSkillBtn setTitleColor:WC forState:UIControlStateNormal];
    [pushSkillBtn addTarget:self action:@selector(pushSkillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pushSkillBtn];
    pushSkillBtn.frame = CGRectMake(30, 25, SCREEN_W-60, 35);
    pushSkillBtn.clipsToBounds = YES;
    pushSkillBtn.layer.cornerRadius = 4;
    
}

#pragma mark - pushSkillBtnClick发布需求
- (void)pushSkillBtnClick:(UIButton *)btn{
    
    //Toast(@"点击了发布需求");
    SPFindPeopleAllCategoryVC * findPeopleVC = [[SPFindPeopleAllCategoryVC alloc]init];
    
    [self.navigationController pushViewController:findPeopleVC animated:YES];
}

#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * myNeededCell = @"myNeededCell";
    
    //SPMineNeededTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPMineNeededTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SPMineNeededTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myNeededCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WC;
    }
    
    if (self.dataArr.count) {
        
        SPMineNeededModel * model = self.dataArr[indexPath.row];
        [cell initWithModel:model];
    }
    
    //[self.myNeededTableView reloadData];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //服务时间
    //CGFloat cellHeight = 100;//[SPLzsMySkillsTableViewCell initWithCellHeight:model];
    
    return 160;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SPMineNeededModel * model = self.dataArr[indexPath.row];
    SPMineNeededDetailVC * detailVC = [[SPMineNeededDetailVC alloc]init];
    WeakSelf;
    detailVC.block = ^(NSInteger indexRow) {
        [weakSelf.myNeededTableView.mj_header beginRefreshing];
    };
    
    detailVC.neededModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = @"我的需求";
    self.titleLabel.textColor = [UIColor blackColor];
}

#pragma mark -  lazyLoad
- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
