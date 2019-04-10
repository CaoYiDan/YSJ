//
//  HomeViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLeaseVC.h"
#import "SPLzsInviteFriendVC.h"
#import "SPKitExample.h"
#import "SPIfSendPriceAndgoodnessTipView.h"
//分享界面
#import "SPShareView.h"
#import "SPNewMyProfileVC.h"
#import "SPNoDataTipView.h"
#import "SPPopTipView.h"
#import "SPMySkillForMakeMonery.h"
#import "SPHomeSifingVC.h"
#import "SPLeaseSectionHeaderView.h"
#import "SPNewHomeNavView.h"
#import "SPLeaseModel.h"
#import "SPLeaseCell.h"
#import "SPMySkillForMakeMonery.h"
#import "NSString+getSize.h"
#import "SPLeaseHeaderView.h"
#import "SPLzsGetMoneyVC.h"
#import "SLCityListViewController.h"
@interface SPLeaseVC ()<UITableViewDelegate,UITableViewDataSource,SPHomeNavViewDelegate,SLCityListViewControllerDelegate,SPLeaseSectionHeaderViewDelegate,SPHomeSifingVCDelegate,SPLeaseCellDelegate>

@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic ,strong)NSMutableArray *listArray;

@property(nonatomic ,strong)SPLeaseHeaderView *header;

@property(nonatomic,strong)NSMutableArray *bannerArray;

@property(nonatomic,strong)NSMutableArray *hotArray;

@property(nonatomic,strong)UILabel *noDataLab;

@property(nonatomic,strong)SPNewHomeNavView *navView;

@property(nonatomic,strong)NSString *leaseType;

@property(nonatomic,strong)SPShareView *shareView;

@property(nonatomic,strong)SPNoDataTipView *noDataView;

@end

@implementation SPLeaseVC
{
    NSInteger _page;//请求数据的页数
    NSString *_refreshDate;//请求数据时传的时间参数
    NSDictionary *_urlDic;
    NSMutableDictionary *_siftingDic;
    NSInteger _selectedIndexRow;//记录一下 点击 去完善时 选择的cell的index
}

-(SPNoDataTipView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[SPNoDataTipView alloc]initWithFrame:CGRectMake(0, self.header.frameHeight+92, SCREEN_W, 300)];
        WeakSelf;
        _noDataView.block = ^(NSString *btnText) {
            [weakSelf clickNoDataViewWithBtnText:btnText];
        };
        [self.tableView addSubview:_noDataView];
    }
    return _noDataView;
}

#pragma  mark  点击没有数据View的Btn

