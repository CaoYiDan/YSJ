//
//  SPCategoryViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSearchListVC.h"
#import "SPSelectionCategoryTableViewCell.h"
#import "SPSelectionCategoryModel.h"
#import "SPProfileVC.h"
#import "SPSearchView.h"

@interface SPSearchListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
    
    int _start;
    int _end;
}

@property (nonatomic,strong) SPSelectionCategoryModel * categoryModel;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation SPSearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    
    [self createUI];
    [self createRefresh];
    
    self.titleLabel.text = @"搜索结果";
    
//    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [leftButton setImage:[UIImage imageNamed:@"back"] forState:0];
//    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

//返回
-(void)leftButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadSearch)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //
    [_tableView.mj_header beginRefreshing];
    
    
}
//下拉刷新
- (void)loadSearch{
    
    
    _start = 1;
    //_end = 8;
    [self loadSearchData];
    
}
//上啦加载
- (void)loadMoreData{
    
    _start ++;
    //_end = _end +8;
    
    [self loadMoreSearchData];
    
}

#pragma mark - loadData
//搜索列表数据
-(void)loadSearchData{
    
    NSMutableDictionary *dic  = @{}.mutableCopy;
    [dic setObject:self.titleString forKey:@"content"];
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlSearchList parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"yuyue%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            SPSelectionCategoryModel * model = [[SPSelectionCategoryModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        
        self.dataArr =tempDataArr;
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        
        if (self.dataArr.count ==0) {
            Toast(@"不好意思，没有找到相关数据");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"错误");
        Toast(@"请求失败了");
    [_tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreSearchData{
    
    NSMutableDictionary *dic  = @{}.mutableCopy;
    [dic setObject:self.titleString forKey:@"content"];
    [dic setObject:@(_start) forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlSearchList parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"yuyue%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            SPSelectionCategoryModel * model = [[SPSelectionCategoryModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        
        if (self.dataArr.count ==0) {
            Toast(@"不好意思，没有找到相关数据");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"dff");
        Toast(@"请求失败了");
         [_tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - createUI

- (void)createUI{
    
    [self searchView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_W, SCREEN_H-42) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = WC;
    [self.view addSubview:_tableView];
}

-(void)searchView{
    
    SPSearchView *search = [[SPSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 42)];
    [search setSearchText:self.titleString];
    search.searchViewBlock = ^(NSString *searchText){
      
        self.titleString = searchText;
        [_tableView.mj_header beginRefreshing];
        
    };
    [self.view addSubview:search];
}

#pragma mark - tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPSelectionCategoryModel * model = self.dataArr[indexPath.row];
    if (model.tags.count>0&&model.skills.count>0) {
        
        return 370;
    }else if (model.tags.count>0||model.skills.count>0){
        
        return 310;
    }
    return 310;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellStr = @"SelectionCategoryCell";
    
    //SPSelectionCategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    SPSelectionCategoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SPSelectionCategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataArr) {
        
        SPSelectionCategoryModel * model = self.dataArr[indexPath.row];
        [cell initWithModel:model];
    }
    
    cell.clipsToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPSelectionCategoryModel*model = self.dataArr[indexPath.row];
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code = model.code;
    vc.titleName = model.nickName;
    
    [self.navigationController  pushViewController:vc animated:YES];
    
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}@end
