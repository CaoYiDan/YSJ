//
//  SPMyMessageViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyMessageViewController.h"
#import "SPMyMessageTableCell.h"
#import "HomeModel.h"
#import "LGEvaluateVC.h"
#import "SPDynamicDetialVC.h"
#import "SPMyMessageModel.h"
#import "SPSystemMessageDetailVC.h"//系统通知
#import "SPProfileDynamicVC.h"//动态
#import "SPProfileVC.h"//个人详细
 static int typeOfCell = 1;//区分是系统还是互动
@interface SPMyMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
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

@implementation SPMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    typeOfCell = 1;
    [self initNav];
    [self initUI];

    //[self createRefresh];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self createRefresh];
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
    NSString * kurl;
    if (typeOfCell==1) {//系统
        
        kurl = SystemNotiUrl;
    }else if (typeOfCell ==2){//互动
        
        kurl = OthersMessageURL;
    }
    
    [dict setObject:@(_pageNum) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"reciver"];
    NSLog(@"%@,%d",dict,typeOfCell);
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的消息%@",responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        
        for (NSDictionary * tempDict in tempArr) {
            
            SPMyMessageModel * model = [[SPMyMessageModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        
        self.dataSourceArray =tempDataArr;
        
        if (self.dataSourceArray.count==0) {
            Toast(@"暂无消息");
            //[self haveNoMessage];
            //self.haveNoMessageLab.text = @"暂无消息";
            self.haveNoMessageLab.hidden = NO;
        }else{
            
            self.haveNoMessageLab.hidden = YES;
        }
        NSLog(@"%@",self.dataSourceArray);
    
        [self.tableView.mj_header endRefreshing];
        
        NSNumber *hasNext = responseObject[@"hasNext"];
        if ([hasNext integerValue]==1) {
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
}

#pragma mark - haveNoMessage
- (void)haveNoMessage{

    UILabel * messageLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-30, SCREEN_H/2-15, 60, 30)];
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = Font(14);
    messageLab.textColor = [UIColor lightGrayColor];
    messageLab.text = @"暂无消息";
    [self.tableView addSubview:messageLab];
}

#pragma mark - getMoreData
- (void)getMoreData{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString * kurl;
    if (typeOfCell==1) {//系统
        
        kurl = SystemNotiUrl;
        
    }else if (typeOfCell ==2){//互动
        
        kurl = OthersMessageURL;
    }
    
    [dict setObject:@(_pageNum) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    [dict setObject:[StorageUtil getCode] forKey:@"reciver"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的消息%@",responseObject);
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            SPMyMessageModel * model = [[SPMyMessageModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            NSLog(@"%@",model.code);
            [tempDataArr addObject:model];
        }
        [self.dataSourceArray addObjectsFromArray:tempDataArr];
        //NSLog(@"dataArr%@",self.dataArr);
        
        [self.tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        
        NSNumber *hasNext = responseObject[@"hasNext"];
        if ([hasNext integerValue]==1) {
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - initUI
- (void)initUI{

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_W, SCREEN_H+20) style:UITableViewStyleGrouped];
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
    static NSString *cellMessage = @"messageCell";
    // dequeueReusableCellWithIdentifier cell重复内容的时候用下面这个方法
    SPMyMessageTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SPMyMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMessage];
    }
    if (self.dataSourceArray) {
        SPMyMessageModel * modelMessage = self.dataSourceArray[indexPath.row];
        NSLog(@"model.code%@ %ld",modelMessage.Id,self.dataSourceArray.count);
        [cell initWithModel:modelMessage withType:typeOfCell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.selectArray addObject:self.dataSourceArray[indexPath.row]];
    SPMyMessageModel * model = self.dataSourceArray[indexPath.row];
    [self getReadWithModel:model];
    
}

#pragma mark - 标记已读
- (void)getReadWithModel:(SPMyMessageModel *)model{

    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:model.code forKey:@"code"];
    [dict setObject:model.Id forKey:@"id"];
    NSString * kurl;
    if (typeOfCell ==1) {
        
        kurl = ReadedNotiUrl;
        
    }else if (typeOfCell==2){
    
        kurl = ReadedOthersMessageURL;
    }
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        if ([responseObject[@"status"] integerValue]==200) {
            
            [self pushToNextVCWithModel:model];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - pushToNextVCWithModel

#pragma mark -跳转 pushToNextVCWithModel

- (void)pushToNextVCWithModel:(SPMyMessageModel *)model{
    
    if (typeOfCell ==1) {
        
        SPSystemMessageDetailVC * detailVc = [[SPSystemMessageDetailVC alloc]init];
        detailVc.contentStr =  model.content;
        [self.navigationController pushViewController:detailVc animated:YES];
        
    }else if (typeOfCell==2){
        /*
         USER_COMMENT    //用户评价
         USER_PRAISE      //用户点赞
         USER_REPLY       //用户回复
         FEED_COMMENT   //动态下的评价
         FEED_PRAISE      //动态点赞
         FEED_REPLY        //动态回复
         FEED_COMMENT_PRAISE  //动态下评价或者回复的点赞
         USER_COMMENT_PRAISE  //用户下的评价或者回复的点赞
         SKILL_COMMENT//跳到个人详细
         */
        NSLog(@"model.type%@",model.type);
        if ([model.type isEqualToString:@"USER_COMMENT"]||[model.type isEqualToString:@"USER_PRAISE"]||[model.type isEqualToString:@"USER_REPLY"]||[model.type isEqualToString:@"USER_COMMENT_PRAISE"]) {
            LGEvaluateVC *vc = [[LGEvaluateVC alloc]init];
            vc.mainCode = model.reciver;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([model.type isEqualToString:@"FEED_COMMENT"]||[model.type isEqualToString:@"FEED_PRAISE"]||[model.type isEqualToString:@"FEED_REPLY"]||[model.type isEqualToString:@"FEED_COMMENT_PRAISE"]){
            SPDynamicDetialVC *vc = [[SPDynamicDetialVC alloc]init];
            vc.feedCode = model.mainCode;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            SPProfileVC * DetailVC = [[SPProfileVC alloc]init];
            DetailVC.code = model.sender;
            [self.navigationController pushViewController:DetailVC animated:YES];
            
        }
    }
}
#pragma mark - initNav
- (void)initNav{
    
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2-63,0, 126, 40)];

    titleView.backgroundColor = WC;
    
    self.navigationItem.titleView = titleView;
    
    //通知
    UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstBtn = firstBtn;
    firstBtn.selected = YES;
    [firstBtn setTitle:@"通知" forState:UIControlStateNormal];
    [firstBtn setTitleColor:RGBA(60, 60, 60, 1) forState:UIControlStateNormal];
    [firstBtn setTitleColor:RGBA(240, 27, 132, 1) forState:UIControlStateSelected];
    firstBtn.frame = CGRectMake(0,5, 40, 32);
    [firstBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 1;
    [titleView addSubview:firstBtn];
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(firstBtn.frame.size.width+22,15,1.5,16)];
    
    firstView.backgroundColor = RGBA(204, 204, 204, 1);
    [titleView addSubview:firstView];
    
    //互动
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.secondBtn = secondBtn;
    [secondBtn setTitle:@"互动" forState:UIControlStateNormal];
    [secondBtn setTitleColor:RGBA(60, 60, 60, 1) forState:UIControlStateNormal];
    [secondBtn setTitleColor:RGBA(240, 27, 132, 1) forState:UIControlStateSelected];
    secondBtn.frame = CGRectMake(firstView.frame.origin.x+24,5, 40, 32);
    [secondBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.tag = 2;
    [titleView addSubview:secondBtn];
    
    [self.rightButton setTitle:@"全标已读" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.frame = CGRectMake(20, 10,100, 40);
    
}

#pragma mark - titleBtnClick
- (void)titleBtnClick:(UIButton *)btn{

    NSLog(@"%@",btn.titleLabel.text);
    
    if ([btn.titleLabel.text isEqualToString:@"通知"]) {
        if (btn.selected) {
            return;
        }
        btn.selected = YES;
        typeOfCell = 1;
        self.secondBtn.selected = NO;
        [self loadData];
        
    }else if ([btn.titleLabel.text isEqualToString:@"互动"]){
    
        if (btn.selected) {
            return;
        }
        btn.selected = YES;
        typeOfCell = 2;
        self.firstBtn.selected = NO;
        [self loadData];
    }
}

#pragma mark - rightButtonClick:
- (void)rightButtonClick:(UIButton *)btn{

    NSString * kurl;
    
    if (typeOfCell==1) {//系统通知已读
        
        kurl = AllSystemReadURL;
        
    }else if (typeOfCell==2){//互动通知已读
    
        kurl = AllOthersMessageReadURL;
    }
    
    NSDictionary * dict = @{@"reciver":[StorageUtil getCode]};
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        if ([responseObject[@"status"] integerValue]==200) {
            
            [self createRefresh];
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}
#pragma mark - haveNoMessageLab

- (UILabel * )haveNoMessageLab{
    
    if (!_haveNoMessageLab) {
        _haveNoMessageLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-30, SCREEN_H/2-15, 60, 30)];
        _haveNoMessageLab.textAlignment = NSTextAlignmentCenter;
        _haveNoMessageLab.font = Font(14);
        _haveNoMessageLab.textColor = [UIColor lightGrayColor];
        _haveNoMessageLab.text = @"暂无消息";
        [self.tableView addSubview:_haveNoMessageLab];
    }
    return _haveNoMessageLab;
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
