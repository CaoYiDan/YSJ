#import "YSJHomeWorkVC.h"
#import "YSJHomeWorkTypeListCell.h"
#import "YSJHomeWorkCommentsVC.h"

@interface YSJHomeWorkCommentsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * subTitleArr;

@end

@implementation YSJHomeWorkCommentsVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"作业点评";
    
    self.titleArr = @[@{@"img":@"ic_buzhi",@"name":@"布置作业"},@{@"img":@"ic_dianpin",@"name":@"点评作业"},@{@"img":@"tijiao ",@"name":@"提交作业"}];
    
    self.subTitleArr = @[@"guize",@"geren",@"kefu",@"fankui"];
    
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self getData];
    [self getNum];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
    
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
    if ([self.identifier isEqualToString:User_Company]) {
        return 2;
    }
    return self.titleArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJHomeWorkTypeListCell *cell = [YSJHomeWorkTypeListCell loadCode:tableView];
    [cell setDic:self.titleArr[indexPath.row]];
    cell.subText = self.subTitleArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 120;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 120)];
    footer.backgroundColor =KWhiteColor;
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJCellType type = 0;
    
    if (indexPath.row==0){
        
        type = HomeWorkPublish;
        
    } else if (indexPath.row==1){
        
        type = HomeWorkComment;
        
    }else{
        
        type = HomeWorkCommit;
        
    }
    
    YSJHomeWorkVC *vc = [[YSJHomeWorkVC alloc]init];
    vc.homeWorkType = type;
    
    vc.identifier = self.identifier;
    
    [self.navigationController pushViewController:vc animated:YES];
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
        _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49);
        
        _tableView.rowHeight = 81+17;
     
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

@end
