
#import "YSJHongBaoCell.h"
#import "YSJHongBaoVC.h"
#import "YSJGBModel.h"

@interface YSJHongBaoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray* dataArr;

@end

@implementation YSJHongBaoVC

#pragma mark life cycle
-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"作业点评";
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:NotificationMoreBtnFinishOption object:nil];
}

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getData];
    [self getNum];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSArray *arr = @[@"已领到",@"已失效",@"已创建"];
    
    NSMutableDictionary *dic = @{}.mutableCopy;
   
    [dic setObject:@(0) forKey:@"page"];
    NSLog(@"%@",dic);
    NSString *url ;
    if (self.type == HBTypeDiscover) {
       url = Yredpacketgather;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
       
    }else{
        url  = Yredpacketshow;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:arr[self.index] forKey:@"type"];
    }
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        NSArray *arr2 = responseObject;
        if (arr2.count!=0) {
           [NSObject propertyCodeWithDictionary:responseObject[0]];
        }
        self.dataArr = [YSJGBModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)getNum{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YNumber parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSDictionary * re = responseObject;
        NSMutableDictionary *numdic = re.mutableCopy;
        [numdic setObject:@(0) forKey:@"haveLook"];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJHongBaoCell *cell = [YSJHongBaoCell loadCode:tableView];
    cell.model = self.dataArr[indexPath.row];
    if (self.index!=2) {
        cell.type = HBTypeGet;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = grayF2F2F2;
        _tableView.backgroundColor = KWhiteColor;
       self.view.backgroundColor = RGB(240, 240, 240); _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49-30);
        
        _tableView.rowHeight =96+70+18-35;
        
        [self.view addSubview:_tableView];
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
        
    }
    return _tableView;
}

@end
