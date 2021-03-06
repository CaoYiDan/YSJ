

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
#import "SPProfileDetailHeaderView.h"
#import "SPProfileCommentFrame.h"
#import "SPEvaluateForSkillListVC.h"
#import "YSJTeacherModel.h"
#import "YSJCommentFrameModel.h"
#import "YSJCommentCell.h"
#import "YSJCommentsModel.h"
//model
#import "FFDifferentWidthTagModel.h"
#import "SPKitExample.h"
//cell
#import "FFDifferentWidthTagCell.h"

#import "XHStarRateView.h"

@interface SPProfileDetailVC ()<UITableViewDelegate,UITableViewDataSource,SPSkillSectionHeaderViewDelegate,SDPhotoBrowserDelegate>
@property(nonatomic,strong)YSJTeacherModel *M;
@property(nonatomic ,strong)UITableView *tableView;
//私教课程数组
@property(nonatomic ,strong)NSMutableArray *courseArr;
//拼单课程数组
@property(nonatomic ,strong)NSMutableArray *multiCourseArr;
//评价数组
@property(nonatomic ,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)SPProfileDetailHeaderView *header;

@end

@implementation SPProfileDetailVC
{
    NSArray *_section0Arr;
    NSArray *_section2Arr;
    NSInteger _selectedIndex;
    UIView *_photosView;
    
    FFDifferentWidthTagModel *_commentModel;
    
    NSMutableArray *_bannerArr;
    //综合评分
    UILabel *_scoreLabel;
    XHStarRateView *_starRateView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    
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
    
    WeakSelf;
    
    //评价
    dispatch_group_enter(group);
    [self getPingjiaRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //私教基本信息
    dispatch_group_enter(group);
    [self getTeacherBaseRequestisScu:^(BOOL isScu) {
        [self setNav];
        dispatch_group_leave(group);
    }];
    
    //轮播图信息
    dispatch_group_enter(group);
    [self getBannerBaseRequestisScu:^(BOOL isScu) {
        weakSelf.header.bannerImgArr = _bannerArr;
        dispatch_group_leave(group);
    }];
    
 
    //课程信息
    dispatch_group_enter(group);
    [self getCourseinfoRequestisScu:^(BOOL isScu) {
         dispatch_group_leave(group);
    }];
    

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf.tableView reloadData];
        
    });
}

#pragma mark - 获取评价
- (void)getPingjiaRequestisScu:(void(^)(BOOL isScu))requestisScu{

    NSLog(@"%@",[NSString stringWithFormat:@"%@?id=%@",YTeacherPingJia,self.code]);
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherPingJia,self.code] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"lable"];
       _commentModel = [FFDifferentWidthTagModel new];
        _commentModel.reputation = [responseObject[@"reputation"] doubleValue];
    
        NSMutableArray *tagsArrM = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++) {
           
            [tagsArrM addObject:[NSString stringWithFormat:@"%@ %@",arr[j][@"lable"],arr[j][@"count"]]];
        }
        _commentModel.tagsArrM = tagsArrM;
    
           requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(YES);
        
    }];
}
#pragma mark - 获取私教信息

-(void)getTeacherBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [dic setObject:self.code forKey:@"teacherID"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherbaseinfo parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
       
        self.M = [YSJTeacherModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        self.header.profileM = self.M;
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(NO);
        
    }];
    
}

#pragma mark 获取轮播图基本信息

-(void)getBannerBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
 
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherBanner,self.code] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        _bannerArr = @[].mutableCopy;
        
        for (NSString *str in responseObject[@"pic_url"]) {
            [_bannerArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,str]];
        }
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
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
    return 3;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
       return self.courseArr.count;
    }else if (section==1){
//       return self.multiCourseArr.count;
        return 2;
    }else{
        return 1;
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
//        if (indexPath.section==2)
    }else {
        
        FFDifferentWidthTagCell *cell = [FFDifferentWidthTagCell loadCode:tableView];
        cell.tagModel = _commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
//        YSJCommentCell *cell = [YSJCommentCell loadCode:tableView];
//        cell.statusFrame = self.commentArr[indexPath.row];
//        return cell;
    }

    return  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCellStyleValue1"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==2) {
