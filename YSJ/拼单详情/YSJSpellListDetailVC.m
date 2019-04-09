#import "CZHCountDownCell.h"
#import "CZHCountDownModel.h"
#import "YSJTeacherCourseDetailVC.h"
#import "YSJTeacherCourseCell.h"
#import "YSJTeacherPinDanCell.h"
#import "YSJMulticourseModel.h"
#import "YSJSpellListDetailVC.h"
#import "SPUser.h"
#import "YSJAddressCell.h"
#import "YSJCompanyNavView.h"
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
#import "YSJCompanyCourse_HeaderView.h"
#import "SPProfileCommentFrame.h"
#import "SPEvaluateForSkillListVC.h"
#import "YSJCourseModel.h"
#import "YSJCommentFrameModel.h"
#import "YSJCommentCell.h"
#import "YSJCommentsModel.h"
//model
#import "FFDifferentWidthTagModel.h"
#import "SPKitExample.h"
//cell
#import "FFDifferentWidthTagCell.h"

#import "XHStarRateView.h"

@interface YSJSpellListDetailVC ()<UITableViewDelegate,UITableViewDataSource,SPSkillSectionHeaderViewDelegate,SDPhotoBrowserDelegate,NavDelegate,CZHCountDownCellDelegate>
@property (nonatomic,strong) YSJCompanyNavView *navView;

@property(nonatomic ,strong)UITableView *tableView;
//私教课程数组
@property(nonatomic ,strong)NSMutableArray *courseArr;
//拼单课程数组
@property(nonatomic ,strong)NSMutableArray *multiCourseArr;
//评价数组
@property(nonatomic ,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)YSJCompanyCourse_HeaderView *header;
@property (nonatomic, strong) NSTimer *timer;
///<#注释#>
@property (nonatomic, strong) NSMutableArray *timeArrays;
@end

@implementation YSJSpellListDetailVC
{
    //评价标签模型
    FFDifferentWidthTagModel *_commentModel;
    
    NSArray *_sortArr;
    NSArray *_section0Arr;
    NSArray *_section2Arr;
    NSInteger _selectedIndex;
    UIView *_photosView;
    
    
    NSMutableArray *_bannerArr;
    //综合评分
    UILabel *_scoreLabel;
    
    XHStarRateView *_starRateView;
}

#pragma mark - 生命周期
- (NSMutableArray *)timeArrays {
    if (!_timeArrays) {
        _timeArrays = [NSMutableArray array];
        for (NSInteger i = 0; i < 2; i++) {
            CZHCountDownModel *timeModel = [[CZHCountDownModel alloc] init];
            [_timeArrays addObject:timeModel];
        }
    }
    return _timeArrays;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    
    [self.view addSubview:self.tableView];
    
    [self setBottomView];
    
    [self setUpTimer];
    
    self.header.model = self.M;
    
    [self.view addSubview:self.navView];
    
    [self startAllRequest];
    
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        
        //设置navigationView
        [self.view addSubview:self.navView];
        
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
    
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherPingJia,self.courseID] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"lable"];
        
        _commentModel = [FFDifferentWidthTagModel new];
        
        _commentModel.reputation = [responseObject[@"reputation"] doubleValue];
        
        NSMutableArray *tagsArrM = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++){
            
            [tagsArrM addObject:[NSString stringWithFormat:@"%@ %@",arr[j][@"lable"],arr[j][@"count"]]];
        }
        
        _commentModel.tagsArrM = tagsArrM;
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
    }];
}

#pragma mark - 获取私教信息

-(void)getTeacherBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [dic setObject:self.courseID forKey:@"courseID"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherbaseinfo parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(NO);
        
    }];
    
}

#pragma mark 获取轮播图基本信息

-(void)getBannerBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherBanner,self.courseID] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        //        _bannerArr = @[].mutableCopy;
        //
        //        for (NSString *str in responseObject[@"pic_url"]) {
        //            [_bannerArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,str]];
        //        }
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
    }];
    
}

#pragma mark 私教授课内容

