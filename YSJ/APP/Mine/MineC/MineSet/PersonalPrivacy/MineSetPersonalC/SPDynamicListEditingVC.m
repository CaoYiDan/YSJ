//
//  SPDynamicListEditingVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicListEditingVC.h"
#import "HomeModel.h"
#import "SPDynamicEditingTableCell.h"
@interface SPDynamicListEditingVC ()<UITableViewDataSource, UITableViewDelegate>
{

    int _pageNum;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *selectArray;

@end

@implementation SPDynamicListEditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self initNav];
    [self initUI];
    [self createRefresh];
    // Do any additional setup after loading the view.
}
#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
    
    
}
//下拉刷新
- (void)loadNewData{
    
    _pageNum = 1;
    [self loadData];
    
}

//加载更多
- (void)loadMoreData{
    
    _pageNum++;
    [self getMoreData];
}

#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    self.selectArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString * kurl;
    if ([self.titleStr isEqualToString:@"不让他看我的动态"]) {
        if ([self.editingStr isEqualToString:@"删除"]) {
            [dict setObject:@2 forKey:@"relation"];
            kurl = PrivacyListUrl;

        }else if ([self.editingStr isEqualToString:@"添加"]){
            kurl = listNotReadMeAddUrl;
            [dict setObject:@(_pageNum) forKey:@"pageNum"];
            [dict setObject:@10 forKey:@"pageSize"];
            
        }
    }else{//  不看他的动态
        
        if ([self.editingStr isEqualToString:@"删除"]) {
            [dict setObject:@1 forKey:@"relation"];
            kurl = PrivacyListUrl;
            
        }else if ([self.editingStr isEqualToString:@"添加"]){
            kurl = listNotReadOtherAddUrl;
            [dict setObject:@(_pageNum) forKey:@"pageNum"];
            [dict setObject:@2 forKey:@"pageSize"];
            
        }
        
    }
    
    WeakSelf;
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        NSLog(@"添加删除%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [weakSelf.dataSourceArray addObjectsFromArray:tempDataArr];
        //NSLog(@"dataArr%@",self.dataArr);
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

#pragma mark - getMoreData
- (void)getMoreData{

    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString * kurl;
    if ([self.titleStr isEqualToString:@"不让他看我的动态"]) {
        if ([self.editingStr isEqualToString:@"删除"]) {
            [dict setObject:@2 forKey:@"relation"];
            kurl = PrivacyListUrl;
            
        }else if ([self.editingStr isEqualToString:@"添加"]){
            kurl = listNotReadMeAddUrl;
            [dict setObject:@(_pageNum) forKey:@"pageNum"];
            [dict setObject:@10 forKey:@"pageSize"];
            
        }
    }else{//  不看他的动态
        
        if ([self.editingStr isEqualToString:@"删除"]) {
            [dict setObject:@1 forKey:@"relation"];
            kurl = PrivacyListUrl;
            
        }else if ([self.editingStr isEqualToString:@"添加"]){
            kurl = listNotReadOtherAddUrl;
            [dict setObject:@(_pageNum) forKey:@"pageNum"];
            [dict setObject:@2 forKey:@"pageSize"];
            
        }
        
    }
    
    
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    WeakSelf;
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
    
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        NSLog(@"添加删除%@",responseObject);
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataSourceArray addObjectsFromArray:tempDataArr];
        //NSLog(@"dataArr%@",self.dataArr);
        
        [_tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - initUI
- (void )initUI{

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WC;
    [self.tableView setEditing:YES animated:YES];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_Id = @"row";
    SPDynamicEditingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    if (!cell) {
        cell = [[SPDynamicEditingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_Id];
    }
    if (self.dataSourceArray) {
        HomeModel * model = self.dataSourceArray[indexPath.row];
        [cell initWithModel:model AndCount:0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.selectArray addObject:self.dataSourceArray[indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.selectArray removeObject:self.dataSourceArray[indexPath.row]];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSourceArray removeObject:_dataSourceArray[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = self.editingStr;
    self.titleLabel.textColor = TitleColor;

    [self.rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:TitleColor forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 确定后请求接口
- (void)completeAction{

    NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:0];
    NSLog(@"selectArray%@",self.selectArray);
    if (self.selectArray.count != 0) {
        for (HomeModel * model in _selectArray) {
            [tempArr addObject:model.code];
        }
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        NSString * kurl;
        if ([self.editingStr isEqualToString:@"添加"]) {
            
            kurl = PrivacyAddUrl;
            
            if ([self.titleStr isEqualToString:@"不让他看我的动态"]) {
                [dict setObject:@2 forKey:@"relation"];
                
            }else{//  不看他的动态
                [dict setObject:@1 forKey:@"relation"];
            }
        }else{//  不看他的动态
            
            kurl = PrivacyDeleteUrl;
            
            if ([self.titleStr isEqualToString:@"不让他看我的动态"]) {
                [dict setObject:@2 forKey:@"relation"];
                
            }else{//  不看他的动态
                [dict setObject:@1 forKey:@"relation"];
            }
        }
        //所选用户的数组
        [dict setObject:tempArr forKey:@"targetCodes"];
        [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
        NSLog(@"删除添加传参%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            
            NSLog(@"添加删除%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 200) {
                [self completeNextVC];
            }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
    }else{
    
        [self completeNextVC];
    }
    
}

#pragma mark - completeNextVC
- (void)completeNextVC{

    [self.navigationController popViewControllerAnimated:YES];
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