-(void)clickNoDataViewWithBtnText:(NSString *)btnText{
    if ([btnText isEqualToString:@"完善个人资料"]) {
        SPNewMyProfileVC *vc = [[SPNewMyProfileVC alloc]init];
        vc.code = [StorageUtil getCode];
        vc.nickName = @"个人详细";
        [self.navigationController pushViewController:vc animated:YES
         ];
        return;
    }
    if ([btnText isEqualToString:@"上传照片"]) {
        SPNewMyProfileVC *vc = [[SPNewMyProfileVC alloc]init];
        vc.code = [StorageUtil getCode];
        vc.nickName = @"个人详细";
        [self.navigationController pushViewController:vc animated:YES
         ];
        return;
    }
    
    if ([btnText isEqualToString:@"去认证"]) {
        return;
    }
    
    if ([btnText isEqualToString:@"发布技能"]) {
        SPMySkillForMakeMonery *vc = [[SPMySkillForMakeMonery alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _siftingDic = @{}.mutableCopy;
    
    [_siftingDic setObject:[StorageUtil getCity] forKey:@"city"];
    
    self.leaseType = @"应邀广场";
    
    _urlDic = @{@"应邀广场":kUrlLeaseSquare,@"我的应邀":kUrlMyLease,@"我的成交":kUrlLeaseDane};
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.header;
    
    [self.view addSubview:self.navView];
    //请求轮播图
    [self getHomeBanner];
    
    //注册  结束完善信息之后，直接更改单子状态为 已接单
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(perfectFinshed)
                                                 name:NotificationPublishSkillFinshedForLeaseVC
                                               object:nil];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //获取未读消息
    [self getTotalUnreadCount];
}

//获取未读消息
-(void)getTotalUnreadCount{
    
    [self.navView setUReadCount:[[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService].countOfUnreadMessages];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed =NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据
//请求活动接口
-(void)getHomeBanner{
    
    //    SYSTEM_START：开机广告； FEED_HOME：动态首页广告； SELECTION_HOME：精选首页广告 ACTIVITY_SPECIAL
    [[HttpRequest sharedClient]httpRequestPOST:kUrlBanner parameters:@{@"positionName":@"ACTIVITY_SPECIAL"} progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        [self.header setActivityArr:responseObject[@"data"]];
        
        //请求动态列表数据
        [self getLeaseData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self getLeaseData];
    }];
}

#pragma  mark  获取应邀广场数据

-(void)getLeaseData{
    
    _page=1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@(_page) forKey:@"pageNum"];
    [dic setObject:@(15) forKey:@"pageSize"];
    [dic setObject:[SPCommon getLoncationDic][@"longitude"] forKey:@"sendx"];
    [dic setObject:[SPCommon getLoncationDic][@"latitude"] forKey:@"sendy"];
    
    if ([self.leaseType isEqualToString:@"应邀广场"]) {
        if (!isEmptyString(_siftingDic[@"gender"])) {
            [dic setObject:_siftingDic[@"gender"] forKey:@"gender"];
        }
        
        if (!isEmptyString(_siftingDic[@"age"])) {
            if ([_siftingDic[@"age"] isEqualToString:@"25以下"]) {
                [dic setObject:@(25) forKey:@"endAge"];
            }else if ([_siftingDic[@"age"] isEqualToString:@"25~35"]){
                [dic setObject:@(25) forKey:@"startAge"];
                [dic setObject:@(35) forKey:@"endAge"];
            }else if ([_siftingDic[@"age"] isEqualToString:@"35以上"]){
                [dic setObject:@(35) forKey:@"startAge"];
            }
        }
    }
   
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    if ([self.leaseType isEqualToString:@"应邀广场"]  && !isEmptyString(_siftingDic[@"city"])) {
        [dic setObject:_siftingDic[@"city"] forKey:@"cityName"];
    }
    
    [[HttpRequest sharedClient]httpRequestPOST:_urlDic[self.leaseType] parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"租约%@",responseObject);
        
        self.listArray = [SPLeaseModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        for (SPLeaseModel *leaseM in self.listArray) {
            
            NSString *content = [NSString stringWithFormat:@"需求技能：%@\n\n需求描述：%@",leaseM.propertyName,leaseM.content];
            leaseM.contentH = [content sizeWithFont:kFontNormal maxW: SCREEN_W-2*kMargin].height;
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        if (![self.leaseType isEqualToString:@"应邀广场"] && self.listArray.count==0) {
            self.noDataView.hidden = NO;
            
            self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 400, 0);
            
        }else{
            
            self.noDataView.hidden = YES;
            
            self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 70, 0);
        }
        
        self.tableView.mj_footer.hidden = !self.listArray.count||self.listArray.count<15;
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//加载更多
-(void)loadMore{
    _page ++;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@(_page) forKey:@"pageNum"];
    [dic setObject:@(15) forKey:@"pageSize"];
    [dic setObject:[SPCommon getLoncationDic][@"lon"] forKey:@"sendx"];
    [dic setObject:[SPCommon getLoncationDic][@"lat"] forKey:@"sendy"];
    
    if ([self.leaseType isEqualToString:@"应邀广场"]) {
        if (!isEmptyString(_siftingDic[@"gender"])) {
            [dic setObject:_siftingDic[@"gender"] forKey:@"gender"];
        }
        
        if (!isEmptyString(_siftingDic[@"age"])) {
            if ([_siftingDic[@"age"] isEqualToString:@"25以下"]) {
                [dic setObject:@(25) forKey:@"endAge"];
            }else if ([_siftingDic[@"age"] isEqualToString:@"25~35"]){
                [dic setObject:@(25) forKey:@"startAge"];
                [dic setObject:@(35) forKey:@"endAge"];
            }else if ([_siftingDic[@"age"] isEqualToString:@"35以上"]){
                [dic setObject:@(35) forKey:@"startAge"];
            }
        }
    }
    
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:_urlDic[self.leaseType] parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = @[].mutableCopy;
        arr = [SPLeaseModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        for (SPLeaseModel *leaseM in arr) {
            
            NSString *content = [NSString stringWithFormat:@"需求技能：%@\n\n需求描述：%@",leaseM.propertyName,leaseM.content];
            leaseM.contentH = [content sizeWithFont:kFontNormal maxW: SCREEN_W-2*kMargin].height;
        }
        [self.listArray addObjectsFromArray:arr];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
        
        self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 70, 0);
        
        if (arr.count==0) {
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPLeaseCell*cell = [SPLeaseCell cellWithTableView:tableView indexPath:indexPath];
    cell.indexRow = indexPath.row;
    cell.leaseType = self.leaseType;
    cell.leaseM = self.listArray[indexPath.row];
    
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPLeaseModel *leaseM = self.listArray[indexPath.row];
    return leaseM.contentH+70+65;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSLog(@"%@",self.leaseType);
    if ([self.leaseType isEqualToString:@"应邀广场"]) {
        return 82;
    }
    return 82-40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    SPLeaseSectionHeaderView *sectionView = [[SPLeaseSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 92)];
    sectionView.delegate = self;
    sectionView.clipsToBounds = YES;
    //sectionView.hidden = YES;
    [sectionView setSelected:self.leaseType];
    
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    SPNewHomeCellFrame *modelF = self.listArray[indexPath.row];
    //
    //    SPDynamicDetialVC*vc = [[SPDynamicDetialVC alloc]init];
    //    vc.model = modelF.status;
    //    //删除动态
    //    vc.dynamicDeleteBlock = ^(){
    //        [self.listArray removeObject:modelF];
    //        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //    };
    //    [self.navigationController pushViewController:vc animated:YES];
    //    SPProfileVC *vc = [[SPProfileVC alloc]init];
    //    vc.code = modelF.status.code;
    //    vc.titleName = modelF.status.nickName;
    //    //    SPExperienceForMakeMonery *vc = [[SPExperienceForMakeMonery alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - -----------------SPNewDynamicHeaderViewDelegate-----------------

-(SPNewHomeNavView *)navView{
    if (!_navView) {
        _navView = [[SPNewHomeNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SafeAreaTopHeight)];
        [_navView setTypeForLease];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.delegate = self;
    }
    return _navView;
}

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [UILabel labelWithFont:font(14) textColor:[UIColor lightGrayColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
        _noDataLab.frame = CGRectMake(SCREEN_W/2-50, 200+80, 100, 40);
        _noDataLab.text = @"暂无数据";
        [self.tableView addSubview:_noDataLab];
    }
    return _noDataLab;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

//轮播图数据源
-(NSMutableArray*)bannerArray{
    if (_bannerArray==nil) {
        _bannerArray=[NSMutableArray array];
    }
    return _bannerArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_W, SCREEN_H2-49-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HomeBaseColor;
        
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeBanner)];
        // footer
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        //        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

-(SPLeaseHeaderView *)header{
    if (!_header) {
        //WeakSelf;
        _header = [[SPLeaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,40+SCREEN_W/8*3+40+10)];
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
            //            [self showNearVC];
            break;
        case 2:
            
            [self chat];
            
            break;
            
        default:
            break;
    }
}

-(void)chat{
    
#pragma  mark  跳转到 沟通回话列表
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
            
            weakController.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);[weakController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
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

-(void)goToCityList{
    
    SLCityListViewController *cityListVC = [SLCityListViewController new];
    
    cityListVC.delegate = self;
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    
    [self presentViewController:nv animated:YES completion:nil];
}

#pragma  mark - -----------------sl_cityListSelectedCityDelegate-----------------

- (void)sl_cityListSelectedCity:(NSString *)selectedCity Id:(NSInteger)Id {
    
    [_navView setLeftItemText:selectedCity];
    //刷新数据
    [_siftingDic setObject:selectedCity forKey:@"city"];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma  mark - SPLeaseSectionHeaderViewDelegate

-(void)SPLeaseSectionHeaderViewSelectedString:(NSString *)btnString{
    if (![btnString isEqualToString:@"筛选"]) {
        if ([btnString isEqualToString:self.leaseType]) return;
        self.leaseType = btnString;
        [self getLeaseData];
        
    }else{
        //筛选
        SPHomeSifingVC *vc = [[SPHomeSifingVC alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma  mark - 结束完善信息之后，直接 弹出框 询问是否发送相关价格以及优势 已接单

-(void)perfectFinshed{
    
    SPLeaseModel *leaseM = self.listArray[_selectedIndexRow];
    
    [self getSkillMessageWithSkillCode:leaseM.code];
}

#pragma  mark  - 筛选代理

-(void)SPHomeSifingVCSifting:(NSMutableDictionary *)siftingDic{
    
    _siftingDic = siftingDic;
    
    [self getLeaseData];
}

#pragma  mark  - cell功能按钮点击 代理回传

-(void)SPLeaseCellSelectedIndex:(NSInteger)indexRow andType:(NSString *)type{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    if ([type isEqualToString:@"已接单"]) {
        Toast(@"已接单");
    }
    
    SPLeaseModel *leaseM = self.listArray[indexRow];
    
    if ([type isEqualToString:@"沟通"]) {
        YWPerson *person = [[YWPerson alloc]initWithPersonId:leaseM.userCode];
        [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
        return;
    }
    
    if ([type isEqualToString:@"应邀接单"]) {
        [self getLeaseOrderWithModel:leaseM andIndxRow:indexRow];
    }
    
    if ([type isEqualToString:@"邀请好友来接单"]||[type isEqualToString:@"分享"]) {
        [UIView animateWithDuration:0.4 animations:^{
            
            [self.view addSubview:self.shareView];
            
            self.shareView.shareImg = [UIImage imageNamed:@"app"];
            
            self.shareView.shareUrl =[NSString stringWithFormat: @"http://59.110.70.112:8080/web/date.html?id=%@",leaseM.leaseId];
            
            self.shareView.title = @"快来帮帮Ta吧";
            self.shareView.subTitle = [NSString stringWithFormat:@"Ta在小猪约发布了一个%@的需求..", leaseM.propertyName];
            self.shareView.hidden = NO;
            
            self.shareView.originY = 0;
            
        }];
        return;
    }
}

//点击了应邀接单
-(void)getLeaseOrderWithModel:(SPLeaseModel *)leaseM andIndxRow:(NSInteger)indexRow{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    [dic setObject:[NSString stringWithFormat:@"%@%@",leaseM.code,leaseM.propertyName] forKey:@"skillCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeQuery parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        if (!isEmptyString(responseObject[@"data"][@"price"])) {
            //能接单
            [self popCanGetLeaseViewWithModel:leaseM andIndxRow:indexRow];
        }else{//不能接单
            [self popCanNotGetLeaseViewWithModel:leaseM andIndxRow:indexRow];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark  不能接单

-(void)popCanNotGetLeaseViewWithModel:(SPLeaseModel *)leaseM andIndxRow:(NSInteger)indexRow{
    
    ////记录一下 点击 去完善时 选择的cell的index
    _selectedIndexRow = indexRow;
    
    SPPopTipView *popView = [[SPPopTipView alloc]initWithTitle:@"提示信息" content:@"服务资料不全，暂不能应聘，\n请完善服务资料后再去应聘" sureButtonText:@"去完善" frame:self.view.bounds complment:^(NSString *sureStr) {
        //去完善
        [self goToPerfectCode:leaseM.code skillName:leaseM.propertyName];
    }];
    [self.view addSubview:popView];
}

#pragma  mark  去完善

-(void)goToPerfectCode:(NSString *)code skillName:(NSString *)skillName{
    SPLzsGetMoneyVC *vc = [[SPLzsGetMoneyVC alloc]init];
    vc.formWhere = 1;
    vc.skillCode = code;
    vc.skill = skillName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark  可以应邀，弹出 确定要应邀吗

-(void)popCanGetLeaseViewWithModel:(SPLeaseModel *)leaseM andIndxRow:(NSInteger)indexRow{
    WeakSelf;
    _selectedIndexRow = indexRow;
    SPPopTipView *popView = [[SPPopTipView alloc]initWithTitle:@"应邀" content:[NSString stringWithFormat:@"确定要应邀%@吗",leaseM.propertyName] sureButtonText:@"应邀" frame:self.view.bounds complment:^(NSString *sureStr) {
        
        //获取提供方报价信息
        [self getSkillMessageWithSkillCode:leaseM.code];
    }];
    [self.view addSubview:popView];
}

#pragma  mark  获取提供方报价信息
-(void)getSkillMessageWithSkillCode:(NSString *)skillCode{
    //获取提供方报价信息
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    [dic setObject:skillCode forKey:@"skillCode"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeQuery parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        //获取价格 和优势信息
        //弹出 是否发送应邀价格和优势信息 提示框
        [self popIfSendMyPriceAndgoodnessTipViewWithPrice:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]] priceUnit:responseObject[@"data"][@"priceUnit"] goodness:responseObject[@"data"][@"serIntro"]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark  弹出 是否发送应邀价格和优势信息 提示框

-(void)popIfSendMyPriceAndgoodnessTipViewWithPrice:(NSString *)price priceUnit:(NSString *)unit goodness:(NSString *)goodness{
    
    SPIfSendPriceAndgoodnessTipView *popView = [[SPIfSendPriceAndgoodnessTipView alloc]initWithPrice:price priceUnit:unit goodnessText:goodness frame:self.view.bounds complment:^(BOOL beSure, NSString *price, NSString *goodness) {
        if (beSure) {
            [self beSureGetLeaseOrderWithPrice:price goodness:goodness];
        }
    }];
    [self.view addSubview:popView];
}

#pragma  mark  提交应邀

-(void)beSureGetLeaseOrderWithPrice:(NSString *)price goodness:(NSString *)goodness{
    
    SPLeaseModel *leaseM = self.listArray[_selectedIndexRow];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:leaseM.leaseId forKey:@"demandId"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlGetLease parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        Toast(@"应邀成功");
        
        //打招呼1
        [[SPKitExample sharedInstance]sendMessageWithPersonId:leaseM.code content:[NSString stringWithFormat:@"你好,我对你的订单很感兴趣.我的报价是%@",price]];
        
        //打招呼2
        [[SPKitExample sharedInstance]sendMessageWithPersonId:leaseM.code content:goodness];
        
        leaseM.orderFlag = YES;
        //刷新
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        _shareView.shareImg = [UIImage imageNamed:@"app"];
    }
    return _shareView;
}

@end


