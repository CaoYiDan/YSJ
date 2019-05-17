//
//  HomeViewController.m
//  SmallPig
//
#import "MenuInfo.h"
#import "YSJOrderCourseView.h"
#import "FFDifferentWidthTagModel.h"
#import "FFDifferentWidthTagCell.h"
#import "YSJCheckCommentVC.h"
#import "SPCategorySelectionVC.h"
#import "YSJCommentCell.h"
#import "SPBannerModel.h"
#import "YSJCommentFrameModel.h"
#import "SPHomeSectionView.h"
#import "SPActivityWebVC.h"
#import "SPDynamicDataManager.h"
#import "SPPhotosView.h"
#import "SPDynamicDetialVC.h"
#import "SPAllCategoryVC.h"

#import "YSJCommentsModel.h"

#import "SPAllCategoryLeftView.h"
//test

@interface YSJCheckCommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)UILabel *noDataLab;

@end

@implementation YSJCheckCommentVC
{
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    self.navigationItem.title = @"评价";
    
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
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

//获取动态信息
-(void)refreshData{
    
    _page = 0;
    
    NSString *url = @"";
    
    [[HttpRequest sharedClient]httpRequestGET:url parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"evaluates"]) {
                YSJCommentFrameModel *frame = [[YSJCommentFrameModel alloc]init];
                frame.status = [YSJCommentsModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            self.listArray = arr;
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                //                YSJCommentFrameModel *modelF = [arr lastObject];
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

    YSJCommentCell*cell = [YSJCommentCell loadCode:tableView];
    cell.statusFrame = self.listArray[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJCommentFrameModel *frame = self.listArray[indexPath.row];
    return frame.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 200, kWindowW, 110)];
    view.model = self.model;
    view.price.hidden = NO;
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(6);
        make.bottom.offset(0);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-KBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight+49, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
       
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

