//
//  ViewController.m
//  DOPdemo
//
//  Created by tanyang on 15/3/22.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//
#import "YSJCompanyCourse_FreeDetailVC.h"
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
#import "YSJBuyManagerCell.h"
#import "YSJCourseModel.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
#import "YSJMyPublishForTeacherCell.h"
#import "YSJCompanyListCell.h"
#import "YSJCollectionVC.h"

@interface YSJCollectionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation YSJCollectionVC
{
    
    NSMutableDictionary *_siftingDic;
    
    int _page;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"收藏";
    
    self.cellType = MyPublishTypeFindTeacher;
    
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
    
    [_siftingDic setObject:@"课程" forKey:@"type"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YMyFollow parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //requestisScu(YES);
        NSLog(@"%@",responseObject);
        
        self.dataArr = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        if (self.dataArr.count<5) {
            
            self.tableView.mj_footer.hidden = YES;
            
        }else{
            
            self.tableView.mj_footer.hidden = YES;
            
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
    [[HttpRequest sharedClient]httpRequestPOST:YMyFindAll parameters:_siftingDic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
//
//
//        if (newArr.count==0) {
//            Toast(@"没有更多了");
//
//            self.tableView.mj_footer.hidden = YES;
//
//        }else{
//
//            [self.dataArr addObjectsFromArray:newArr];
//
//            [self.tableView.mj_footer endRefreshing];
//
//            [self.tableView reloadData];
//        }
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
    cell.orderType = CellTypeCollection;
    cell.courseModel = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 208;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJCourseModel *model = self.dataArr[indexPath.row];
    
    if ([model.type isEqualToString:@"试听课"]) {
        
        YSJCompanyCourse_FreeDetailVC
        *vc = [[YSJCompanyCourse_FreeDetailVC
                alloc]init];
        NSLog(@"%@",model.course_id);
        vc.M = model;
        vc.courseID = model.course_id;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model.type isEqualToString:@"一对一课程"]) {
        
        YSJTeacherCourse_OneByOneVC
        *vc = [[YSJTeacherCourse_OneByOneVC
                alloc]init];
        vc.courseID = model.course_id;
        vc.M = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model.type isEqualToString:@"拼单课程"]) {
        
        YSJSpellListDetailVC
        *vc = [[YSJSpellListDetailVC
                alloc]init];
        vc.courseID = model.course_id;
        vc.M = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else{
        
        YSJCompanyCourseVC *vc = [[YSJCompanyCourseVC alloc]init];
        vc.courseID = model.course_id;
        vc.M = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSJCourseModel *model = self.dataArr[indexPath.row];
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
       
        completionHandler (YES);
        NSDictionary * dict = @{@"token":[StorageUtil getId],@"courseID":model.course_id};
        NSLog(@"%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:YCollection parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            NSLog(@"%@",responseObject);
            [self.dataArr removeObjectAtIndex:indexPath.row];
            
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
     
    }];
    deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = KMainColor;
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
    
}
    
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    //第二组可以左滑删除
//    return YES;
//}
//
//// 定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}
//
//// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//    }
//}
//
//// 修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return @"删除";
//
//}

#pragma mark - setter

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
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

