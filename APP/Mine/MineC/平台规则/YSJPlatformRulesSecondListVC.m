
#import "YSJPlatformRulesSecondListVC.h"
#import "YSJPlatformRulesWebVC.h"
@interface YSJPlatformRulesSecondListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray * titleArr;

@property (nonatomic,strong) NSArray * titleImageArr;

@end

@implementation YSJPlatformRulesSecondListVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.rule1;
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self getData];
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork
-(void)getData{
    
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:self.rule1 forKey:@"rule1"];
    [dic setObject:@"" forKey:@"rule2"];
    [[HttpRequest sharedClient]httpRequestPOST:YRules parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.titleArr = @[].mutableCopy;
        self.titleArr = responseObject;
        [self.tableView reloadData];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * mineCell = @"mineCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = font(16);
        cell.textLabel.textColor = KBlack333333;
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSJPlatformRulesWebVC *vc = [[YSJPlatformRulesWebVC alloc]init];
    vc.rule1 = self.rule1;
    vc.rule2 = self.titleArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49);
        
        _tableView.rowHeight = 69;
        _tableView.contentInset =UIEdgeInsetsMake(0, 0, 10+KBottomHeight-80, 0);
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

@end
