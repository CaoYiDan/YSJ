//
//  ViewController.m
//  DOPdemo
//
//  Created by tanyang on 15/3/22.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "YSJStudent_DetailVC.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJCompany_DetailVC.h"
#import "YSJTeacherModel.h"
#import "YSJMyPublishForCompanyFreeCell.h"
#import "YSJMyPublishForTeacherOneByOneCell.h"
#import "YSJMyPublishForFindTeacherVC.h"

#import "YSJTeacherListCell.h"
#import "YSJCourseModel.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
#import "YSJMyPublishForTeacherCell.h"
#import "YSJCompanyListCell.h"

@interface YSJMyPublishForFindTeacherVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YSJMyPublishForFindTeacherVC
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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 初始化请求dic
-(void)configSiftingDic{
    
    _siftingDic = @{}.mutableCopy;
    
    
    [_siftingDic setObject:@"MTU1ODA4NTMzMy40MTUyMzU1OjA0YWI2ZTBkNzIyYmZkODRhYjIxNzIzMGQ1ZmRmNGQ0MmFkOGYxNzI=" forKey:@"token"];
    
    
    NSLog(@"%@",_siftingDic);
}

#pragma mark - 获取list信息
-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    _page = 0;
    
    [_siftingDic setObject:@(_page) forKey:@"page"];
    
    
    if (self.cellType == MyPublishTypeFindTeacher) {
        [_siftingDic setObject:@"私教" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeFindCompany){
        [_siftingDic setObject:@"机构" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeTeacherCourse){
        [_siftingDic setObject:@"课程" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeTeacherRequement) {
        [_siftingDic setObject:@"需求" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeCompanyFamous){
        [_siftingDic setObject:@"明星课" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeCompanyJingPin){
        [_siftingDic setObject:@"精品课" forKey:@"course_type"];
    }else if (self.cellType == MyPublishTypeCompanyFree){
        [_siftingDic setObject:@"试听课" forKey:@"course_type"];
    }
    
    NSLog(@"%@",_siftingDic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YMyFindAll parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //requestisScu(YES);
        NSLog(@"%@",responseObject);
        
        if (self.cellType == MyPublishTypeFindTeacher) {
            self.dataArr  = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
        }else if (self.cellType == MyPublishTypeFindCompany){
            self.dataArr  = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
        }else if (self.cellType == MyPublishTypeTeacherCourse){
            self.dataArr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"teacher_course"]];
        }else if (self.cellType == MyPublishTypeTeacherRequement) {
            self.dataArr  = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_course"]];
        }else if (self.cellType == MyPublishTypeCompanyFamous){
            self.dataArr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
        }else if (self.cellType == MyPublishTypeCompanyJingPin){
            self.dataArr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
        }else if (self.cellType == MyPublishTypeCompanyFree){
            self.dataArr  = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"company_course"]];
        }
        
        if (self.dataArr.count<3) {
            
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
    
    NSString *url = @"";
    
    if (self.cellType == HomeCellTeacher) {
        url = YHomeTeachercourses;
        
    }else if (self.cellType == HomeCellCompany){
        url = YHomefindCompanys;
        
    }else if (self.cellType == HomeCellRequiment){
        url = YHomeDemands;
    }
    NSLog(@"%@",_siftingDic);
    
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //        requestisScu(YES);
        NSLog(@"%@",responseObject);
        NSMutableArray *newArr = @[].mutableCopy;
        if (self.cellType == HomeCellTeacher) {
            newArr = [YSJTeacherModel mj_objectArrayWithKeyValuesArray:responseObject[teachers]];
        }else if (self.cellType == HomeCellCompany){
            newArr = [YSJCompanysModel mj_objectArrayWithKeyValuesArray:responseObject[companys]];
        }else if (self.cellType == HomeCellRequiment){
            newArr = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_courses"]];
        }
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
    //找私教 找机构 私教需求
    if (self.cellType == MyPublishTypeFindTeacher || self.cellType == MyPublishTypeFindCompany || self.cellType == MyPublishTypeTeacherRequement) {
        YSJMyPublishForTeacherCell *cell = [YSJMyPublishForTeacherCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
        //私教发布的课程
    }else if (self.cellType == MyPublishTypeTeacherCourse){
        YSJMyPublishForTeacherOneByOneCell *cell = [YSJMyPublishForTeacherOneByOneCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
        
        //机构发布的明星课程 精品课程
    }else if (self.cellType == MyPublishTypeCompanyJingPin || self.cellType == MyPublishTypeCompanyJingPin){
        YSJMyPublishForTeacherCell *cell = [YSJMyPublishForTeacherCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
        ///机构发布的试听课
    }else if (self.cellType == MyPublishTypeCompanyFree) {
        YSJMyPublishForCompanyFreeCell *cell = [YSJMyPublishForCompanyFreeCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL haveLabels  = NO;
    
    if (self.cellType == HomeCellTeacher) {
        
        YSJTeacherModel *model = self.dataArr[indexPath.row];
        if (!isEmptyString(model.lables)) haveLabels = YES;
        
    }else if (self.cellType == HomeCellCompany){
        YSJCompanysModel *model = self.dataArr[indexPath.row];
        if (!isEmptyString(model.lables)) haveLabels = YES;
        
    }else if (self.cellType == HomeCellRequiment){
        YSJRequimentModel *model = self.dataArr[indexPath.row];
        if (!isEmptyString(model.lables)) haveLabels = YES;
        
    }
    
    if(!haveLabels){
        return 154;
    }else{
        return 154;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellType==HomeCellTeacher) {
       
        YSJTeacherModel *model  = self.dataArr[indexPath.row];
        YSJTeacher_DetailVC *vc = [[YSJTeacher_DetailVC alloc]init];
        vc.teacherID = model.teacherID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.cellType == HomeCellCompany){
        YSJCompanysModel *model  = self.dataArr[indexPath.row];
        YSJCompany_DetailVC *vc = [[YSJCompany_DetailVC alloc]init];
        vc.companyID = model.companyID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YSJRequimentModel *model  = self.dataArr[indexPath.row];
        YSJStudent_DetailVC *vc = [[YSJStudent_DetailVC alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
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

