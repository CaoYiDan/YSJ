
#import "SPMineIdentifiDetailVC.h"
#import "YSJUserModel.h"
#import "YSJMyCenterVC.h"
#import "YSJMineHeaderView.h"
#import "GTBProfileVC.h"
#import "YSJPopApplicationView.h"
@interface YSJMyCenterVC ()<UITableViewDelegate,UITableViewDataSource,MineHeaderViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YSJUserModel *model;
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,strong) YSJMineHeaderView *headerView;
@end

@implementation YSJMyCenterVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleArr = @[@"个人主页",@"平台规则",@"在线客服",@"意见反馈"];
    self.titleImageArr = @[@"guize",@"geren",@"kefu",@"fankui"];
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        self.model = [YSJUserModel mj_objectWithKeyValues:responseObject];
        self.headerView.model = self.model;
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
        self.headerView.numberDic = numdic;
        
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
    return 120;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 120)];
    footer.backgroundColor =KWhiteColor;
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark - header点击代理事件

- (void)mineHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index{
    NSLog(@"%@",type);
    if ([type isEqualToString:@"set"]) {
        
    }else if ([type isEqualToString:@"insert"]){
        GTBProfileVC *vc = [[GTBProfileVC alloc]init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"icon"]){
        
    }else if ([type isEqualToString:@"topBottom"]){
        
    }else if ([type isEqualToString:@"middle"]){
        
    }else if ([type isEqualToString:@"application"]){
        YSJPopApplicationView *popView = [[YSJPopApplicationView alloc]initWithFrame:self.view.bounds];
        popView.type = index;
        [self.view addSubview:popView];
    }
}

#pragma mark  - CustomDelegate

#pragma mark event response

#pragma mark private methods

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = grayF2F2F2;
       _tableView.backgroundColor = KMainColor; _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49);
        _tableView.tableHeaderView = self.headerView;
        _tableView.rowHeight = 50;
        _tableView.contentInset =UIEdgeInsetsMake(0, 0, 10+KBottomHeight-80, 0);
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

-(YSJMineHeaderView *)headerView{
    
    if (!_headerView){
        _headerView = [[YSJMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, bgImgH + 2*kMargin + categotyH+kMargin+activityH)];
        _headerView.delegate = self;
    }
    return _headerView;
}

#pragma mark -  滚动tableview 完毕之后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    //图片高度
//    CGFloat imageHeight = self.headerView.bgImgView.frameHeight;
//    //图片宽度
//    CGFloat imageWidth = kWindowW;
//    //图片上下偏移量
//    CGFloat imageOffsetY = scrollView.contentOffset.y/10.0;
//    //上移
//    if (imageOffsetY <= 0) {
//
//        CGFloat totalOffset = imageHeight - imageOffsetY;
//        NSLog(@"%.0f,%.0f,%.0f",totalOffset,imageOffsetY,imageHeight);
//
//        self.headerView.bgImgView.frame = CGRectMake(0, imageOffsetY, imageWidth , totalOffset);
//        self.headerView.frame = CGRectMake(0, 0, imageWidth ,totalOffset+300);
//        if (imageOffsetY==0) {
//            self.headerView.bgImgView.frame = CGRectMake(0, 0, imageWidth ,bgImgH);
//        }
//    }
}

@end
