//
//  HomeViewController.m
//  SmallPig
//
#import "MenuInfo.h"
#import "FFDifferentWidthTagModel.h"
#import "FFDifferentWidthTagCell.h"
#import "YSJCommentVC.h"
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

@interface YSJCommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)UILabel *noDataLab;
@end

@implementation YSJCommentVC
{
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    self.navigationItem.title = @"用户评价";
    
    [self.view addSubview:self.tableView];
    
    //注册 ，当发布完成之后，返回 刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView)
                                                 name:NotificationPublishFinish
                                               object:nil];
    
    self.title = @"用户评价";
    
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
    if (self.type==0) {//机构 教师 评价
       url = [NSString stringWithFormat:@"%@?teacher_phone=%@&filter=%@&page=%ld",YEvaluationDetails,self.code,@(self.menuInfo.index),(long)_page];
    }else{
        //课程评价
      url = [NSString stringWithFormat:@"%@?courseid=%@&filter=%@&page=%ld",YCourseDetails,self.code,@(self.menuInfo.index),(long)_page];
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%@?courseid=%@&filter=%@&page=%ld",YCourseDetails,self.code,@(self.menuInfo.index),(long)_page]);
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

//加载更多
-(void)loadMore{
    _page ++;
    
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?teacher_phone=%@&filter=%@&page=%ld",YEvaluationDetails,self.code,@(0),(long)_page] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
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
            
            [self.listArray addObjectsFromArray:arr];
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                if (arr.count==0) {
                    self.tableView.mj_footer.hidden = YES;
                }
                /** 记录最后一条数据的时间*/
                //                YSJCommentFrameModel *modelF = [arr lastObject];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        FFDifferentWidthTagCell *cell = [FFDifferentWidthTagCell loadCode:tableView];
        cell.tagModel = _commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    YSJCommentCell*cell = [YSJCommentCell loadCode:tableView];
    cell.statusFrame = self.listArray[indexPath.row];
    
    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        return _commentModel.cellHeight;
    }
    YSJCommentFrameModel *frame = self.listArray[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-KBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight+49, 0);
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

