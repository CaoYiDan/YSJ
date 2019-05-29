//
//  LGEvaluateVC.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "SPEvaluateForSkillListVC.h"
#import "SPProfileCommentCell.h"
#import "SPCommentModel.h"
#import "SPProfileCommentFrame.h"

#import "SPEvaluateForSkillVC.h"


@interface SPEvaluateForSkillListVC ()
@property(nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong)UILabel *noEvaluateLabel;//暂无评论
@end

@implementation SPEvaluateForSkillListVC

{
    int  _page;
    UIButton *_commitBtn;
}

//暂无评论
-(UILabel *)noEvaluateLabel{
    if (!_noEvaluateLabel) {
        _noEvaluateLabel =[[UILabel alloc]init];
        _noEvaluateLabel.text=@"暂无评论";
        _noEvaluateLabel.textAlignment = NSTextAlignmentCenter;
        _noEvaluateLabel.textColor = [UIColor grayColor];
        _noEvaluateLabel.font = font(14);
        [self.view addSubview:_noEvaluateLabel];
        [_noEvaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100, 30));
            make.centerX.offset(0);
            make.top.offset(60);
        }];
    }
    return _noEvaluateLabel;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, 100, 30) text:@"评价" textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:16]];
    self.navigationItem.titleView = titleLabel;
    
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
    //    self.tableView.backgroundColor = LGLighgtBGroundColour235;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_H2-50-SafeAreaBottomHeight, SCREEN_W-40, 40)];
    commitBtn.layer.borderColor = MyBlueColor.CGColor;
    commitBtn.layer.borderWidth = 1.0f;
    [commitBtn setTitle:@"评价" forState:0];
    commitBtn.titleLabel.font = font(14);
    commitBtn.layer.cornerRadius = 20;
    commitBtn.clipsToBounds = YES;
    [commitBtn setTitleColor:MyBlueColor forState:0];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchDown];
    _commitBtn = commitBtn;
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:commitBtn];
    _commitBtn.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frameHeight = SCREEN_H-50;
    //    self.tableView.backgroundColor = [UIColor redColor];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _commitBtn.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [_commitBtn removeFromSuperview];
}

//评价
-(void)commit{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPEvaluateForSkillVC *vc = [[SPEvaluateForSkillVC alloc]init];
    vc.mainCode = self.mainCode;
    vc.beCommentedCode = self.beCommentedCode;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadMore{
    _page++;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.mainCode forKey:@"mainCode"];
    [dict setObject:@(_page) forKey:@"pageNumber"];
    [dict setObject:@(10) forKey:@"pageSize"];
    
    //    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlBase parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        NSMutableArray *arr = (NSMutableArray *)[SPCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        for (SPCommentModel *status in arr) {
            SPProfileCommentFrame *frameModel = [[SPProfileCommentFrame alloc]init];
            //            frameModel.type = EvaluateCellTypeForEvaluate;
            frameModel.status = status;
            [self.dataArr addObject:frameModel];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        /** 如果是最后一页，则底部不显示加载更多*/
        NSString*isLastPage=responseObject[@"pageInfo"][@"isLastPage"];
        if ([isLastPage integerValue]==0){
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)loadData{
    _page = 1;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.mainCode forKey:@"mainCode"];
    [dict setObject:@(_page) forKey:@"pageNum"];
    [dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:@"SKILL" forKey:@"type"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlCommnetList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        NSMutableArray *arr = (NSMutableArray *)[SPCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *arr2 = [[NSMutableArray alloc]init];
        for (SPCommentModel *status in arr) {
            SPProfileCommentFrame *frameModel = [[SPProfileCommentFrame alloc]init];
            
            //           frameModel.type = EvaluateCellTypeForEvaluate;
            
            frameModel.status = status;
            //            frameModel.status.commentMain = YES;
            [arr2 addObject:frameModel];
        }
        self.dataArr = arr2;
        //暂无评价
        if(self.dataArr.count==0){
            self.noEvaluateLabel.hidden = NO;
        }else{
            self.noEvaluateLabel.hidden = YES;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        /** 如果是最后一页，则底部不显示加载更多*/
        BOOL isLastPage=responseObject[@"totalPages"] <=responseObject[@"currentPage"];
        if (!isLastPage){
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        if (self.dataArr.count == 0) {
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (self.dataArr.count == 0) {
            self.tableView.mj_footer.hidden = YES;
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPProfileCommentCell *cell=[SPProfileCommentCell cellWithTableView:tableView];
    
    SPProfileCommentFrame *statusFrame = self.dataArr[indexPath.row];
    cell.statusFrame = statusFrame;
    //回复点击的回调事件
    cell.block = ^(NSString *evaluateId){
        [self p_PushToAnswerVCWithType:0 andId:evaluateId index:indexPath.row];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPProfileCommentFrame *statusFrame = self.dataArr[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPProfileCommentFrame *statusFrame = self.dataArr[indexPath.row];
    [self p_PushToAnswerVCWithType:1 andId:statusFrame.status.code index:indexPath.row];
}

//跳转到评论详情界面
-(void)p_PushToAnswerVCWithType:(NSInteger)type andId:(NSString *)evaluateId index:(NSInteger)index{
    //    SPProfileCommentFrame *model = self.dataArr[index];
    //    LGAnswerVC *vc=[[LGAnswerVC alloc]init];
    //    vc.code  = evaluateId;
    //    vc.type = @"COMMENT";
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end


