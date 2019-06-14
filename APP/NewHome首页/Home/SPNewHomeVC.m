//
//  HomeViewController.m
//  SmallPig
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.

#import <CommonCrypto/CommonDigest.h>
#import <SMS_SDK/SMSSDK.h>

#import "SPNewHomeVC.h"
#import "SPSearchVC.h"
#import <NIMSDK/NIMSDK.h>
#import  <NIMKit.h>
#import "YSJIMMessageVC.h"
#import "YSJHomeTableViewCell.h"
#import "SPSkillListModel.h"
#import "UITabBar+SPTabbarBadge.h"
#import "SPLzsInviteFriendVC.h"
#import "SLLocationHelp.h"
#import "SPCategorySelectionVC.h"
#import "SPHomeCell.h"
#import "SPKitExample.h"
#import "SPBannerModel.h"
#import "SPHomeModel.h"
#import "SLCityListViewController.h"
#import "SPHomeSectionView.h"
#import "SPActivityWebVC.h"
#import "SPHomeDataManager.h"
#import "SPPhotosView.h"
#import "SPHomeSifingVC.h"
#import "SPDynamicDetialVC.h"
#import "SPAllCategoryVC.h"
#import "YSJTeacher_DetailVC.h"
#import "SPDynamicModel.h"
#import "SPNewHomeNavView.h"
#import "SPNewDynamicHeaderView.h"
#import "SPNewHomeCellFrame.h"
#import "SPAllCategoryLeftView.h"
#import "SPOneCategoryListVC.h"
#import "SPProfileVC.h"
#import "SPSortView.h"
#import "SPKitExample.h"
#import "SPBaseNavigationController.h"
//登录
#import "SPLzsSecondLoginVC.h"
#import "YSJCompany_DetailVC.h"
#import "YSJTeacherModel.h"
#import "YSJRequimentModel.h"
#import "YSJCompanysModel.h"
#import "YSJSearchTeacherOrStudentVC.h"

@interface SPNewHomeVC ()<UITableViewDelegate,UITableViewDataSource,SPNewDynamicHeaderViewDelegate,SPHomeNavViewDelegate,SPHomeSifingVCDelegate,SLCityListViewControllerDelegate>

@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic ,strong)NSMutableDictionary *listDic;

@property(nonatomic ,strong)SPHomeSectionView *sectionView;

@property(nonatomic ,strong)SPNewDynamicHeaderView *header;

@property(nonatomic,strong)NSMutableArray *bannerArray;

@property(nonatomic,strong)NSMutableArray *hotArray;

@property(nonatomic,strong)UILabel *noDataLab;

@property(nonatomic,strong)SPNewHomeNavView *navView;

@property(nonatomic,strong)SPSortView *sortView;

@end

@implementation SPNewHomeVC
{
    NSInteger _page;//请求数据的页数
    
    NSString *_refreshDate;//请求数据时传的时间参数
    
    NSMutableDictionary *_siftingDic;
    
    NSMutableArray *_sortArr;//这个数组决定了 “私教，机构，学生” 的展示顺序
    
    NSMutableDictionary *_sectionViewData;//头部sectionview的数据
    
    BOOL _canGetData;//是否能获取数据
    
    NSString *_locationCity;//定位的城市
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //[StorageUtil saveId:@""];
    
    _locationCity  = @"北京市";
    
    //渐变背景色
    [self.view.layer addSublayer:[UIColor setGradualChangingColor:self.view fromColor:@"FF8960" toColor:@"FF62A5"]];
    
    //这个数组决定了 “私教，机构，学生” 的展示顺序
    _sortArr = @[teachers,companys,requirements,].mutableCopy;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.header;
    
    [self.view addSubview:self.navView];
    
    _siftingDic = @{}.mutableCopy;
    
    _sectionViewData = @{teachers:@{@"title":@"私教推荐",@"subTitle":@"更多优秀的教师供您选择",@"cellType":@(0)},companys:@{@"title":@"机构推荐",@"subTitle":@"更多优秀的机构供您选择",@"cellType":@(1)},requirements:@{@"title":@"学生推荐",@"subTitle":@"更多学生推荐",@"cellType":@(2)}}.mutableCopy;
    
    //刷新
    [self.tableView.mj_header beginRefreshing];
    
    //注册 ，当发布完成之后，返回 刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(reloadTableView)
         name:NotificationPublishFinish
       object:nil];

    //注册发布成功 跳转到首页
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(jumpToHome)
         name:NotificationJumpToHome
       object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (isEmptyString([StorageUtil getId]))
    {
        //        SPLzsSecondLoginVC * vc = [[SPLzsSecondLoginVC alloc]init];
        //        SPBaseNavigationController *lonNav = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
        //        [self presentViewController:lonNav animated:NO completion:nil];
        //        kUrlHot
    }else
    {
        //获取未读IM消息
        //        [self getTotalUnreadCountForIM];
        //获取未读推送消息
        //        [self getUReadCountForPush];
    }
    
