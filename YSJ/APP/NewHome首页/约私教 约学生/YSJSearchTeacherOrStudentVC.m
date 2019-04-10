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
#import "YSJSearchTeacherOrStudentVC.h"
#import "DOPDropDownMenu.h"
#import "YSJTeacherListCell.h"
#import "YSJSwitchView.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
#import "YSJRequestListCell.h"
#import "YSJCompanyListCell.h"
#define  firstMenuH 44.0
@interface YSJSearchTeacherOrStudentVC ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource,SwitchDelegate>

@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSMutableArray *cates;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSMutableArray *categorys;

@property (nonatomic, strong) NSArray *sorts;

@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, weak) DOPDropDownMenu *menuB;
//大分类数组
@property (nonatomic,strong) NSMutableArray *bigCategoryArr;
//小分类数组
@property (nonatomic,strong) NSMutableArray *smallCategoryArr;
//选中的大分类
@property (nonatomic,strong) NSMutableDictionary *selectedbigCategoryDic;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation YSJSearchTeacherOrStudentVC
{
    BOOL _firstIn;//第一次进入，
    BOOL _firstSelectedMenu;//第一次选中menu(控件默认第一次进入即选中)，
    NSMutableDictionary *_siftingDic;
    
    int _page;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _firstIn = YES;
    
    _firstSelectedMenu = YES;
    
    [self setTitleName];
    
    //初始化首次进入默认的请求字典
    [self configSiftingDic];
    
    WeakSelf;
    
    //获取私教list数据
     [self.tableView.mj_header beginRefreshing];
    
    //获取分类
    [self getCategoryRequestisScu:^(BOOL isScu) {
        //大分类View
        [weakSelf setTopSliderSwitchView];
    }];
    
    //获取城市位置信息
    [self getCityRequestisScu:^(BOOL isScu) {
        if (isScu)
        {
            //设置下拉菜单
            [weakSelf setMenuView];
        }
    }];
    
    //加载tableView
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 获取城市位置数据

- (void)getCityRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSLog(@"%@",self.city);
    
    NSString *url = [NSString stringWithFormat:@"%@?city=%@",YHomeAreas,self.city];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[HttpRequest sharedClient]httpRequestGET:url parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        //        [self.locations addObject:@{@"area":@"位置",@"subarea":@[]}];
        [self.locations addObject:@{@"area":@"附近",@"subarea":@[@"附近",@"1km",@"2km",@"4km",@"5km",@"10km"]}];
        [self.locations addObjectsFromArray:responseObject[@"addresses"]];
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(NO);
        
    }];
}

#pragma mark - 获取大分类数据
- (void)getCategoryRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestGET:YHomefindcategory parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.bigCategoryArr = responseObject[@"coursetype"];
        self.categorys = responseObject[@"coursetype"];
        self.selectedbigCategoryDic = @{}.mutableCopy;
        self.selectedbigCategoryDic  = self.bigCategoryArr[0];
        NSLog(@"%@",self.selectedbigCategoryDic);
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