-(void)getCourseinfoRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    
    [dic setObject:self.courseID forKey:@"courseID"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [[HttpRequest sharedClient]httpRequestPOST:YHomecourseaddress parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        self.M = [YSJCourseModel mj_objectWithKeyValues:responseObject];
        _bannerArr = @[].mutableCopy;
        
        for (NSString *str in self.M.course_display) {
            [_bannerArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,str]];
        }
        self.header.bannerImgArr = _bannerArr;
        
        self.header.model = self.M;
        
        requestisScu(YES);
        
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
         return self.timeArrays.count;
    }else if (section==2){
       
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section!=6 && indexPath.section!=1) {
        cell = [UITableViewCell loadCode:tableView];
    }else if(indexPath.section==1) {
        
        CZHCountDownCell *cell = [CZHCountDownCell loadCode:tableView];
        cell.delegate = self;
        //    cell.timeModel = self.timeArrays[indexPath.row];
        [cell setCellWithTimeModel:self.timeArrays[indexPath.row] indexPath:indexPath];
        return cell;
        
    }else if(indexPath.section==2){
       
    }else{
        
        FFDifferentWidthTagCell *cell = [FFDifferentWidthTagCell loadCode:tableView];
        cell.tagModel = _commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = font(13);
    cell.textLabel.textColor = gray999999;
    if (indexPath.section==0) {
        cell.textLabel.text = self.M.feaatures;
    }else  if (indexPath.section==1) {
        
    }else if(indexPath.section==3) {
        cell.textLabel.text = self.M.course_time;
    }else if(indexPath.section==4) {
        cell.textLabel.text = self.M.describe;
    }else if(indexPath.section==4) {
        cell.textLabel.text = self.M.describe;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        CGSize size =[self.M.feaatures sizeWithFont:font(13) maxW:kWindowW-100];
        return size.height+20;
    }else if (indexPath.section==1) {
        
        return 120;
    }else if (indexPath.section==4) {
        
        CGSize size =[self.M.describe sizeWithFont:font(13) maxW:kWindowW-100];
        return size.height;
    }else if(indexPath.section==6){
        return _commentModel.cellHeight;
    }
    
    return 45;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==2 || section==3 || section==4) {
        return 0.01;
    }
    return 6;
}
#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==6) {
        return 120;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *arr = @[@" 课程特色",@" 拼单详情",@" 课程详情",@" 上课时间",@" 课程介绍",@" 课时数",@" 用户评价"];
    NSArray *imgArr = @[@"kechengtese",@"pingdan",@"kechengxiangqing",@"",@"",@"",@"yonghupingjia"];
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 50)];
    base.backgroundColor = KWhiteColor;
    
    UIButton *title = [[UIButton alloc]init];
    if (section==5 || section==3 || section==4) {
        title.titleLabel.font = font(15);
        [title setTitleColor:KBlack333333 forState:0];
    }else{
        title.titleLabel.font = font(18);
        [title setTitleColor:KBlackColor forState:0];
    }
    
    [title setTitle:arr[section] forState:0];
    [title setImage:[UIImage imageNamed:imgArr[section]] forState:0];
    
    [base addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(40);
        make.top.equalTo(base).offset(10);
    }];
    
    //@"随时退",@"过期自动退"
    if (section==2) {
        NSArray *arr = @[@"过期自动退",@"随时退"];
        int i=0;
        for (NSString *str in arr) {
            UIButton *btn = [[UIButton alloc]init];
            [btn setTitle:str forState:0];
            [btn setImage:[UIImage imageNamed:@"未选择"] forState:0];
            [btn setTitleColor:gray999999 forState:0];
            btn.titleLabel.font= font(12);
            [base addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-kMargin-80*i);
                make.width.offset(80);
                make.height.offset(20);
                make.centerY.equalTo(title).offset(0);
                
            }];
            i++;
        }
    }
    
    //用户评价
    if (section==6) {
        
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
        UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-kMargin-10, 10+11, 8, 18)];
        [more setImage:[UIImage imageNamed:@"sijiao_more"]];
        [base addSubview:more];
        
        //添加点击事件
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 80)];
        btn.tag = section;
        [btn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag= section;
        [base addSubview:btn];
    }
    return base;
}
-(void)more{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        //        YSJTeacherCourseDetailVC *vc = [[YSJTeacherCourseDetailVC alloc]init];
        //        vc.code = @"fdf";
        //        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)navViewSelectedBtn:(UIButton *)btn{
    
    if (btn.tag==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag==1){
        
    }else{
        [self care:btn];
    }
}

