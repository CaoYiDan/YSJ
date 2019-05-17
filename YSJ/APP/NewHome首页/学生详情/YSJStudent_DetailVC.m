
#import "YSJStudent_DetailVC.h"
#import "YSJTeacherCourseCell.h"
#import "YSJTeacherPinDanCell.h"
#import "YSJMulticourseModel.h"
#import "YSJCompanyCourseVC.h"
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
#import "YSJStudent_DetailHeaderView.h"
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
#import "YSJRequimentModel.h"
#import "XHStarRateView.h"

@interface YSJStudent_DetailVC ()<UITableViewDelegate,UITableViewDataSource,SPSkillSectionHeaderViewDelegate,SDPhotoBrowserDelegate,NavDelegate>
@property (nonatomic,strong) YSJCompanyNavView *navView;
@property(nonatomic,strong)YSJRequimentModel *M;
@property(nonatomic ,strong)UITableView *tableView;
//私教课程数组
@property(nonatomic ,strong)NSMutableArray *courseArr;
//拼单课程数组
@property(nonatomic ,strong)NSMutableArray *multiCourseArr;
//评价数组
@property(nonatomic ,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)YSJStudent_DetailHeaderView *header;

@end

@implementation YSJStudent_DetailVC
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //    _sortArr = @[@"feaatures",@"",@"",@"",@"",@"",@"",@""];
    self.M = self.model;
    
    self.view.backgroundColor = KWhiteColor;
    
    [self.view addSubview:self.tableView];
    
    [self setBottomView];
    
    [self getBannerBaseRequestisScu:^(BOOL isScu) {
        
    }];
    //    [self startAllRequest];
    [self setModela];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)setModela{
    
    self.header.model = self.model;
    
    [self.view addSubview:self.navView];
}

#pragma mark - 开始进行请求数据
- (void)startAllRequest{
    
}


#pragma mark 获取轮播图基本信息

-(void)getBannerBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherBanner,self.studentID] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        _bannerArr = @[].mutableCopy;
        
        for (NSString *str in responseObject[@"pic_url"]) {
            [_bannerArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,str]];
        }
        _header.bannerImgArr = _bannerArr;
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
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
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section==0) {
        cell = [UITableViewCell loadCode:tableView];
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = font(13);
        cell.textLabel.textColor = gray999999;
        if (indexPath.section==0) {
            cell.textLabel.text = self.M.describe;
        }else  if (indexPath.section==1) {
            
        }else if(indexPath.section==3) {
            cell.textLabel.text = self.M.course_time;
        }else if(indexPath.section==4) {
            cell.textLabel.text = self.M.describe;
        }else if(indexPath.section==4) {
            cell.textLabel.text = self.M.describe;
        }
        
    }else if(indexPath.section==1) {
        
        YSJAddressCell *cell = [YSJAddressCell loadCode:tableView];
        [cell setTitle:self.M.title address:self.M.address distance:[NSString stringWithFormat:@"%.1f",self.M.distance]];
        
        return cell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        CGSize size =[self.M.describe sizeWithFont:font(13) maxW:kWindowW-100];
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
    
    
    return 1;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *arr = @[@" 需求详情",@" 学生地址"];
    NSArray *imgArr = @[@"xuqiu2",@"xueshengdizhi"];
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 50)];
    base.backgroundColor = KWhiteColor;
    
    UIButton *title = [[UIButton alloc]init];
    title.titleLabel.font = font(18);
    [title setTitleColor:KBlackColor forState:0];
    [title setTitle:arr[section] forState:0];
    [title setImage:[UIImage imageNamed:imgArr[section]] forState:0];
    [base addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(40);
        make.top.equalTo(base).offset(10);
    }];
    
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
-(void)connect{
    
}

-(void)share{
    
}

-(void)care:(UIButton *)btn{
    //如果没有登录，就弹出登录界面
    //    if ([SPCommon gotoLogin]) return;
    
    NSDictionary * dict = @{@"token":[StorageUtil getId],@"teacherID":self.model.code};
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 60+KBottomHeight, 0);
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

-(YSJStudent_DetailHeaderView *)header
{
    if (!_header)
    {
        _header = [[YSJStudent_DetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,bannerHeight+profileHeight-15)];
        
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
    
    if (self.vcType==1) {
        return;
    }
    
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
//                _navView.care = self.M.is;
                _navView.title = self.M.title;
        _navView.delegate = self;
        
    }
    return _navView;
}


@end
