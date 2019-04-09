//
//  SelectionViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SelectionViewController.h"
#import "SPSearchVC.h"
#import "SPSelectionCell.h"
#import "SDCycleScrollView.h"
#import "SPSkillListModel.h"
#import "SPBannerModel.h"
#import "SPEvaluateEditVC.h"
//#import "WXOpenIMSDKFMWK"
#import "SPHomeSectionView.h"

#import "SPCategorySelectionVC.h"

#import "SPBaseNavigationController.h"

#define  bannerHeight SCREEN_W/750*300

@interface SelectionViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
//滚动banner
@property(nonatomic,strong)SDCycleScrollView *bannerView;
//轮播图数据数组
@property(nonatomic,strong)NSMutableArray *bannerArray;
//navigationView
@property(nonatomic,strong)UIView *navigationView;
@end

@implementation SelectionViewController
{
    NSInteger _page;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.titleLabel.text = @"热约";
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.tableView];
    
//    [self.view addSubview:self.navigationView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma  mark  - 刷新

-(void)refresh{
    [self getBanner];
    [self getFirstPageData];
}

-(void)getFirstPageData{
    _page = 0;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:[SPCommon getLoncationDic]forKey:@"location"];
    
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"20" forKey:@"pageSize"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dic);
    
    //测试专用
    if ([[StorageUtil getCode] isEqualToString:@"1550553304278809385"]) {
        [dic setObject:@{
                         @"lat":@"39.006737",
                         @"lon":@"117.293528"
                         } forKey:@"location"];
    }
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlListGroupBySkills parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.listArray = [SPSkillListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma  mark  加载更多

-(void)loadMore{
    _page ++;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
//    NSMutableDictionary *locationDic = @{}.mutableCopy;
//    [locationDic setObject:[StorageUtil getUserLat] forKey:@"lat"];
//    [locationDic setObject:[StorageUtil getUserLon] forKey:@"lon"];
//    
    [dic setObject:[SPCommon getLoncationDic]forKey:@"location"];
    
    [dic setObject:@(_page) forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlListGroupBySkills parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        [self.listArray addObjectsFromArray:[SPSkillListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma  mark  轮播图

-(void)getBanner{
    
//    SYSTEM_START：开机广告； FEED_HOME：动态首页广告； SELECTION_HOME：精选首页广告
    [[HttpRequest sharedClient]httpRequestPOST:kUrlBanner parameters:@{@"positionName":@"SELECTION_HOME"} progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.bannerArray = [SPBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *bannerImgArr = @[].mutableCopy;
        
        for (NSDictionary *bannerDic in responseObject[@"data"]) {
            [bannerImgArr addObject:bannerDic[@"imgUrl"]];
        }
        [self.bannerView setImageURLStringsGroup:bannerImgArr];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    SPSkillListModel *model = self.listArray[section];
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSelectionCell*cell = [SPSelectionCell cellWithTableView:tableView indexPath:indexPath andCellType:0];
    SPSkillListModel *model = self.listArray[indexPath.section];
    cell.listArr = model.userList;
//    cell.statusFrame = self.listArray[indexPath.row];
//    cell.backgroundColor = BASEGRAYCOLOR;
    
    return cell;
}



#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderAtSection:section];
}
// title
-(UIView *)sectionHeaderAtSection:(NSInteger)section{
    
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    base.backgroundColor = [UIColor whiteColor];
    
    UILabel *sectionView = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 100, 40)];
    SPSkillListModel *model = self.listArray[section];
    sectionView.text = model.skillValue;
    sectionView.font = BoldFont(16);
    [base addSubview:sectionView];
    
    UIImageView *pig = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [pig setImage:[UIImage imageNamed:@"h_pig"]];
    [base addSubview:pig];
    
    UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-47, 16, 37, 8)];
    [more setImage:[UIImage imageNamed:@"h_activity_more"]];
    [base addSubview:more];
    
    //添加点击事件
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    [btn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag= section;
    [base addSubview:btn];
    return base;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SPDynamicFrame *modelF = self.listArray[indexPath.row];
//    
//    SPDynamicDetialVC*vc = [[SPDynamicDetialVC alloc]init];
//    vc.model = modelF.status;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma  mark - setter

-(UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0,IS_IPHONE_X?44:20, SCREEN_W, 40)];
        _navigationView.backgroundColor = [UIColor clearColor];
        
        UIButton *leftItem = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
        [leftItem setImage:[UIImage imageNamed:@"s_search_leftitem"] forState:0];
        [leftItem addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchDown];
        [_navigationView addSubview:leftItem];
    }
    return _navigationView;
}

//轮播图
-(SDCycleScrollView*)bannerView{
    if (!_bannerView) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_W,bannerHeight) imageURLStringsGroup:self.bannerArray];
        
        _bannerView.currentPageDotColor=[UIColor grayColor];
        _bannerView.pageDotColor=[UIColor blackColor];
        _bannerView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        _bannerView.infiniteLoop = YES;
        _bannerView.delegate = self;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 3;
    }
    return _bannerView;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

//轮播图数据源
-(NSMutableArray*)bannerArray{
    if (_bannerArray==nil) {
        _bannerArray=[NSMutableArray array];
    }
    return _bannerArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        //用白色遮挡一下导航栏
//        UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, IS_IPHONE_X?44:20)];
//        base.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:base];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H2-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = SCREEN_W/3+60+20;
        _tableView.sectionFooterHeight = 0;
//        _tableView.sectionHeaderHeight =0;
        _tableView.backgroundColor = BASEGRAYCOLOR;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPSelectionCell class] forCellReuseIdentifier:@"selectionCellID"];
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.tableHeaderView = self.bannerView;
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        [_tableView.mj_header beginRefreshing];
    }
    return _tableView;
}


#pragma  mark  - action


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
   
}

-(void)search{
    SPSearchVC *searchVC = [[SPSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma  mark  更多

-(void)more:(UIButton *)btn{
    
    SPSkillListModel *model  = self.listArray[btn.tag];
    
    SPCategorySelectionVC *vc =[[SPCategorySelectionVC alloc]init];
    vc.titleString = model.skillValue;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)test{
    
    SPEvaluateEditVC *vc =[[SPEvaluateEditVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
