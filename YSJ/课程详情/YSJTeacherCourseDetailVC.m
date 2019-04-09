
#import "YSJTeacherCourseCell.h"
#import "YSJTeacherPinDanCell.h"
#import "YSJMulticourseModel.h"
#import "SPProfileDetailVC.h"
#import "SPUser.h"
#import "SPAuthenticationView.h"
#import "SPTagCell.h"
#import "NSString+getSize.h"
#import "SPCommentModel.h"
#import "SPProfileCommentCell.h"
#import "SPSection2MoreTextCell.h"
#import "SPSection2Cell.h"
#import "SPSecton0Cell.h"
#import "SPKungFuModel.h"
#import "SPLucCommentModel.h"
#import "SPPublishModel.h"
#import "SDPhotoBrowser.h"
#import "SPSkillSectionHeaderView.h"
#import "YSJTeacherCourseDetailHeaderView.h"
#import "SPProfileCommentFrame.h"
#import "SPEvaluateForSkillListVC.h"
#import "YSJTeacherModel.h"
#import "YSJCommentFrameModel.h"
#import "YSJCommentCell.h"
#import "YSJCommentsModel.h"
#import "YSJTeacherCourseDetailVC.h"
@interface YSJTeacherCourseDetailVC ()<UITableViewDelegate,UITableViewDataSource,SPSkillSectionHeaderViewDelegate>
@property(nonatomic,strong)YSJTeacherModel *M;
@property(nonatomic ,strong)UITableView *tableView;
//私教课程数组
@property(nonatomic ,strong)NSMutableArray *courseArr;
//拼单课程数组
@property(nonatomic ,strong)NSMutableArray *multiCourseArr;
//评价数组
@property(nonatomic ,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)YSJTeacherCourseDetailHeaderView *header;

@end

@implementation YSJTeacherCourseDetailVC
{
    NSArray *_section0Arr;
    NSArray *_section2Arr;
    NSInteger _selectedIndex;
    UIView *_photosView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    
    [self setNav];
    
    [self.view addSubview:self.tableView];
    
    [self setBottomView];
    
    [self startAllRequest];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 开始进行请求数据
- (void)startAllRequest{
    
    dispatch_group_t group = dispatch_group_create();
    
    //评价
    dispatch_group_enter(group);
    [self getPingjiaRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //私教基本信息
    dispatch_group_enter(group);
    [self getTeacherBaseRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //课程信息
    dispatch_group_enter(group);
    [self getCourseinfoRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    
    WeakSelf;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf.tableView reloadData];
        
    });
}

#pragma mark - 获取评价
- (void)getPingjiaRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@?id=%@",YTeacherPingJia,self.code]);
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherPingJia,self.code] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        NSMutableArray *arr = [YSJCommentsModel mj_objectArrayWithKeyValuesArray:responseObject[@"teacher"][@"comments"]];
        
        self.commentArr = @[].mutableCopy;
        
        for (YSJCommentsModel *model in arr) {
            YSJCommentFrameModel *modelF = [[YSJCommentFrameModel alloc]init];
            modelF.status = model;
            [self.commentArr addObject:modelF];
        }
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(YES);
        
    }];
}

#pragma mark 获取私教基本信息

-(void)getTeacherBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:@{@"longitude":[StorageUtil getUserLon],@"latitude":[StorageUtil getUserLat]} forKey:@"locate"];
    [dic setObject:self.code forKey:@"teacherID"];
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherbaseinfo parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        self.M = [YSJTeacherModel mj_objectWithKeyValues:responseObject[@"teacher"]];
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

#pragma mark //私教授课内容
-(void)getCourseinfoRequestisScu:(void(^)(BOOL isScu))requestisScu{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    
    [dic setObject:self.code forKey:@"teacherID"];
    [[HttpRequest sharedClient]httpRequestPOST:YTeachercourseinfo parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        requestisScu(YES);
        
        self.multiCourseArr = [YSJMulticourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"multicourse"]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

//获取请求数据的body
-(NSMutableDictionary *)getPostDic{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:@{@"longitude":[StorageUtil getUserLon],@"latitude":[StorageUtil getUserLat]} forKey:@"locate"];
    return dic;
}


#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.courseArr.count;
    }else if (section==1){
        
        return self.commentArr.count;
    }else{
        
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        YSJTeacherCourseCell *cell = [YSJTeacherCourseCell loadCode:tableView];
        
        return cell;
        
    }else if(indexPath.section==1){
        YSJTeacherPinDanCell *cell = [YSJTeacherPinDanCell loadCode:tableView];
        //        cell.model = self.multiCourseArr[indexPath.row];
        return cell;
        /** 评价*/
    }else if (indexPath.section==2){
        
        YSJCommentCell *cell = [YSJCommentCell loadCode:tableView];
        cell.statusFrame = self.commentArr[indexPath.row];
        return cell;
    }
    
    return  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCellStyleValue1"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        YSJCommentFrameModel *modelF = self.commentArr[indexPath.row];
        return modelF.cellHeight;
    }
    
    return 142;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==2) {
        return 0.01;
    }
    return 6;
}
#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *arr = @[@"课程详情",@"用户评价"];
  
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 50)];
    base.backgroundColor = KWhiteColor;
    
    
    UIButton *title = [[UIButton alloc]init];
    title.titleLabel.font = font(18);
    [title setTitle:arr[section] forState:0];
//    [title setImage:[UIImage imageNamed:imgArr[section]] forState:0];
    [title setTitleColor:[UIColor blackColor] forState:0];
    [base addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(40);
        make.top.equalTo(base).offset(10);
    }];
    return base;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma  mark  - SPSkillSectionHeaderViewDelegate

-(void)SPSkillSectionHeaderViewDidSelectedIndex:(NSInteger)indexRow{
    _selectedIndex = indexRow;
    //    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:3];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

#pragma  mark - --------- -action -----------------

#pragma  mark  跳转到评价评价列表

-(void)commentClick
{
    
}



#pragma  mark - -----------------setter-----------------

- (NSMutableArray *)courseArr
{
    if (_courseArr == nil)
    {
        _courseArr = [NSMutableArray array];
    }
    return _courseArr;
}

- (NSMutableArray *)multiCourseArr
{
    if (_multiCourseArr == nil)
    {
        _multiCourseArr = [NSMutableArray array];
    }
    return _multiCourseArr;
}

-(UITableView *)tableView
{
    if (!_tableView )
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H-60-SafeAreaTopHeight-KBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor hexColor:@"F0F0F0"];
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
        [_tableView registerClass:[SPSecton0Cell class] forCellReuseIdentifier:SPSecton0CellID];
        [_tableView registerClass:[SPSection2Cell class] forCellReuseIdentifier:SPSection2CellID];
        [_tableView registerClass:[SPSection2MoreTextCell class] forCellReuseIdentifier:SPSection2MoreTextCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.tableHeaderView = self.header;
    }
    
    return _tableView;
}

-(YSJTeacherCourseDetailHeaderView *)header
{
    if (!_header)
    {
        _header = [[YSJTeacherCourseDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,banHeight+proHeight-15)];
    }
    return _header;
}

-(void)setNav{
    UIButton *shareButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"fenxiang" backgroundImageName:nil target:self selector:@selector(share)];
    UIButton *careButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"guanzhu_0" backgroundImageName:nil target:self selector:@selector(care)];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:careButton],[[UIBarButtonItem alloc]initWithCustomView:shareButton]];
}

-(void)share{
    
}

-(void)care{
    
}
-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"联系TA" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-5);
    }];
}
@end