//
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"firstStatus"]boolValue]) {
        
        UIImageView * imageIV = [[UIImageView alloc]initWithFrame:self.view.bounds];
        imageIV.image = [UIImage imageNamed:@"弹出框"];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        imageIV.userInteractionEnabled = YES;
        [imageIV addGestureRecognizer:tap];
        [self.view addSubview:imageIV];
        
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        
        [[NSUserDefaults standardUserDefaults]setObject:@0 forKey:@"firstStatus"];
        
    }
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed =NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getUReadCountForPush{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"code"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlMine parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSNumber *uReadCount = responseObject[@"data"][@"newMessageNum"];
        if ([uReadCount integerValue]!=0)
        {
            [self.tabBarController.tabBar showBadgeOnItemIndex:4];
        }else
        {
            [self.tabBarController.tabBar hideBadgeOnItemIndex:4];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
}

//获取未读消息
-(void)getTotalUnreadCountForIM
{
    
    [self.navView setUReadCount:[[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService].countOfUnreadMessages];
}

#pragma mark - tapImage
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
    self.tabBarController.tabBar.userInteractionEnabled = YES;
}

-(void)jumpToHome
{
    self.tabBarController.selectedIndex=0;
}


#pragma mark - 获取地理位置

-(void)getLocation
{
    __weak typeof(self) weakSelf = self;
    [[SLLocationHelp sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark)
     {
         if (placemark.locality && isEmptyString(_siftingDic[@"city"]))
         {
             NSLog(@"%@",placemark.locality);
             _locationCity = placemark.locality;
             
             [weakSelf.navView setLeftItemText:_locationCity];
             //开始数据请求
             [self startAllRequest];
         } else
         {
             //开始数据请求
             [self startAllRequest];
         }
         
     } status:^(CLAuthorizationStatus status) {
         
     } didFailWithError:^(NSError *error) {
         //开始数据请求
         [self startAllRequest];
     }];
}


#pragma mark - 开始进行请求数据
- (void)startAllRequest{
    
    dispatch_group_t group = dispatch_group_create();
    
    // banner数组
    dispatch_group_enter(group);
    [self getBannerRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //私教推荐
    dispatch_group_enter(group);
    [self getTeacherRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //学生推荐
    dispatch_group_enter(group);
    [self getStudentRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    //机构推荐
    dispatch_group_enter(group);
    [self getCompanysRequestisScu:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    WeakSelf;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [weakSelf.tableView reloadData];
        
    });
}

#pragma mark - 获取banner数据
- (void)getBannerRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestGET:YHomeSlider parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        _bannerArray = responseObject;
        NSMutableArray *_arr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in responseObject) {
            [_arr addObject:dic[@"picture"]];
        }
        
        self.header.bannerImgArr = _arr;
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

#pragma mark  获取机构信息

-(void)getCompanysRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestPOST:YHomefindCompanys parameters:[self getPostDic] progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        if (!isNull(responseObject[@"companys"])) {
             [self.listDic setObject:[YSJCompanysModel mj_objectArrayWithKeyValuesArray:responseObject[@"companys"]] forKey:@"companys"];
        }
    
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
    }];
}

#pragma mark 获取学生信息
-(void)getStudentRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestPOST:YHomeDemands parameters:[self getPostDic] progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        if (!isNull(responseObject[@"user_courses"])) {
        [self.listDic setObject:[YSJRequimentModel mj_objectArrayWithKeyValuesArray:responseObject[@"user_courses"]] forKey:requirements];
         }
        requestisScu(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
    }];
}

