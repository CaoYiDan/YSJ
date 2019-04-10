//
//  SPHomeViewController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBaseDiscover.h"
#import "SPNewDynamicVC.h"

#import "AppDelegate.h"
#import "WXApi.h"
#import "WeiboSDK.h"

#import "SPHomeLefeItem.h"
#import "SPMyButtton.h"
#import "SPPublishVC.h"
#import "SPTipView.h"
#import "SLLocationHelp.h"
#import "SPHomeSwitchHeaderView.h"
#import "SLCityListViewController.h"
#import "SPNearSifingVC.h"
#import "SPProfileVC.h"
//定位服务
#import <CoreLocation/CoreLocation.h>
//test
#import "SPNearVC.h"
#import "SPKitExample.h"
//邀请好友
#import "SPLzsInviteFriendVC.h"

static CGFloat menuDownOriganY = 64;

typedef NS_ENUM(NSUInteger, RightItemType) {
    RightItemTypeForSifting = 11,
    RightItemTypeForPublish
};

@interface SPBaseDiscover ()<CLLocationManagerDelegate,SLCityListViewControllerDelegate,UIGestureRecognizerDelegate,SPHomeSwitchHeaderViewDelegate,SPNewDynamicReloadDelegate>{
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    NSArray *list;
}

@property(nonatomic,weak)SPNewDynamicVC *dynamicVC;
@property(nonatomic,weak)SPNearVC *nearVC;
@property (nonatomic, strong) UIButton *publishCell;
@property (nonatomic, strong) SPTipView  *tipView;
@property (nonatomic, strong) UIButton *rightBtnItem;
@property (nonatomic, strong)SPHomeSwitchHeaderView *headerSwitchView;
@property (nonatomic, strong) WBMessageObject *messageObject;

@end

@implementation SPBaseDiscover

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self sNavigation];
    
    [self showDynamicVC];
    
    [self getLocation];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"loginStatus"];
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"forHome"];
    //有点不可控，不设置naivgation的样式是这样，会有BUG,原因不明
    [self navigationSet];
    
    //如果下拉菜单展开，则收起
    [self hiddenMenuDownView];
    
    //获取未读消息
    [self getTotalUnreadCount];
}

//获取未读消息
-(void)getTotalUnreadCount{
    
    [self.headerSwitchView setUReadCount:[[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService].countOfUnreadMessages];
}

-(void)shareWXWithType:(int)type{
    
    WXMediaMessage *message = [WXMediaMessage  message];
    message.title = @"我在小猪约等你来 ！！";
    message.description = @"感受不一样的社交体验";
    [message setThumbImage:[UIImage imageNamed:@"logo_placeholder"]];
    
    WXWebpageObject *web = [WXWebpageObject object];
    web.webpageUrl = @"http://img2.imgtn.bdimg.com/it/u=155862420,535893506&fm=11&gp=0.jpg";
    message.mediaObject =web;
    
    SendMessageToWXReq *req  =[[SendMessageToWXReq alloc]init];
    req.bText =NO;
    req.message = message;
    req.scene = type;
    [WXApi sendReq:req];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma  mark - -----------------setter-----------------

-(void)getLocation{
    __weak typeof(self) weakSelf = self;
    [[SLLocationHelp sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        
        if (placemark.locality) {
            
            [weakSelf.headerSwitchView setLeftItemText:placemark.locality];
        } else {
            
        }
        
    } status:^(CLAuthorizationStatus status) {
        
    } didFailWithError:^(NSError *error) {
        
    }];
}

- (SPNearVC *)nearVC{
    if (!_nearVC) {
        SPNearVC*nearVC = [[SPNearVC alloc] init];
        [nearVC willMoveToParentViewController:self];
        [self addChildViewController:nearVC];
        [self.view insertSubview:nearVC.view belowSubview:_publishCell];
        nearVC.view.frame = CGRectMake(0,IS_IPHONE_X?88:64, kScreenWidth, kScreenHeight -64-49 );
        
        _nearVC = nearVC;
    }
    return _nearVC;
}

- (SPNewDynamicVC *)dynamicVC {
    if (!_dynamicVC) {
        SPNewDynamicVC *dynamic = [[SPNewDynamicVC alloc] init];
        [dynamic willMoveToParentViewController:self];
        dynamic.delegate = self;
        [self addChildViewController:dynamic];
        [self.view addSubview:dynamic.view];
        [self.view insertSubview:dynamic.view belowSubview:_headerSwitchView];
        dynamic.view.frame = CGRectMake(0, IS_IPHONE_X?64+24:64, kScreenWidth, kScreenHeight-64-49);
        _dynamicVC = dynamic;
    }
    return _dynamicVC;
}

//动态按钮
-(UIButton *)publishCell{
    
    if (!_publishCell) {
        
        _publishCell = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-75, IS_IPHONE_X?44:20, 70, 38)];
        [_publishCell setTitle:@"发布动态" forState:0];
        [_publishCell setTitleColor:[UIColor whiteColor] forState:0];
        
        [_publishCell addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchDown];
        _publishCell.titleLabel.font = kFontNormal_14;
        _publishCell.backgroundColor = [UIColor whiteColor];
        [_publishCell setTitleColor:[UIColor blackColor] forState:0];
        //        _publishCell.layer.borderColor =[UIColor blackColor].CGColor;
        //        _publishCell.layer.borderWidth = 0.8;
        [self.view insertSubview:_publishCell belowSubview:_headerSwitchView];
    }
    return _publishCell;
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
            
            
           weakController.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0); [weakController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
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

//提示 完善信息框
-(SPTipView *)tipView{
    if (!_tipView) {
        _tipView = [[SPTipView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_tipView];
    }
    return _tipView;
}

-(void)navigationSet{
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)sNavigation {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    SPHomeSwitchHeaderView *headerSwitchView = [[SPHomeSwitchHeaderView alloc]initWithFrame:CGRectMake(0, IS_IPHONE_X?44:20, SCREEN_W, 44)];
    headerSwitchView.delegate = self;
    _headerSwitchView = headerSwitchView;
    headerSwitchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerSwitchView];
}

#pragma  mark - -----------------refreshLocationDelegate-----------------
-(void)SPNewDynamicReloadLocation{
    
    [self getLocation];
}

#pragma  mark - -----------------sl_cityListSelectedCityDelegate-----------------

- (void)sl_cityListSelectedCity:(NSString *)selectedCity Id:(NSInteger)Id {
    
    [_headerSwitchView setLeftItemText:selectedCity];
    //刷新数据
    [_dynamicVC reloadTableView];
    
}

#pragma  mark - -----------------headerSwitchDelegate-----------------

-(void)homeSwitchHeaderViewSelectedIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [self goToCityList];
            break;
        case 1:
            [self showNearVC];
            break;
        case 2:
            [self showDynamicVC];
            break;
        case 3:
            [self popOrHiddenPublishBtn];
            break;
        case 4:
            [self popOrHiddenPublishBtn];
            break;
        case 10:
            [self chat];
            break;
        case 100:
            [self sifting];
            break;
        default:
            break;
    }
}

