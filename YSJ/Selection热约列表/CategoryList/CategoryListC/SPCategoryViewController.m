//
//  SPCategoryViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCategoryViewController.h"
#import "SPSelectionCategoryTableViewCell.h"
#import "SPSelectionCategoryModel.h"
#import "SPProfileVC.h"

@interface SPCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    
    UITableView * _tableView;
    
    int _start;
    int _end;
}

@property (nonatomic,strong) SPSelectionCategoryModel * categoryModel;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property(nonatomic,strong)UILabel *noDataLab;
@end

@implementation SPCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    
    [self createUI];
    [self createRefresh];
    
}

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [SPCommon noDataLabelWithText:@"暂无数据" frame:CGRectMake(0, 100, SCREEN_W, 40)];
        [_tableView addSubview:_noDataLab];
    }
    return _noDataLab;
}

//返回
-(void)leftButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _tableView.mj_footer.hidden = YES;
    //
    [_tableView.mj_header beginRefreshing];
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
    self.dataArr = [[NSMutableArray alloc]init];
    NSString * kurl;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    if (!self.code) {//0是综合
        
        kurl = SeletionCategoryURL;
        [dict setObject:@"DEFAULT" forKey:@"sort"];
    }else{//1是距离
        
        kurl = SeletionCategoryURL;
        [dict setObject:@"DISTANCE" forKey:@"sort"];
    }
    
    //经纬度
    //NSDictionary * locationDict = @{@"lon":[StorageUtil getUserLon],@"lat":[StorageUtil getUserLat]};
//    NSDictionary * locationDict = @{@"lon":@"117.306848",@"lat":@"39.015593"};
//    NSLog(@"%@",locationDict);
    //技能
    NSArray * skillListArr = @[self.titleString];
    
    [dict setObject:skillListArr forKey:@"skillList"];
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@6 forKey:@"pageSize"];
    NSLog(@"%@ %@",dict,kurl);
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
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
        
        if (self.dataArr.count==0) {
            _tableView.mj_footer.hidden = YES;
            self.noDataLab.hidden = NO;
        }else{
            _tableView.mj_footer.hidden = NO;
            self.noDataLab.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getMoreData{
    
    
    //self.dataArr = [NSMutableArray arrayWithCapacity:0];
    NSString * kurl;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    if (!self.code) {//0是综合
        
        kurl = SeletionCategoryURL;
        [dict setObject:@"DEFAULT" forKey:@"sort"];
    }else{//1是距离
        
        kurl = SeletionCategoryURL;
        [dict setObject:@"DISTANCE" forKey:@"sort"];
    }
    
    //技能
    NSArray * skillListArr = @[self.titleString];
    
    [dict setObject:skillListArr forKey:@"skillList"];
    //经纬度
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@3 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
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
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

#pragma mark - createUI
- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, SCREEN_H-10-SafeAreaBottomHeight) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = WC;
    
    [self.view addSubview:_tableView];
    
    
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
}
@end
