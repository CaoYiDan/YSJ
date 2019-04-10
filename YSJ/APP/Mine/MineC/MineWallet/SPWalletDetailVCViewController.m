//
//  SPWalletDetailVCViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/12/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPWalletDetailVCViewController.h"
#import "SPLzsMineWalletDetailModel.h"
#import "SPMineWalletDetailCell.h"
@interface SPWalletDetailVCViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    int _pageNum;
    
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *selectArray;
@property (nonatomic, strong)UIButton * secondBtn;
@property (nonatomic, strong)UIButton * firstBtn;
@property (nonatomic, strong)UILabel * haveNoMessageLab;

@end

@implementation SPWalletDetailVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加背景图
//    UIImageView * backIV = [[UIImageView alloc]init];
//    backIV.frame = self.view.bounds;
//    backIV.image = [UIImage imageNamed:@"mineWalletDetail.jpg"];
//    [self.view insertSubview:backIV atIndex:0];
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
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
  
    
    if ([self.titleStr isEqualToString:@"充值明细"]) {//充值明细
        
        [dict setObject:@"RECHARGE" forKey:@"feeType"];
        
    }else {//保证金明细
        
        [dict setObject:@"BAIL_FREEZE" forKey:@"feeType"];
    }
    [dict setObject:@(_pageNum) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"accountUserId"];
   
    [[HttpRequest sharedClient]httpRequestPOST:URLOfMineWalletDetail parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的钱包明细%@",responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"][@"list"];
        
        for (NSDictionary * tempDict in tempArr) {
            
            SPLzsMineWalletDetailModel * model = [[SPLzsMineWalletDetailModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        
        self.dataSourceArray =tempDataArr;
        
        if (self.dataSourceArray.count==0) {
            //Toast(@"暂无消息");
            [self haveNoMessage];
            //self.haveNoMessageLab.text = @"暂无消息";
            //self.haveNoMessageLab.hidden = NO;
        }else{
            
            //self.haveNoMessageLab.hidden = YES;
        }
        NSLog(@"%@",self.dataSourceArray);
        
        [self.tableView.mj_header endRefreshing];
        
        NSNumber *hasNext = responseObject[@"hasNextPage"];
        if ([hasNext integerValue]==1) {
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - getMoreData
- (void)getMoreData{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    if ([self.titleStr isEqualToString:@"充值明细"]) {//充值明细
        
        [dict setObject:@"RECHARGE" forKey:@"feeType"];
        
    }else {//保证金明细
        
        [dict setObject:@"BAIL_FREEZE" forKey:@"feeType"];
    }
    
    [dict setObject:@(_pageNum) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"reciver"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:URLOfMineWalletDetail parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的钱包明细%@",responseObject);
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"][@"list"];
        for (NSDictionary * tempDict in tempArr) {
            
            SPLzsMineWalletDetailModel * model = [[SPLzsMineWalletDetailModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            
            [tempDataArr addObject:model];
        }
        [self.dataSourceArray addObjectsFromArray:tempDataArr];
        //NSLog(@"dataArr%@",self.dataArr);
        
        [self.tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        
        NSNumber *hasNext = responseObject[@"hasNextPage"];
        if ([hasNext integerValue]==1) {
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - haveNoMessage
- (void)haveNoMessage{
    
    //添加背景图
    UIImageView * backIV = [[UIImageView alloc]init];
    backIV.frame = self.view.bounds;
    backIV.image = [UIImage imageNamed:@"mineWalletDetail.jpg"];
    //[self.view insertSubview:backIV atIndex:0];
    
    //    UILabel * messageLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-30, SCREEN_H/2-15, 60, 30)];
    //    messageLab.textAlignment = NSTextAlignmentCenter;
    //    messageLab.font = Font(14);
    //    messageLab.textColor = [UIColor lightGrayColor];
    //    messageLab.text = @"暂无消息";
    [self.tableView addSubview:backIV];
}

#pragma mark - initUI
- (void)initUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WC;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *walletDetailCell = @"walletDetailCell";
    // dequeueReusableCellWithIdentifier cell重复内容的时候用下面这个方法
    SPMineWalletDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SPMineWalletDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletDetailCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataSourceArray) {
        SPLzsMineWalletDetailModel * modelMessage = self.dataSourceArray[indexPath.row];
        //NSLog(@"model.code%@ %ld",modelMessage.Id,self.dataSourceArray.count);
        [cell initWithModel:modelMessage];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.selectArray addObject:self.dataSourceArray[indexPath.row]];
    
    
}
#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = self.titleStr;
    self.titleLabel.textColor = [UIColor blackColor];
    
//    [self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