#pragma mark - 获取小分类数据
- (void)getSubCategoryRequestisScu:(void(^)(BOOL isScu))requestisScu{
    NSString *url = [NSString stringWithFormat:@"%@?coursetype=%@",YHomefindsubcategory,self.selectedbigCategoryDic[@"name"]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HttpRequest sharedClient]httpRequestGET:url parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.categorys = responseObject[@"coursetypes"];
        
        [_menu selectIndexPath:[DOPIndexPath indexPathWithCol:1 row:0]];
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

#pragma mark - 初始化请求dic
-(void)configSiftingDic{
    
    _siftingDic = @{}.mutableCopy;
    
    [_siftingDic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    
    [_siftingDic setObject:[StorageUtil getId] forKey:@"token"];
    
    [_siftingDic setObject:self.city forKey:@"city"];
    
    //最高(如果是N元以上则，high=low)
    //    [_siftingDic setObject:@{@"low":@"10",@"high":@"1000"} forKey:@"priceorder"];
    //筛选条件 int: 0,智能排序 1,离我最近 2,好评优先 3,人气优先
    
    //    [_siftingDic setObject:0 forKey:@"filter"];
    
    NSLog(@"%@",_siftingDic);
}

#pragma mark - 获取list信息
-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    _page = 0;
    
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
        
        if (self.cellType == HomeCellTeacher) {
            self.dataArr  = [YSJTeacherModel mj_objectArrayWithKeyValuesArray:responseObject[teachers]];
        }else if (self.cellType == HomeCellCompany){
            self.dataArr  = [YSJCompanysModel mj_objectArrayWithKeyValuesArray:responseObject[companys]];
        }else if (self.cellType == HomeCellRequiment){
            self.dataArr  = [YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_courses"]];
        }
        if (self.dataArr.count==0) {
          
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

#pragma mark - menu Delegate
- (void)menuReloadData
{
    
    [_menu reloadData];
}

- (IBAction)selectIndexPathAction:(id)sender {
    [_menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:2 item:2]];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.locations.count;
    }else if (column == 1){
        return self.categorys.count;
    }else if (column == 2){
        return self.prices.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        
        return self.locations[indexPath.row][@"area"];
        
    } else if (indexPath.column == 1){
        return self.categorys[indexPath.row][@"name"];
    }  else if (indexPath.column == 2){
        return self.prices[indexPath.row];
    }else {
        return self.sorts[indexPath.row];
    }
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return nil;
}

//- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
//{
//    return [@(arc4random()%1000) stringValue];
//}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        NSArray *arr = self.locations[row][@"subarea"];
        return arr.count;
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        
        //在此处约定好，如果是Item==1000,则说明选择的是”全部“,此时 只返回1级目录的名字
        if (indexPath.item==1000) {
            return self.locations[indexPath.row][@"area"];
        }else{
            NSArray *arr = self.locations[indexPath.row][@"subarea"];
            return arr[indexPath.item];
        }
        
    }
    return nil;
}

- (NSIndexPath *)menu:(DOPDropDownMenu *)menu willSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    if (indexPath.item > 0) {
        return [NSIndexPath indexPathForRow:indexPath.item inSection:0];
    } else {
        return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.column];
    }
}

#pragma mark  menu 点击事件

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column==0) {
        
        [self setPostConfigForLocation:indexPath];
        
    }else if(indexPath.column==1){
        [self setPostConfigForCategory:indexPath];
    }else if(indexPath.column==2){
        
        [self setForPriceWithRow:indexPath];
        
    }else if(indexPath.column==3){
        
        
        //"filter":"0/1/2/3"
        [_siftingDic setObject:@(indexPath.row) forKey:@"filter"];
    }
    //第一次进入 会默认选中Menu 0-0-0  在此处理避免重复请求
    if (_firstSelectedMenu) {
        
        _firstSelectedMenu = NO;
        
    }else{
        //如果是点击的 位置的一级 则不会触发数据请求
        if (!(indexPath.column==0 && indexPath.item<0)) {
            [self.tableView.mj_header beginRefreshing];
        }
    }
}
#pragma mark  点击分类配置请求
-(void)setPostConfigForCategory:(DOPIndexPath *)indexPath{
    //如果此条件为空，则说明此categorys里装的是大分类数据，则此时上传的参数依然是大分类id
    NSLog(@"%@",self.categorys[indexPath.row][@"category"]);
    if (self.categorys == self.bigCategoryArr) {
        
        //大分类id
        [_siftingDic setObject:self.categorys[indexPath.row][@"name"] forKey:@"coursetype"];
        
        //小分类id 置空
        [_siftingDic setObject:@"" forKey:@"coursetypes"];
        
    }else{
        
        //大分类id 置空
        [_siftingDic setObject:self.selectedbigCategoryDic[@"name"] forKey:@"coursetype"];
        
        //小分类id
        [_siftingDic setObject:self.categorys[indexPath.row][@"name"] forKey:@"coursetypes"];
    }
}

#pragma mark  点击位置配置请求
-(void)setPostConfigForLocation:(DOPIndexPath*)indexPath{
    if (indexPath.column==0 && indexPath.item>=0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        NSArray *arr =   @[@"",@(1),@(2),@(4),@(5),@(10)];
        if (indexPath.row==0 && indexPath.item==0) {
            [_siftingDic setObject:@"" forKey:@"longest"];
            
            [_siftingDic setObject:@"" forKey:@"subarea"];
            [_siftingDic setObject:@"" forKey:@"area"];
        }else if (indexPath.row==0 ){
            
            [_siftingDic setObject:arr[indexPath.item] forKey:@"longest"];
            
            [_siftingDic setObject:@"" forKey:@"subarea"];
            [_siftingDic setObject:@"" forKey:@"area"];
        }else if(indexPath.item == 0){
            [_siftingDic setObject:@"" forKey:@"longest"];
            
            [_siftingDic setObject:@"" forKey:@"subarea"];
            [_siftingDic setObject:self.locations[indexPath.row][@"area"] forKey:@"area"];
        }else{
            [_siftingDic setObject:@"" forKey:@"longest"];
            
            [_siftingDic setObject:self.locations[indexPath.row][@"subarea"][indexPath.item] forKey:@"subarea"];
            [_siftingDic setObject:@"" forKey:@"area"];
        }
        
    }
}

