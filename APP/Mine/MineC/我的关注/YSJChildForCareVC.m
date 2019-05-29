//
//  ViewController.m
//  DOPdemo
//
//  Created by tanyang on 15/3/22.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//
#import "YSJSpellListDetailVC.h"
#import "YSJCompanyCourse_FreeDetailVC.h"
#import "YSJTeacherCourse_OneByOneVC.h"
#import "YSJStudent_DetailVC.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJCompany_DetailVC.h"
#import "YSJTeacherModel.h"
#import "YSJCompanyCourseVC.h"
#import "YSJMyPublishForCompanyFreeCell.h"
#import "YSJMyPublishForTeacherOneByOneCell.h"
#import "YSJChildForCareVC.h"
#import "YSJMyPublishForTeacherPinDanCell.h"
#import "YSJMyCareCell.h"
#import "YSJCourseModel.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
#import "YSJMyPublishForTeacherCell.h"
#import "YSJCompanyListCell.h"

@interface YSJChildForCareVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YSJChildForCareVC
{
    
    NSMutableDictionary *_siftingDic;
    
    int _page;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cellType = MyPublishTypeTeacherCourse;
    
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
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 初始化请求dic
-(void)configSiftingDic{
    
    
    NSLog(@"%@",_siftingDic);
}

#pragma mark - 获取list信息
-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    _page = 0;
    
    _siftingDic = @{}.mutableCopy;
    
    [_siftingDic setObject:[StorageUtil getId] forKey:@"token"];
    
    [_siftingDic setObject:self.type forKey:@"type"];
    
    NSLog(@"%@",_siftingDic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YMyFollow parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //requestisScu(YES);
      
        NSLog(@"%@",responseObject);
        self.dataArr = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject];
       
        if (self.dataArr.count<5) {
            
            self.tableView.mj_footer.hidden = YES;
            
        }else{
            
            self.tableView.mj_footer.hidden = NO;
            
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark  将获取的数据转化为数组

-(NSMutableArray *)getMyDataArrWithResponseObject:(id)responseObject{
    
    NSMutableArray *arr = @[].mutableCopy;
    
    if (self.cellType == MyPublishTypeFindTeacher) {
        
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
        
    }else if (self.cellType == MyPublishTypeFindCompany){
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
    }else if (self.cellType == MyPublishTypeTeacherCourse){
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"teacher_course"]];
    }else if (self.cellType == MyPublishTypeTeacherRequement) {
        arr  = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
    }else if (self.cellType == MyPublishTypeCompanyFamous){
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
        
    }else if (self.cellType == MyPublishTypeCompanyJingPin){
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
    }else if (self.cellType == MyPublishTypeCompanyFree){
        arr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
    }
    
    return  arr;
}

#pragma mark 加载更多
-(void)loadMore{
    
    _page ++;
    
    [_siftingDic setObject:@(_page) forKey:@"page"];
    
    
    NSLog(@"%@",_siftingDic);
    [[HttpRequest sharedClient]httpRequestPOST:YMyFindAll parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        NSMutableArray *newArr = [self getMyDataArrWithResponseObject:responseObject];
        
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
   
    YSJMyCareCell *cell = [YSJMyCareCell loadCode:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   return 130;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJCourseModel *model  = self.dataArr[indexPath.row];
    
    if ([self.type isEqualToString:@"私教"]) {
       
        
        YSJTeacher_DetailVC *vc = [[YSJTeacher_DetailVC alloc]init];
        
        vc.teacherID = model.teacher_phone;
        
        [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
        
    }else{
        
        YSJCompany_DetailVC *vc = [[YSJCompany_DetailVC alloc]init];
        
        vc.companyID = model.teacher_phone;
        
        [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
    }
    
}


#pragma mark - setter

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-56) style:UITableViewStylePlain];
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

@end

