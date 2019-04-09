
#import "SPAllCategoryVC.h"

#import "SPAllCategoryLeftView.h"

#import "SPAllCategoryRightView.h"

#import "SPKungFuModel.h"

#import "SPKitExample.h"

@interface SPAllCategoryVC ()<UISearchBarDelegate,RightDelegate>
// 分类主菜单（必须设为全局的）
@property (nonatomic, strong) SPAllCategoryLeftView *categoryLeftView;
// 详细分类列表
@property (nonatomic, strong) SPAllCategoryRightView *categoryRightView;

@property(nonatomic,strong)NSMutableArray*dataArray;

@end

@implementation SPAllCategoryVC

#pragma mark lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.titleLabel.text = @"全部分类";
    self.view.backgroundColor  = [UIColor whiteColor];
      //加载数据
    if ([self.formType isEqualToString:@"我要赚钱"]) {
        [self loadData1];
    }else{
  
    [self loadData];
    }
    // 1. 设置导航条
    [self setNavigationBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)loadData1{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:SKILL forKey:@"rootType"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:listSkillsByUser parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject[@"data"]);
        self.dataArray = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 3. 添加分类主菜单
        [self addCategoryLeftView];
        
        // 4. 添加详细分类列表
        [self addCategoryRightView];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    // 恢复tabBar
//    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;    //让子控制器滑动
    }
}

#pragma mark - 请求数据
-(void)loadData{
    
    [[HttpRequest sharedClient]httpRequestGET:kUrlListSkill parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.dataArray = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 3. 添加分类主菜单
        [self addCategoryLeftView];
        
        // 4. 添加详细分类列表
        [self addCategoryRightView];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self.categoryLeftView endRefresh];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - action
#pragma  mark   SCCategoryDetailControllerRefresh----刷新
-(void)SCCategoryDetailControllerRefresh{
    [self loadData];
}

#pragma mark - 懒加载

-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(SPAllCategoryLeftView *)categoryLeftView {
    
    if (_categoryLeftView == nil) {
        
        _categoryLeftView   = [[SPAllCategoryLeftView alloc] init];
        // 计算分类主菜单视图尺寸
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat height = self.view.frameHeight ;
        
        _categoryLeftView.tableView.frame = CGRectMake(x, y, categoryWid, height);
        
        _categoryLeftView.tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
        
        [self.view addSubview:_categoryLeftView.tableView];
    }
    
    return _categoryLeftView;
}

-(SPAllCategoryRightView *)categoryRightView {
    
    if (_categoryRightView == nil) {
        _categoryRightView = [[SPAllCategoryRightView alloc] init];
//        _categoryRightView.delegate=self;
        // 计算详细分类列表视图尺寸
        CGFloat x                        = CGRectGetMaxX(self.categoryLeftView.tableView.frame);
        CGFloat y                        = self.categoryLeftView.tableView.originY;
        CGFloat width                    = self.view.frameWidth - categoryWid;
        CGFloat height                   = self.view.frameHeight-y;
        
        _categoryRightView.view.frame = CGRectMake(x, y, width, height);
        _categoryRightView.type = self.formType;
        _categoryRightView.delegate = self;
        [self.view addSubview:_categoryRightView.view];
    }
    return _categoryRightView;
}

#pragma mark 设置导航条
- (void)setNavigationBar {
   
}

#pragma mark 添加一级分类菜单
- (void)addCategoryLeftView {
    self.categoryLeftView.dataArr=self.dataArray;
    //刷新数据
//    [self.categoryLeftView reloadMyTableView];
}

#pragma mark 添加详细分类列表
- (void)addCategoryRightView {
    self.categoryRightView.dataArr=self.dataArray;
}

#pragma mark - RightDelegate
- (void)willDisplayHeaderView:(NSInteger)section {
    
    [self.categoryLeftView selectedIndex:section];
}

- (void)didEndDisplayingHeaderView:(NSInteger)section {
    
    [self.categoryLeftView selectedIndex:section+1];
}

@end
