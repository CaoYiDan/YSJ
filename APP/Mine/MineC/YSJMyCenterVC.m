#import "YSJHBListVC.h"
#import "SPMineIdentifiDetailVC.h"
#import "YSJUserModel.h"
#import "YSJMyCenterVC.h"
#import "YSJHomeWorkVC.h"
#import "YSJMineHeaderView.h"
#import "GTBProfileVC.h"
#import "YSJCompanyProfileVC.h"
#import "YSJProfile.h"
#import "YSJHomeWorkCommentsVC.h"
#import "YSJMyCareVC.h"
#import "YSJCollectionVC.h"
#import "YSJPlatformRulesFirstListVC.h"
#import "YSJBuyManagerVC.h"
#import "YSJMyPublish_RequimentVC.h"
#import "YSJPopApplicationView.h"
#import "YSJSellManagerVC.h"
#import "YSJOrderDeatilVC.h"

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
    [dic setObject:[StorageUtil getRole] forKey:@"type"];
     [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
          if (isEmptyString(responseObject[@"status"])) {
              self.model = [YSJUserModel mj_objectWithKeyValues:responseObject];
              self.headerView.model = self.model;
          }else{
              //status不等于200,属于token 过期，重新登录
              [StorageUtil saveId:@""];
              [SPCommon gotoLogin];
              self.tabBarController.selectedIndex =4;
          }
       
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
    
    if (indexPath.row==0) {
        
        YSJProfile *vc = [[YSJProfile alloc]init];
        vc.identifier = User_Company;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
     
        YSJPlatformRulesFirstListVC *vc = [[YSJPlatformRulesFirstListVC alloc]init];
        
       [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
        YSJCompanyProfileVC *vc = [[YSJCompanyProfileVC alloc]init];
        vc.identifier = User_Company;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - header点击代理事件

- (void)mineHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index{
    
    NSLog(@"%@",type);
    
    if ([type isEqualToString:@"set"]) {
        [StorageUtil saveId:@""];
        
    }else if ([type isEqualToString:@"insert"]){
        
        GTBProfileVC *vc = [[GTBProfileVC alloc]init];
        NSLog(@"%@",self.model.photo);
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"icon"]){
        
    }else if ([type isEqualToString:@"topBottom"]){
        
        if (index==0) {
            YSJCollectionVC *vc = [[YSJCollectionVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index==1){
            
            YSJMyCareVC *vc = [[YSJMyCareVC alloc]init];
            vc.identifier = User_Normal;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index==3){
            YSJHBListVC *vc = [[YSJHBListVC alloc]init];
            vc.identifier = User_Teacher;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }else if ([type isEqualToString:@"middle"]){
        
        if (index==0) {
            
            YSJMyPublish_RequimentVC *vc = [[YSJMyPublish_RequimentVC alloc]init];
            vc.identifier = User_Teacher;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index==1){
            
            YSJBuyManagerVC* vc = [[YSJBuyManagerVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index==2){
            
            YSJSellManagerVC* vc = [[YSJSellManagerVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index==3){
            if (![[StorageUtil getRole] isEqualToString:User_Normal]) {
                YSJHomeWorkVC *vc = [[YSJHomeWorkVC alloc]init];
                vc.homeWorkType = HomeWorkCommit;
                
                vc.identifier = [StorageUtil getRole];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
               
            YSJHomeWorkCommentsVC *vc = [[YSJHomeWorkCommentsVC alloc]init];
            vc.identifier = [StorageUtil getRole];
            [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (index==4){
            
         }

    }else if ([type isEqualToString:@"application"]){
        
        YSJPopApplicationView *popView = [[YSJPopApplicationView alloc]initWithFrame:self.view.bounds];
        popView.type = index;
        [self.view addSubview:popView];
    }
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
        _tableView.tableHeaderView = self.headerView;
        _tableView.rowHeight = 50;
        _tableView.contentInset =UIEdgeInsetsMake(0, 0, 10+KBottomHeight-80, 0);
        [self.view addSubview:_tableView];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, -kWindowH, kWindowW, kWindowH)];
        lab.font = font(11);
        lab.backgroundColor = KMainColor;
        lab.textColor = KWhiteColor;
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................";
        [_tableView addSubview:lab];
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

@end
