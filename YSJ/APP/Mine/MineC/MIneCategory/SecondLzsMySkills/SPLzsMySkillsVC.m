//
//  SPLzsMySkillsVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsMySkillsVC.h"
#import "SPLzsMySkillsTableViewCell.h"
#import "SPLzsMySkillModel.h"
#import "SPMySkillDetailVC.h"
#import "SPMySkillForMakeMonery.h"
#import "SPLzsGetMoneyVC.h"
@interface SPLzsMySkillsVC ()<UITableViewDelegate,UITableViewDataSource,SkillsCellDelegate>{

    int _start;
    int _end;

}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * mySkillTableView;

@end

@implementation SPLzsMySkillsVC

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

    self.mySkillTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.mySkillTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.mySkillTableView.mj_footer.hidden = YES;
    //
    [self.mySkillTableView.mj_header beginRefreshing];
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
    [[HttpRequest sharedClient]httpRequestPOST:MineSkillsUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"我的技能%@",responseObject);
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            SPLzsMySkillModel * model = [[SPLzsMySkillModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self.dataArr addObject:model];
        }
        
        [_mySkillTableView reloadData];
        [self.mySkillTableView.mj_header endRefreshing];
        
        
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
    
    [[HttpRequest sharedClient]httpRequestPOST:MineSkillsUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        //NSLog(@"我的技能%@",responseObject);
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            SPLzsMySkillModel * model = [[SPLzsMySkillModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self.dataArr addObject:model];
        }
        
        [self.mySkillTableView reloadData];
        [self.mySkillTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - initUI
- (void)initUI{

    self.mySkillTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 100) style:UITableViewStylePlain];
    self.mySkillTableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.mySkillTableView.delegate=self;
    self.mySkillTableView.dataSource=self;
    
    self.mySkillTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.mySkillTableView.backgroundColor = WC;
    self.mySkillTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mySkillTableView.showsHorizontalScrollIndicator = NO;
    self.mySkillTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mySkillTableView];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-100-SafeAreaTopHeight, SCREEN_W, 100)];
    bottomView.backgroundColor = WC;
    [self.view addSubview:bottomView];
    
    UIButton * pushSkillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushSkillBtn setBackgroundColor:RGBCOLOR(250, 28, 82)];
    [pushSkillBtn setTitle:@"发布技能" forState:UIControlStateNormal];
    [pushSkillBtn setTitleColor:WC forState:UIControlStateNormal];
    [pushSkillBtn addTarget:self action:@selector(pushSkillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pushSkillBtn];
    pushSkillBtn.frame = CGRectMake(30, 25, SCREEN_W-60, 35);
    pushSkillBtn.clipsToBounds = YES;
    pushSkillBtn.layer.cornerRadius = 4;
    
}

#pragma mark - pushSkillBtnClick发布技能
- (void)pushSkillBtnClick:(UIButton *)btn{

    SPMySkillForMakeMonery * skillMakeVC = [[SPMySkillForMakeMonery alloc]init];
    [self.navigationController pushViewController:skillMakeVC animated:YES];
}

#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * mySkillCell = @"mySkillCell";
    
    //SPLzsMySkillsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPLzsMySkillsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    if (!cell) {
        
     cell = [[SPLzsMySkillsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mySkillCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        //cell.backgroundColor = RGBCOLOR(239, 239, 239);
    }
    
    if (self.dataArr.count) {
        
        SPLzsMySkillModel * model = self.dataArr[indexPath.row];
        cell.model = model;
        [cell initWithModel:model];
    }
    
    //[self.mySkillTableView reloadData];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
   
    SPLzsMySkillModel * model = self.dataArr[indexPath.row];
//        //服务时间
//    CGFloat cellHeight = [SPLzsMySkillsTableViewCell initWithCellHeight:model];
    NSString * timeStr = [NSString stringWithFormat:@"服务时间: %@",model.serTime];
    CGRect serTimeRect = [timeStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat serTimeHeight = serTimeRect.size.height;
    //服务介绍
   UIFont *font = [UIFont systemFontOfSize:13];
    NSString * infoStr = [NSString stringWithFormat:@"服务介绍: %@",model.serIntro];
    CGRect infoStrRect = [infoStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    CGFloat infoStrHeight = infoStrRect.size.height;
    //服务介绍
    NSString * goodStr = [NSString stringWithFormat:@"服务介绍: %@",model.serIntro];
    CGRect goodStrRect = [goodStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat goodStrHeight = goodStrRect.size.height;
    NSLog(@"%f",180+serTimeHeight+infoStrHeight+goodStrHeight);
    return 180+serTimeHeight+infoStrHeight+goodStrHeight;
    
    //return cellHeight;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   return  self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPMySkillDetailVC *vc = [[SPMySkillDetailVC alloc]init];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SkillsCellDelegate
#pragma mark -  删除按钮
- (void)deleteBtnClickForVC:(SPLzsMySkillModel *)model
{
    UIAlertAction * alertAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dict = @{@"id":model.ID,@"lucCode":model.lucCode,@"code":model.code,@"status":@"DELETED"};
        [[HttpRequest sharedClient]httpRequestPOST:ChangeStatusOfSkillAndMoney parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            [self loadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }];
    UIAlertAction * alertNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"删除技能提示" message:@"您确定要删除该技能吗?" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:alertAc];
    [alertVC addAction:alertNo];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -  修改技能按钮
- (void)changeBtnClickForVC:(SPLzsMySkillModel *)model
{
//    Toast(@"点击了修改技能");
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定修改学期吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
    SPLzsGetMoneyVC * getMoneyVC = [[SPLzsGetMoneyVC alloc]init];
    getMoneyVC.skill = model.skill;
    getMoneyVC.skillCode = model.skillCode;
    [self.navigationController pushViewController:getMoneyVC animated:YES];
}

//#pragma mark - 完善资料
//- (void)finishTextWithChangeClick:(SPLzsMySkillModel *)model{
//
//    SPLzsGetMoneyVC * getMoneyVC = [[SPLzsGetMoneyVC alloc]init];
//    getMoneyVC.skill = model.skill;
//    getMoneyVC.skillCode = model.skillCode;
//    [self.navigationController pushViewController:getMoneyVC animated:YES];
//}

#pragma mark - initNav
- (void)initNav{

    self.titleLabel.text = @"我的技能";
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