#pragma  mark  筛选

-(void)sifting{
    SPNearSifingVC *vc = [[SPNearSifingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - -----------------action-----------------
//发布动态
-(void)publishClick{
    
    //    if (isEmptyString([StorageUtil getCode])) {
    //        [self goToLogin];
    //        return;
    //    }
    if (![SPCommon gotoLogin]) {
        if ([_publishCell.titleLabel.text isEqualToString:@"筛选"]) {
            
            SPNearSifingVC *vc = [[SPNearSifingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            SPPublishVC *vc = [[SPPublishVC alloc]init];
            vc.publishFinsih = ^(){
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(void)showNearVC{
    self.nearVC.view.hidden = NO;
    self.dynamicVC.view.hidden = YES;
    [self hiddenMenuDownView];
    [self setRightBtnType1];
}

-(void)showDynamicVC{
    _nearVC.view.hidden = YES;
    self.dynamicVC.view.hidden = NO;
    [self hiddenMenuDownView];
    [self setRightBtnType2];
}

-(void)goToCityList{
    
    SLCityListViewController *cityListVC = [SLCityListViewController new];
    
    cityListVC.delegate = self;
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    
    [self presentViewController:nv animated:YES completion:nil];
    
}
-(void)selectedIndex:(NSInteger)index{
    
    //隐藏
    [self hiddenMenuDownView];
    
    if (index ==0) {
        
        [self setRightBtnType1];
        [self.view endEditing:YES];
        //没有登录，就弹出登录界面
        if ([SPCommon gotoLogin]) [StorageUtil saveHomeRemove:@"yes"];return;
        
    }else if(index==1){
        
        [self setRightBtnType2];
        [self.view endEditing:YES];
        
    }else if(index==2){
        [self setRightBtnType2];
    }
}

-(void)setRightBtnType1{
    
    [_publishCell setTitle:@"筛选" forState:0];
}

-(void)setRightBtnType2{
    
    [_publishCell setTitle:@"发布动态" forState:0];
    
}
//弹出发布 按钮
-(void)rightItemClick:(UIButton*)btn{
    
    //筛选
    if (btn.tag == RightItemTypeForSifting) {
        [self pushTopSiftingVC];
        return;
    }
    
    //弹出或隐藏发布动态按钮
    [self popOrHiddenPublishBtn];
    
}

-(void)hiddenMenuDownView{
    
    if(self.publishCell.originY == menuDownOriganY){
        //隐藏
        [UIView animateWithDuration:0.3 animations:^{
            self.publishCell.originY = IS_IPHONE_X?44:20;
        }];
    }
}

-(void)popOrHiddenPublishBtn{
    
    if(self.publishCell.originY == (IS_IPHONE_X? menuDownOriganY+24:menuDownOriganY)){
        //隐藏
        [UIView animateWithDuration:0.4 animations:^{
            self.publishCell.originY = IS_IPHONE_X?44:20;
        }];
    }else{
        //弹出
        [UIView animateWithDuration:0.4 animations:^{
            self.publishCell.originY = IS_IPHONE_X? menuDownOriganY+24:menuDownOriganY;
        }];
    }
}

//筛选
-(void)pushTopSiftingVC{
    
}


@end

