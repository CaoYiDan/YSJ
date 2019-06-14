#import "YSJHomeWorkVC.h"
#import "YSJSaiShiCell.h"
#import "YSJSaiShiVC.h"
#import "YSJHuoDongBigCell.h"
#import "YSJHuoDongCell.h"
#import "YSJHuoDongModel.h"
#import "SPActivityWebVC.h"
@interface YSJSaiShiVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray * titleArr;

@end

@implementation YSJSaiShiVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getData];
    [self getNum];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork
-(NSMutableArray*)titleArr{
    if (!_titleArr) {
        _titleArr = @[].mutableCopy;
    }
    return _titleArr;
}
-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:self.type==0?@"赛事":@"活动行" forKey:@"type"];
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:@(0) forKey:@"page"];
    [[HttpRequest sharedClient]httpRequestPOST:Ymatchshow parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        self.titleArr = [YSJHuoDongModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
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
    
    return self.titleArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==1) {
        if (indexPath.row==0) {
            
            YSJHuoDongBigCell *cell = [YSJHuoDongBigCell loadCode:tableView];
            cell.model = self.titleArr[indexPath.row];
            return cell;
        }else{
            YSJHuoDongCell *cell = [YSJHuoDongCell loadCode:tableView];
              cell.model = self.titleArr[indexPath.row];
            return cell;
        }
    }
    
    YSJSaiShiCell *cell = [YSJSaiShiCell loadCode:tableView];
    cell.model = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     YSJHuoDongModel *model = self.titleArr[indexPath.row];
    SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
   
    if (self.type==1) {
        vc.url = model.activity_url;
        vc.titleName = model.activity_title;
       
    }else{
        vc.url = model.match_url;
        vc.titleName = model.match_title;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==1) {
        return indexPath.row==0?182+121:131;
    }else{
        return  364+12*2+10;
    }
}
#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = grayF2F2F2;
        _tableView.backgroundColor = KWhiteColor;
        _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49-SafeAreaTopHeight);
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

@end