#pragma mark 私教信息

-(void)getTeacherRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestPOST:YHomeTeachercourses parameters:[self getPostDic] progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        _canGetData = YES;
        
        if (!isNull(responseObject[teachers])) {
             [self.listDic setObject:[YSJTeacherModel mj_objectArrayWithKeyValuesArray:responseObject[teachers]] forKey:teachers];
        }
       
        requestisScu(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(YES);
    }];
    
}

//获取请求数据的body
-(NSMutableDictionary *)getPostDic{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [dic setObject:_locationCity forKey:@"city"];
    
    return dic;
}

//加载更多
-(void)loadMore{
    _page ++;
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *cellType = _sectionViewData[_sortArr[indexPath.section]][@"cellType"];
    
    YSJHomeTableViewCell*cell = [YSJHomeTableViewCell cellWithTableView:tableView indexPath:indexPath andCellType:[cellType integerValue]];
    
    cell.listArr = self.listDic[_sortArr[indexPath.section]];
    //    cell.listArr = self.listDic[_sortArr[indexPath.section]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *cellType = _sectionViewData[_sortArr[indexPath.section]][@"cellType"];
    if ([cellType integerValue]!=HomeCellCompany) {
        return SCREEN_W/3+60;
    }else{
        return  SCREEN_W/3+90;
    }
}
#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderAtSection:section];
}
// title
-(UIView *)sectionHeaderAtSection:(NSInteger)section{
    
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 82)];
    base.backgroundColor = [UIColor whiteColor];
    
    //设置左上角和右上角 为圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:base.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = base.bounds;
    maskLayer.path = maskPath.CGPath;
    base.layer.mask = maskLayer;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 20, 100, 30)];
    title.text = _sectionViewData[_sortArr[section]][@"title"];
    title.font = BoldFont(18);
    [base addSubview:title];
    
    UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 40, 300, 30)];
    
    subTitle.text = _sectionViewData[_sortArr[section]][@"subTitle"];
    subTitle.font = font(13);
    subTitle.textColor = gray999999;
    [base addSubview:subTitle];
    
    UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-20-2*kMargin, 32, 8, 18)];
    [more setImage:[UIImage imageNamed:@"Shapear"]];
    [base addSubview:more];
    
    //添加点击事件
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 80)];
    btn.tag =  _sectionViewData[_sortArr[section]][@"cellType"];
    [btn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag= section;
    [base addSubview:btn];
    return base;
}

#pragma  mark  更多

-(void)more:(UIButton *)btn{
    
    YSJSearchTeacherOrStudentVC *vc = [[YSJSearchTeacherOrStudentVC alloc]init];
    vc.cellType = btn.tag;
    vc.city = _locationCity;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 20)];
    base.backgroundColor = [UIColor clearColor];
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 8)];
    footer.backgroundColor = [UIColor whiteColor];
    [base addSubview:footer];
    //设置左上角和右上角 为圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:footer.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = base.bounds;
    maskLayer.path = maskPath.CGPath;
    footer.layer.mask = maskLayer;
    return base;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    YSJTeacherModel *model  = self.listArr[indexPath.row];
    
    YSJTeacher_DetailVC *vc = [[YSJTeacher_DetailVC alloc]init];
    
    vc.teacherID = @"ds";
    
    [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
}