//       YSJCommentFrameModel *modelF = self.commentArr[indexPath.row];
//        return modelF.cellHeight;
        
     
        return _commentModel.cellHeight;
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
    if (section==2) {
        return 120;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *arr = @[@" 私教课程",@" 拼单课程",@" 评价"];
    NSArray *imgArr = @[@"sijiaokecheng",@"pingdan",@"pingjia"];
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 50)];
    base.backgroundColor = KWhiteColor;
    
    
    UIButton *title = [[UIButton alloc]init];
    title.titleLabel.font = font(18);
    [title setTitle:arr[section] forState:0];
    [title setImage:[UIImage imageNamed:imgArr[section]] forState:0];
    [title setTitleColor:[UIColor blackColor] forState:0];
    [base addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(40);
        make.top.equalTo(base).offset(10);
    }];
    
    if (section==2) {
        
        UIView *baseScoreView = [[UIView alloc]initWithFrame:CGRectMake(kWindowW/2-75, 50, 150, 60)];
        baseScoreView.backgroundColor = KWhiteColor;
        [base addSubview:baseScoreView];
        
        UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 50)];
        score.text = [NSString stringWithFormat:@"%.1f",_commentModel.reputation];
        score.adjustsFontSizeToFitWidth = YES;
        _scoreLabel = score;
        score.font = font(20);
        score.textColor = [UIColor hexColor:@"ED4A47"];
        [baseScoreView addSubview:score];
        
        UILabel *zonghe= [[UILabel alloc]init];
        zonghe.font = font(15);
        zonghe.text = @"综合评分";
        zonghe.textColor = gray999999;
//        zonghe.textColor = KMainColor;
        [baseScoreView addSubview:zonghe];
        [zonghe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(score.mas_right).offset(10);
            make.right.offset(0);
            make.height.offset(30);
            make.top.offset(0);
        }];
        
        //评分
        XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(40, 30, 70, 20) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
        _starRateView = starRateView;
        starRateView.backgroundColor = KWhiteColor;
        
        [baseScoreView addSubview:starRateView];
        [starRateView setStarLeave:_commentModel.reputation];
        
    }
    return base;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
//        YSJTeacherCourseDetailVC *vc = [[YSJTeacherCourseDetailVC alloc]init];
//        vc.code = @"fdf";
//        [self.navigationController pushViewController:vc animated:YES];
    }
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H-60-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor hexColor:@"F0F0F0"];
        _tableView.separatorColor = grayF2F2F2;
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

-(SPProfileDetailHeaderView *)header
{
    if (!_header)
    {
        _header = [[SPProfileDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,bannerHeight+profileHeight)];

    }
    return _header;
}

-(void)setNav{
  UIButton *shareButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"fenxiang" backgroundImageName:nil target:self selector:@selector(share)];
    UIButton *careButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"guanzhu_0" backgroundImageName:nil target:self selector:@selector(care:)];
    [careButton setImage:[UIImage imageNamed:@"guanzhu_1"] forState:UIControlStateSelected];
    careButton.selected = self.M.is_fan;
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:careButton],[[UIBarButtonItem alloc]initWithCustomView:shareButton]];
}

-(void)share{
    
}

-(void)care:(UIButton *)btn{
    //如果没有登录，就弹出登录界面
//    if ([SPCommon gotoLogin]) return;
 
    NSDictionary * dict = @{@"token":[StorageUtil getId],@"teacherID":self.code};
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:YCare parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        btn.selected = !btn.isSelected;
        if (btn.isSelected) {
            Toast(@"关注成功");
        }else{
             Toast(@"取消关注");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}
-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"联系TA" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-5);
    }];
}

-(void)connect{
    
//    if ([SPCommon gotoLogin]) return;
    
//    YWPerson *person = [[YWPerson alloc]initWithPersonId:self.code];
//    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
}


@end