#pragma  mark - --------- -action -----------------
//单独购买
-(void)singleBuy{
    
}
//发起拼单
-(void)beginSpell{
    
}

-(void)share{
    
}

-(void)care:(UIButton *)btn{
    //如果没有登录，就弹出登录界面
    //    if ([SPCommon gotoLogin]) return;
    
    NSDictionary * dict = @{@"token":[StorageUtil getId],@"teacherID":self.courseID};
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H-60-KBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor hexColor:@"F0F0F0"];
        _tableView.separatorColor =  [UIColor clearColor];
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

-(YSJCompanyCourse_HeaderView *)header
{
    if (!_header)
    {
        _header = [[YSJCompanyCourse_HeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,bannerHeight+profileHeight-15)];
        
    }
    return _header;
}

-(void)setNav{
    UIButton *shareButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"fenxiang" backgroundImageName:nil target:self selector:@selector(share)];
    UIButton *careButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:@"guanzhu_0" backgroundImageName:nil target:self selector:@selector(care:)];
    [careButton setImage:[UIImage imageNamed:@"guanzhu_1"] forState:UIControlStateSelected];
    //    careButton.selected = self.M.is_fan;
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:careButton],[[UIBarButtonItem alloc]initWithCustomView:shareButton]];
}

-(void)setBottomView{
    
    
    CGFloat btnW = (kWindowW-40-10)/2;
    
    //单独购买
    UIButton *singleBuyBtn = [[UIButton alloc]init];
    singleBuyBtn.backgroundColor = KWhiteColor;
    [singleBuyBtn setTitle:@"单独购买" forState:0];
    [singleBuyBtn setTitleColor:KMainColor forState:0];
    singleBuyBtn.layer.cornerRadius = 5;
    singleBuyBtn.clipsToBounds = YES;
    singleBuyBtn.layer.borderColor = KMainColor.CGColor;
    singleBuyBtn.layer.borderWidth = 1.0;
    [singleBuyBtn addTarget:self action:@selector(singleBuy) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:singleBuyBtn];
    [singleBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.width.offset(btnW);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-5);
    }];
    
 //发起拼单
    UIButton *beginSpellBtn = [[UIButton alloc]init];
    beginSpellBtn.backgroundColor = KMainColor;
    [beginSpellBtn setTitle:@"发起拼单" forState:0];
    beginSpellBtn.layer.cornerRadius = 5;
    beginSpellBtn.clipsToBounds = YES;
    [beginSpellBtn addTarget:self action:@selector(beginSpell) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:beginSpellBtn];
    [beginSpellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(singleBuyBtn.mas_right).offset(10);
        make.width.offset(btnW);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-5);
    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%.0f",scrollView.contentOffset.y);
    CGFloat sclae =  scrollView.contentOffset.y/(bannerHeight-SafeAreaTopHeight);
    //设置导航栏的透明度
    _navView.backgroundColor = RGBA(253, 135, 105, sclae);
    
    if (sclae >= 0.8) {
        _navView.tittleHiden = NO;
    }else {
        _navView.tittleHiden = YES;
    }
}

-(YSJCompanyNavView *)navView{
    if (!_navView) {
        _navView = [[YSJCompanyNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SafeAreaTopHeight)];
        _navView.backgroundColor = [UIColor clearColor];
        //        _navView.care = self.M.is_fan;
        //        _navView.title = self.M.realname;
        _navView.delegate = self;
        
    }
    return _navView;
}

#pragma mark -- 代理
- (void)cell:(CZHCountDownCell *)cell countDownDidFinishedWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath {
    
    CZHCountDownModel *arrayTimeModel = self.timeArrays[indexPath.row];
    
    arrayTimeModel.isFinished = timeModel.isFinished;
    
}

//计时器
- (void)setUpTimer {
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    for (CZHCountDownModel *timeModel in self.timeArrays) {
        
        if (timeModel.startTime - timeModel.currentTime <= 0) {
            continue;
        }
        
        [timeModel countDown];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CZHUpdateTimeNotification object:nil];
        
    }
    
}
@end