#pragma mark  点击价格配置请求
-(void)setForPriceWithRow:(DOPIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [_siftingDic setObject:@{@"low":@"0",@"high":@"1000000"} forKey:@"priceorder"];
    }else if (indexPath.row==1){
        [_siftingDic setObject:@{@"low":@"0",@"high":@"1000"} forKey:@"priceorder"];
    }else if (indexPath.row==2){
        [_siftingDic setObject:@{@"low":@"1000",@"high":@"2000"} forKey:@"priceorder"];
    }else if (indexPath.row==3){
        [_siftingDic setObject:@{@"low":@"2000",@"high":@"1000000"} forKey:@"priceorder"];
    }
}

#pragma mark 点击”价格确定“
-(void)priceDidClickSureWithLow:(NSInteger)low high:(NSInteger)high{
    
    [_siftingDic setObject:@{@"low":@(low),@"high":@(high)} forKey:@"priceorder"];
    
     [self.tableView.mj_header beginRefreshing];
}

-(void)menu:(DOPDropDownMenu *)menu didShow:(BOOL)isShow {
    NSLog(@"didShow:%d", isShow);
}

#pragma  mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cellType == HomeCellTeacher) {
        YSJTeacherListCell *cell = [YSJTeacherListCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }else if (self.cellType == HomeCellCompany){
        YSJCompanyListCell *cell = [YSJCompanyListCell loadCode:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }else if (self.cellType == HomeCellRequiment){
        YSJRequestListCell *cell = [YSJRequestListCell loadCode:tableView];
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
            return 110;
    }else{
        return 131;
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

#pragma mark - 大分类点击代理事件
- (void)switchViewDidSelectedIndexRow:(NSInteger)indexRow{
    
    //大分类di
    [_siftingDic setObject:self.bigCategoryArr[indexRow][@"name"] forKey:@"coursetype"];
    
    //小分类id 置空
    [_siftingDic setObject:@"" forKey:@"coursetypes"];
    
    _selectedbigCategoryDic = self.bigCategoryArr[indexRow];
    
    if (indexRow==0) {//如果点击的”全部“，则直接赋值，并选中分类的第一行
        self.categorys = self.bigCategoryArr;
        [_menu selectIndexPath:[DOPIndexPath indexPathWithCol:1 row:0]];
    }else{
        //获取小分类
        [self getSubCategoryRequestisScu:^(BOOL isScu) {
            
        }];
    }
}

#pragma mark - setter

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,firstMenuH + 44, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-(firstMenuH + 44)) style:UITableViewStylePlain];
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

#pragma mark 设置顶部大分类view
-(void)setTopSliderSwitchView{
    YSJSwitchView *topSwitchView = [[YSJSwitchView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 44)];
    topSwitchView.delegate = self;
    topSwitchView.backgroundColor = KMainColor;
    topSwitchView.listArr = self.categorys;
    [self.view addSubview:topSwitchView];
}

#pragma mark 设置下拉菜单
-(void)setMenuView{
    
    self.prices = @[@"不限",@"1000以下",@"1000以上",@"2000以上"];
    self.sorts = @[@"智能排序",@"离我最近",@"好评优先",@"人气优先"];
    self.sorts = @[@"智能排序",@"离我最近",@"好评优先",@"人气优先"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0,firstMenuH) andHeight:44];
    menu.textColor = [UIColor hexColor:@"666666"];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    //    _menu.finishedBlock=^(DOPIndexPath *indexPath){
    //        if (indexPath.item >= 0) {
    //            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    //        }else {
    //            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    //        }
    //    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    
    [menu selectDefalutIndexPath];
    
    //    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}

-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

-(void)setTitleName{
    if (self.cellType == HomeCellTeacher) {
        self.title = @"约私教";
    }else if (self.cellType == HomeCellCompany){
        self.title = @"约机构";
    }else if (self.cellType == HomeCellRequiment){
        self.title = @"约学生";
    }
}

-(NSMutableArray*)locations{
    if (!_locations) {
        _locations = @[].mutableCopy;
    }
    return _locations;
}
@end