-(void)pushTosiftingVC
{
    
    SPHomeSifingVC *vc = [[SPHomeSifingVC alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addSortView
{
    [self.view addSubview:self.sortView];
    
    //调用重新刷新，为了选中之前的选项。待优化，这样处理不好
    [self.sortView reloadTableView];
    self.sortView.frame= CGRectMake(0, -SCREEN_H2, SCREEN_W, SCREEN_H2);
    [UIView animateWithDuration:0.3 animations:^{
        self.sortView.originY= 0;
    }];
}

//排序view
-(SPSortView *)sortView
{
    WeakSelf;
    if (!_sortView)
    {
        _sortView = [[SPSortView alloc]initWithFrame:self.view.bounds];
        _sortView.block = ^(NSString *sortStr)
        {
            NSLog(@"%@",sortStr);
            [weakSelf addObject:sortStr];
        };
    }
    return _sortView;
    
}

-(void)addObject:(NSString *)sortValue
{
    
    [_siftingDic setObject:sortValue forKey:@"searchType"];
    //    [self.tableView.mj_header beginRefreshing];
    
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat sclae =  scrollView.contentOffset.y/250;
//    //设置导航栏的透明度
//    _navView.backgroundColor = RGBA(244, 44, 135, sclae);
//
//}

#pragma  mark - header点击代理事件

-(void)SPNewDynamicHeaderViewDidSelectedType:(NSString *)type index:(NSInteger)index{
    
    if ([type isEqualToString:@"bannerClick"]) {
        NSDictionary *dic =  self.bannerArray[index];
        
        if (isEmptyString(dic[@"url"])) return;
        
        SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
        
        vc.url = dic[@"url"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"category"]){
        YSJSearchTeacherOrStudentVC *vc = [[YSJSearchTeacherOrStudentVC alloc]init];
        vc.cellType = index;
        vc.city = _locationCity;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //全部分类列表
       
    }
    
}

#pragma  mark - setter

-(NSMutableArray *)hotArray{
    
    if (!_hotArray) {
        _hotArray = [[NSMutableArray alloc]init];
    }
    return _hotArray;
}

-(SPNewHomeNavView *)navView{
    if (!_navView) {
        _navView = [[SPNewHomeNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SafeAreaTopHeight)];
        _navView.backgroundColor = [UIColor clearColor];
        _navView.delegate = self;
        
    }
    return _navView;
}

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [UILabel labelWithFont:font(14) textColor:[UIColor lightGrayColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
        _noDataLab.frame = CGRectMake(SCREEN_W/2-50, _header.frameHeight+80, 100, 40);
        _noDataLab.text = @"暂无数据";
        //        _noDataLab.center = self.tableView.center;
        [self.tableView addSubview:_noDataLab];
        
    }
    return _noDataLab;
}

- (NSMutableDictionary *)listDic
{
    if (_listDic == nil) {
        _listDic = [NSMutableDictionary dictionary];
    }
    return _listDic;
}

//轮播图数据源
-(NSMutableArray*)bannerArray{
    if (_bannerArray==nil) {
        _bannerArray=[NSMutableArray array];
        
    }
    return _bannerArray;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(kMargin,SafeAreaTopHeight, SCREEN_W-2*kMargin, SCREEN_H2-49-SafeAreaTopHeight-KBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //        _tableView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, 0, 0);
        //    _tableView.rowHeight = SCREEN_W/3+90;
        _tableView.separatorColor = [UIColor whiteColor];
        [_tableView registerClass:[SPHomeCell class] forCellReuseIdentifier:SPHomeCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getLocation)];
        
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        //        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

-(SPNewDynamicHeaderView *)header{
    
    if (!_header) {
        
        _header = [[SPNewDynamicHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,bannerHeight+categotyH+activityH+3*kMargin)];
        _header.backgroundColor = [UIColor clearColor];
        _header.delegate = self;
    }
    return _header;
}

#pragma  mark -action

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}

#pragma  mark - -----------------homeNavViewDelegate-----------------

-(void)homeNavViewSelectedIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [self goToCityList];
            break;
        case 1:
            //搜索
            [self search];
            break;
        case 2:
            //            跳转到 沟通回话列表
            //            [SPCommon gotoChatVCWithVC:self];
            [self chat];
            break;
            
        default:
            break;
    }
}

-(void)chat{
    
#pragma  mark  跳转到 沟通会话列表
    YWConversationListViewController *conversationListController = [[SPKitExample sharedInstance].ywIMKit makeConversationListViewController];
    conversationListController.view.backgroundColor = BASEGRAYCOLOR;
    [[SPKitExample sharedInstance] exampleCustomizeConversationCellWithConversationListController:conversationListController];
    conversationListController.viewForNoData = [SPCommon noDataLabelWithText:@"账号已在其他设备登录" frame:CGRectMake(100, 100, 100, 40)];
    __weak __typeof(conversationListController) weakConversationListController = conversationListController;
    
    conversationListController.didSelectItemBlock = ^(YWConversation *aConversation) {
        if ([aConversation isKindOfClass:[YWCustomConversation class]]) {
            YWCustomConversation *customConversation = (YWCustomConversation *)aConversation;
            [customConversation markConversationAsRead];
            
            if ([customConversation.conversationId isEqualToString:SPTribeSystemConversationID]) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tribe" bundle:nil];
                UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SPTribeSystemConversationViewController"];
                [weakConversationListController.navigationController pushViewController:controller animated:YES];
            }
            else if ([customConversation.conversationId isEqualToString:kSPCustomConversationIdForFAQ]) {
                
            }
            else {
                
            }
        }
        else {
            [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithConversation:aConversation
                                                                        fromNavigationController:weakConversationListController.navigationController];
        }
    };
    
    conversationListController.didDeleteItemBlock = ^ (YWConversation *aConversation) {
        if ([aConversation.conversationId isEqualToString:SPTribeSystemConversationID]) {
            [[[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService] removeConversationByConversationId:[SPKitExample sharedInstance].tribeSystemConversation.conversationId error:NULL];
        }
    };
    
    {
        __weak typeof(conversationListController) weakController = conversationListController;
        
        [conversationListController setViewWillAppearBlock:^(BOOL aAnimated) {
            
            NSInteger count = self.navigationController.viewControllers.count;
            self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            
            weakController.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
            [weakController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
            [weakController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
            lab.text = @"沟通";
            lab.textAlignment = NSTextAlignmentCenter;
            weakController.navigationItem.titleView = lab;
            weakController.navigationController.navigationBar.translucent = NO;
            weakController.extendedLayoutIncludesOpaqueBars = NO;
            [weakController.navigationController setNavigationBarHidden:NO animated:YES]; weakController.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            
            
            UIButton *rightButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"邀请好友" titleColor:[UIColor blackColor] imageName:@"" backgroundImageName:nil target:nil selector:nil];
            
            
            [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchDown];
            rightButton.titleLabel.font = font(14);
            rightButton.titleLabel.adjustsFontSizeToFitWidth=YES;
            weakController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        }];
        
        [conversationListController setViewWillDisappearBlock:^(BOOL aAnimated) {
            [weakController.navigationController setNavigationBarHidden:NO ];
            
        }];
        
        [conversationListController setViewDidLoadBlock:^{
            
            [weakController.navigationController setNavigationBarHidden:YES animated:YES];
            
            if ([weakController respondsToSelector:@selector(traitCollection)]) {
                UITraitCollection *traitCollection = weakController.traitCollection;
                if ( [traitCollection respondsToSelector:@selector(forceTouchCapability)] ) {
                    if (traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                        [weakController registerForPreviewingWithDelegate:weakController sourceView:weakController.tableView];
                    }
                }
            }
        }];
    }
    
    [self.navigationController pushViewController:conversationListController animated:YES];
}

#pragma  mark  邀请好友

-(void)rightClick{
    
    SPLzsInviteFriendVC *vc = [[SPLzsInviteFriendVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)search{
    SPSearchVC *searchVC = [[SPSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)goToCityList{
    
    SLCityListViewController *cityListVC = [SLCityListViewController new];
    
    cityListVC.delegate = self;
    
    SPBaseNavigationController *nv = [[SPBaseNavigationController alloc] initWithRootViewController:cityListVC];
    
    [self presentViewController:nv animated:YES completion:nil];
    
}

#pragma  mark - -----------------sl_cityListSelectedCityDelegate-----------------

- (void)sl_cityListSelectedCity:(NSString *)selectedCity Id:(NSInteger)Id {
    
    [_navView setLeftItemText:selectedCity];
    
    [_siftingDic setObject:selectedCity forKey:@"city"];
    
    _locationCity = selectedCity;
    
    //刷新数据
    [self.tableView.mj_header beginRefreshing];
}

#pragma  mark - -----------------筛选代理-----------------

-(void)SPHomeSifingVCSifting:(NSMutableDictionary *)siftingDic
{
    _siftingDic = siftingDic;
}

#pragma mark - TableView 占位图
-(UIView *)xy_noDataView{
    return nil;
}
- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"note_list_no_data"];
}

- (NSString *)xy_noDataViewMessage {
    return @"";
}

- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
}

@end

