//
//  ViewController.m
//  DOPdemo
//
//  Created by tanyang on 15/3/22.
//  Copyright (c) 2015年 tanyang. All rights reserved.


#import "YSJStudent_DetailVC.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJCompany_DetailVC.h"
#import "YSJTeacherModel.h"
#import "YSJOrderModel.h"
#import "YSJChilderVCForBuyManager.h"
#import "YSJDrawBackDeatilVC.h"
#import "YSJOrderDeatilVC.h"
#import "YSJBuyManagerCell.h"
#import "YSJGetMoneyVC.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
#import "YSJMyPublishForTeacherCell.h"
#import "YSJCompanyListCell.h"

@interface YSJChilderVCForBuyManager ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YSJChilderVCForBuyManager
{
    
    NSMutableDictionary *_siftingDic;
    
    int _page;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //初始化首次进入默认的请求字典
    [self configSiftingDic];
    
    //获取私教list数据
    [self.tableView.mj_header beginRefreshing];
    
    //加载tableView
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:NotificationMoreBtnFinishOption object:nil];
}

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 初始化请求dic
-(void)configSiftingDic{
   
}

#pragma mark - 获取list信息
-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    _page = 0;
    NSArray *arr  = @[];
    
   
    NSString *url = @"";
    
    if (self.orderType == OrderTypeBuy) {
        url = YCourseUserBuy;
        arr = @[@"全部",@"待付款",@"待授课",@"交易完成",@"退款"];
        
    }else if(self.orderType== OrderTypeSale){
        
        url = YCourseUserSale;
        
        arr = @[@"全部",@"待授课",@"已完成",@"退款"];
        
    }else if(self.orderType==HomeWorkPublish || self.orderType==HomeWorkComment || self.orderType==HomeWorkCommit){
        
        if ([self.identifier isEqualToString:User_Company]) {
            url = Yhomeworkcompanystatus;
            
            if (self.orderType == HomeWorkPublish
                ) {
                arr = @[@"待布置",@"待提交"];
            }else if (self.orderType == HomeWorkComment){
                arr = @[@"待提交",@"待点评",@"已点评"];
            }
        }else{
            url = YHomeworkStatus;
            
            if (self.orderType == HomeWorkPublish
                ) {
                arr = @[@"待布置",@"待提交"];
            }else if (self.orderType == HomeWorkCommit){
                url = YCstatus;
                arr = @[@"待提交",@"待点评",@"已点评"];
            }else if (self.orderType == HomeWorkComment){
                arr = @[@"待提交",@"待点评",@"已点评"];
            }
        }
        
    }
    
    _siftingDic = @{}.mutableCopy;
    
    [_siftingDic setObject:arr[self.type] forKey:@"filter"];
    
    [_siftingDic setObject:[StorageUtil getId] forKey:@"token"];
    
    [_siftingDic setObject:@(_page) forKey:@"page"];
    
    NSLog(@"%@  %@",_siftingDic,url);
    
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //        requestisScu(YES);
        NSLog(@"%@",responseObject);
        if (self.orderType==HomeWorkPublish || self.orderType ==HomeWorkComment) {
            
            
            if ([self.identifier isEqualToString:User_Company]) {
                
                 self.dataArr = [YSJOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"company"]];
            }else{
                
              self.dataArr = [YSJOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order_teacher"]];
            }
            
        }else if (self.orderType==HomeWorkCommit) {
            
            self.dataArr = [YSJOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order_all"]];
            
        }else{
            
            self.dataArr  = [YSJOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order_all"]];
        }
        
      if (self.dataArr.count<=3) {
            
            self.tableView.mj_footer.hidden = YES;
            
        }else{
            
            self.tableView.mj_footer.hidden = NO;
            
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark 加载更多

-(void)loadMore{
    
    _page ++;
    
    [_siftingDic setObject:@(_page) forKey:@"page"];

    NSLog(@"%@",_siftingDic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YCourseUserBuy parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //        requestisScu(YES);
        NSLog(@"%@",responseObject);
        NSMutableArray *newArr = @[].mutableCopy;
        newArr  = [YSJOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"order_all"]];
        
        if (newArr.count==0) {
            Toast(@"没有更多了");
            
            self.tableView.mj_footer.hidden = YES;
        }else{
            
            [self.dataArr addObjectsFromArray:newArr];
            
            [self.tableView.mj_footer endRefreshing];
            
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    YSJBuyManagerCell *cell = [YSJBuyManagerCell loadCode:tableView];
    cell.orderType = self.orderType;
    cell.model = self.dataArr[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
      return 208;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.orderType == HomeWorkCommit || self.orderType == HomeWorkComment || self.orderType == HomeWorkPublish) {
        return;
    }
    
    YSJOrderModel *model = self.dataArr[indexPath.row];
    
    if ([model.order_status containsString:@"退款"]) {
        
        YSJDrawBackDeatilVC *vc = [[YSJDrawBackDeatilVC alloc]init];
        vc.model = model;
        vc.orderType = self.orderType;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    }else{
        
        YSJOrderDeatilVC *vc = [[YSJOrderDeatilVC alloc]init];
        vc.model = model;
        vc.orderType = self.orderType;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - setter

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight, 0);
        
        
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getListRequestisScu:)];
        //footer
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        //_tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

#pragma mark - TableView 占位图
-(UIView *)xy_noDataView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-SafeAreaTopHeight-100)];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_task"]];
    img.center = view.center;
    [view addSubview:img];
     return view;
}
- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"no_task"];
}

- (NSString *)xy_noDataViewMessage {
    return @"hijkhhkhj";
}

- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
}

@end

