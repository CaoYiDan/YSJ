//

#import "SPNewDynamicVC.h"
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
//#import "SPActivityVC.h"
#import "SPDynamicModel.h"

#import "SPAllCategoryLeftView.h"
//test

@interface SPNewDynamicVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)UILabel *noDataLab;
@end

@implementation SPNewDynamicVC
{
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    [self.view addSubview:self.tableView];

    //注册 ，当发布完成之后，返回 刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(reloadTableView)
         name:NotificationPublishFinish
       object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

//获取动态信息
-(void)refreshData{
    
    _page=1;
    
    [SPDynamicDataManager refreshHomeDatesuccess:^(NSArray *items, BOOL lastPage, NSString *refreshDate) {
        //记录最靠后的时间
        _refreshDate = refreshDate;
        
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
    [SPDynamicDataManager getMoreHomeDateWithPage:_page refreshDate:_refreshDate success:^(NSArray *items, BOOL lastPage, NSString *_refreshDate) {
        
//        _refreshDate = refreshDate;
        
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-49-SafeAreaBottomHeight) style:UITableViewStylePlain];
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
