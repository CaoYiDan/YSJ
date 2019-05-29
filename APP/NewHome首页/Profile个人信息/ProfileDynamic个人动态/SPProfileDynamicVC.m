//
//  HomeViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPProfileDynamicVC.h"
#import "SPCategorySelectionVC.h"
#import "SPDynamicCell.h"
#import "SPBannerModel.h"
#import "SPDynamicFrame.h"
#import "SPHomeSectionView.h"
#import "SPActivityWebVC.h"
#import "SPDynamicDataManager.h"
#import "SPPhotosView.h"
#import "SPDynamicDetialVC.h"
#import "SPAllCategoryVC.h"

#import "SPDynamicModel.h"

#import "SPAllCategoryLeftView.h"
//test

@interface SPProfileDynamicVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)UILabel *noDataLab;
@end

@implementation SPProfileDynamicVC
{
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    self.navigationItem.title = @"我的动态";
    
    [self.view addSubview:self.tableView];
    
    //注册 ，当发布完成之后，返回 刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView)
                                                 name:NotificationPublishFinish
                                               object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

//获取动态信息
-(void)refreshData{
    
    _page = 1;
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    //    self.code = @"1552509554767642633";
    // 时间（传空的时候返回最新的）
    [dict setObject:self.code forKey:@"promulgator"];
    [dict setObject:[StorageUtil getCode] forKey:@"readerCode"];
    [dict setObject:@(1) forKey:@"pageNum"];
    [dict setObject:@"12" forKey:@"pageSize"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlListAlbum parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            self.listArray = arr;
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                //                SPDynamicFrame *modelF = [arr lastObject];
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
                
                if (self.listArray.count ==0) {
                    self.noDataLab.hidden = NO;
                    self.noDataLab.text = responseObject[@"message"];
                    self.tableView.mj_footer.hidden = YES;
                    
                }else{
                    
                    self.noDataLab.hidden = YES;
                    self.tableView.mj_footer.hidden = NO;
                }
                if (self.listArray.count <12) {
                    self.tableView.mj_footer.hidden = YES;
                }
            });
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//加载更多
-(void)loadMore{
    _page ++;
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    //    self.code = @"1552509554767642633";
    // 时间（传空的时候返回最新的）
    [dict setObject:self.code forKey:@"promulgator"];
    [dict setObject:[StorageUtil getCode] forKey:@"readerCode"];
    [dict setObject:@(_page) forKey:@"pageNum"];
    [dict setObject:@"12" forKey:@"pageSize"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlListAlbum parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            [self.listArray addObjectsFromArray:arr];
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                if (arr.count==0) {
                    self.tableView.mj_footer.hidden = YES;
                }
                /** 记录最后一条数据的时间*/
                //                SPDynamicFrame *modelF = [arr lastObject];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            });
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
    SPDynamicCell*cell = [SPDynamicCell cellWithTableView:tableView indexPath:indexPath];
    cell.statusFrame = self.listArray[indexPath.row];
    cell.backgroundColor = BASEGRAYCOLOR;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPDynamicFrame *frame = self.listArray[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPDynamicFrame *modelF = self.listArray[indexPath.row];
    
    SPDynamicDetialVC*vc = [[SPDynamicDetialVC alloc]init];
    vc.model = modelF.status;
    //删除动态
    vc.dynamicDeleteBlock = ^(){
        [self.listArray removeObject:modelF];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - -----------------SPNewDynamicHeaderViewDelegate-----------------

-(void)SPNewDynamicHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index{
    
    if ([type isEqualToString:@"bannerClick"]) {
        SPBannerModel *model =  self.bannerArray[index];
        
        if (isEmptyString(model.urlAddress)) return;
        
        SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
        
        //        vc.code = model.code;
        vc.url = model.urlAddress;
        vc.titleName = model.title;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"categoryClick"]){
        if (0) {
            
        }else{
            //全部分类列表
            SPAllCategoryVC *vc = [[SPAllCategoryVC alloc]init];
            HideBotum;
            HideTabbar;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma  mark - setter

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [UILabel labelWithFont:font(14) textColor:[UIColor lightGrayColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
        _noDataLab.frame = CGRectMake(SCREEN_W/2-50, 200, 100, 40);
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

//轮播图数据源
-(NSMutableArray*)bannerArray{
    if (_bannerArray==nil) {
        _bannerArray=[NSMutableArray array];
    }
    return _bannerArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        //不需要底部toolView
        if (self.dontNeedBottom) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
        }else{
        //需要底部View
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-43-50-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPDynamicCell class] forCellReuseIdentifier:SPDynamicCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        // footer
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        _tableView.mj_footer.hidden = YES;
        
        [_tableView.mj_header beginRefreshing];
    }
    return _tableView;
}

#pragma  mark -action

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}

@end

