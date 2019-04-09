//
//  HomeViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPOneCategoryListVC.h"
#import "SPCategorySelectionVC.h"
#import "SPHomeCell.h"
#import "SPHomeModel.h"
#import "SPNewHomeCellFrame.h"
#import "SPProfileVC.h"
#import "SPDynamicModel.h"
#import "SPHomeSifingVC.h"
#import "SPSortView.h"
#import "SPBannerModel.h"
#import "SPDynamicFrame.h"
#import "SPHomeSectionView.h"
#import "SPActivityWebVC.h"
#import "SPHomeDataManager.h"
#import "SPPhotosView.h"
#import "SPDynamicDetialVC.h"
#import "SPAllCategoryVC.h"

#import "SPDynamicModel.h"

#import "SPNewDynamicHeaderView.h"

#import "SPAllCategoryLeftView.h"
//test

@interface SPOneCategoryListVC ()<UITableViewDelegate,UITableViewDataSource,SPNewDynamicHeaderViewDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPNewDynamicHeaderView *header;
@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)UILabel *noDataLab;
@property(nonatomic,strong)SPSortView *sortView;

@end

@implementation SPOneCategoryListVC
{
    NSMutableDictionary *_siftingDic;
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _siftingDic = @{}.mutableCopy;
    //[_siftingDic setObject:self.skillCode forKey:@"skillCode"];
    
    self.navigationItem.title = self.titleName;
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    [self.view addSubview:self.tableView];
    
    [self refreshData];
//    self.tableView.tableHeaderView = self.header;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES
     ];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

//获取动态信息
-(void)refreshData{
    _page=1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_siftingDic setObject:self.skillCode forKey:@"skillCode"];
    NSLog(@"_siftingDic:%@",_siftingDic);
    
    [SPHomeDataManager refreshHomeDateWithDic:_siftingDic success:^(NSArray *items, BOOL lastPage, NSString *currentData) {
        self.listArray = (NSMutableArray *)items;
        
        [self.tableView.mj_header endRefreshing];
        
        if (self.listArray.count==0) {
            self.tableView.mj_footer.hidden = YES;
            self.noDataLab.hidden = NO;
            
        }else{
            
            self.noDataLab.hidden = YES;
            
            self.tableView.mj_footer.hidden = NO;
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self.tableView reloadData];
    } failure:^(NSError *NSError) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//加载更多
-(void)loadMore{
    _page ++;
    
    [SPHomeDataManager getMoreHomeDateWithPage:_page andDic:_siftingDic refreshDate:_refreshDate success:^(NSArray *items, BOOL lastPage, NSString *refreshDate) {
        [self.listArray addObjectsFromArray:items];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (items.count == 0) {
            Toast(@"已经到底了");
            self.tableView.mj_footer.hidden = YES;
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *NSError) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHomeCell*cell = [SPHomeCell cellWithTableView:tableView indexPath:indexPath];
    cell.statusFrame = self.listArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPNewHomeCellFrame *frame = self.listArray[indexPath.row];
    return frame.cellHeight;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SPHomeSectionView *sectionView = [[SPHomeSectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    WeakSelf;
    sectionView.block = ^(NSString *str){
        NSLog(@"%@",str);
        if ([str isEqualToString:@"排序"]) {
            [weakSelf addSortView];
        }else if ( [str isEqualToString:@"筛选"]){
            [weakSelf pushTosiftingVC];
        }
    };
    return sectionView;
}

-(void)pushTosiftingVC{
    
    SPHomeSifingVC *vc = [[SPHomeSifingVC alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addSortView{
    
    [self.view addSubview:self.sortView];
    //调用重新刷新，为了选中之前的选项。待优化，这样处理不好
    [self.sortView reloadTableView];
    self.sortView.frame= CGRectMake(0, -SCREEN_H2, SCREEN_W, SCREEN_H2);
    [UIView animateWithDuration:0.3 animations:^{
        self.sortView.originY=0;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPNewHomeCellFrame *modelF = self.listArray[indexPath.row];
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code = modelF.status.code;
    vc.titleName = modelF.status.nickName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - -----------------SPNewDynamicHeaderViewDelegate-----------------

-(void)SPNewDynamicHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index{
    
    if ([type isEqualToString:@"bannerClick"]) {
        SPBannerModel *model =  self.bannerArray[index];
        
        if (isEmptyString(model.urlAddress)) return;
        
        SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
     
        vc.url = model.urlAddress;
        vc.titleName = model.title;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"categoryClick"]){
       
        }else{
            //全部分类列表
            SPAllCategoryVC *vc = [[SPAllCategoryVC alloc]init];
            HideBotum;
            HideTabbar;
            [self.navigationController pushViewController:vc animated:YES];
        }
    
}

#pragma  mark - setter

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [UILabel labelWithFont:font(14) textColor:[UIColor lightGrayColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
        _noDataLab.frame = CGRectMake(SCREEN_W/2-50, _header.frameHeight+80, 100, 40);
        _noDataLab.text = @"暂无数据";
        //        _noDataLab.center = self.tableView.center;
        [self.tableView addSubview:_noDataLab];
    }
    return _noDataLab;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPHomeCell class] forCellReuseIdentifier:SPHomeCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        // footer
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

#pragma  mark -action

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}

#pragma  mark - -----------------筛选代理-----------------
-(void)SPHomeSifingVCSifting:(NSMutableDictionary *)siftingDic{
    _siftingDic = siftingDic;
    [self refreshData];
}

//排序view
-(SPSortView *)sortView{
    WeakSelf;
    if (!_sortView) {
        _sortView = [[SPSortView alloc]initWithFrame:self.view.bounds];
        _sortView.block = ^(NSString *sortStr) {
            NSLog(@"%@",sortStr);
            [weakSelf addObject:sortStr];
        };
    }
    return _sortView;
}

-(void)addObject:(NSString *)sortValue{
    [_siftingDic setObject:sortValue forKey:@"searchType"];
    //    [self.tableView.mj_header beginRefreshing];
    [self refreshData];
}
@end

