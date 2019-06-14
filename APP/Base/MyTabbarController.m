//
//  MyTabbarController.m
//  TimeMemory

#import "SPTestViewController.h"

#import "MyTabbarController.h"
#import "SelectionViewController.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMKit.h>
#import "YSJDiscoverVC.h"

#import "YSJMyCenterVC.h"
#import "YSJFastLoginVC.h"
#import "SPBaseNavigationController.h"
#import "IQKeyboardManager.h"
#import "SPNewHomeVC.h"
#import "SPKitExample.h"
#import "SPUtil.h"
#import "SPBaseDiscover.h"
#import "UIImage+XW.h"
#import "XWPopMenuController.h"
#import "RegisterViewController.h"
#import "SPLzsSecondLoginVC.h"

@interface MyTabbarController ()<UITabBarControllerDelegate>
{
    SPBaseNavigationController * _homeNav;
}
@end

@implementation MyTabbarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createViewControllers];
    
    [self createTabbar];
    
    [self AFNReachability];
}

#pragma mark - ************************************ 网络监听状态 ************************************

- (void)AFNReachability

{
    
    //1.创建网络监听管理者
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                
                NSLog(@"未知");
                
                
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"没有网络");
                //                [self showNoDataWindows];
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"4G");
                
                
                
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                NSLog(@"WIFI");
                
                
                break;
                
                
                
            default:
                
                break;
                
        }
        
        if (status != AFNetworkReachabilityStatusNotReachable) {
            
            NSLog(@"有网络了");
      
        }
        
    }];
    
    
    
    //3.开始监听
    
    [manager startMonitoring];
    
}
-(void)showNoDataWindows{
    
    
    UIView *noNetWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    noNetWindow.backgroundColor = RGBA(0, 0, 0, 0.4);
    
    //  文字
    UIButton *label       = [[UIButton alloc] init];
    label.titleLabel.font           = [UIFont systemFontOfSize:17];
    [label setTitleColor:KWhiteColor forState:0];
    label.backgroundColor = [UIColor blackColor];
    [label setTitle:@"无网络，点击刷新" forState:0];
    label.frame  = CGRectMake(20,kWindowH-100, kWindowW-40, 50);
    [label addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventTouchDown];
    label.layer.cornerRadius = 8;
    label.clipsToBounds = YES;
    //    label.layer.borderColor = KWhiteColor.CGColor;
    //    label.layer.borderWidth = 1;
    [noNetWindow addSubview:label];
    
    UIWindow *keyWindow =[self mainWindow];
    [keyWindow addSubview:noNetWindow];
}

-(void)reloadView{
    
    //    self.selectedIndex = 0;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationReloadForNoWifi object:nil];
}

//获取当前window
- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

-(void)createViewControllers{
    
    SPNewHomeVC * homeVC =[[SPNewHomeVC alloc]init];
    SPBaseNavigationController * homeNav = [[SPBaseNavigationController alloc]initWithRootViewController:homeVC];
    _homeNav = homeNav;
    
    //创建会话列表页
    NIMSessionListViewController *discoverVC = [[NIMSessionListViewController alloc] init];
    discoverVC.navigationItem.title = @"消息";
    SPBaseNavigationController * discoverNav = [[SPBaseNavigationController alloc]initWithRootViewController:discoverVC];
    
    YSJDiscoverVC * leaseVC = [[YSJDiscoverVC alloc]init];
    SPBaseNavigationController * leaseNav = [[SPBaseNavigationController alloc]initWithRootViewController:leaseVC];
    
    YSJMyCenterVC * mineVC = [[YSJMyCenterVC alloc]init];
    SPBaseNavigationController * mineNav = [[SPBaseNavigationController alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = @[homeNav,discoverNav,[self getThirdTabbar],leaseNav,mineNav];

    
    self.delegate = self;
    
}

- (void)createTabbar{
    
    self.tabBar.translucent = NO;
    
    NSArray * unselectedArray = @[@"shouye0-1",@"xiaoxi0",@"fabu",@"faxian0",@"wode0"];
    
    NSArray * selectedArray = @[@"shouye0",@"xiaoxi1",@"fabu",@"faxian1",@"wode1"];
    
    NSArray * titleArray = @[@"首页",@"消息",@"发布",@"发现",@"我的"];
    
    for (int i = 0; i<self.tabBar.items.count; i++) {
        
        UIImage * unselectedImage = [UIImage imageNamed:unselectedArray[i]];
        
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * selectedImage = [UIImage imageNamed:selectedArray[i]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * item = self.tabBar.items[i];
        
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        //tabbar 具体设计63 144 244
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor} forState:UIControlStateSelected];
        
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        
    }
}



-(UINavigationController *)getThirdTabbar{
    
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
                //                    YWWebViewController *controller = [YWWebViewController makeControllerWithUrlString:@"https://im.taobao.com/" andImkit:[SPKitExample sharedInstance].ywIMKit];
                //                    [controller setHidesBottomBarWhenPushed:YES];
                //                    [controller setTitle:@"功能介绍"];
                //                    [weakConversationListController.navigationController pushViewController:controller animated:YES];
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
    
    //        conversationListController.ywcsTrackTitle = @"会话列表";
    
    // 会话列表空视图
    //        if (conversationListController)
    //        {
    //            CGRect frame = CGRectMake(0, 0, 100, 100);
    //            UIView *viewForNoData = [[UIView alloc] initWithFrame:frame];
    //            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    //            imageView.center = CGPointMake(viewForNoData.frame.size.width/2, viewForNoData.frame.size.height/2);
    //            [imageView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin];
    //            viewForNoData.backgroundColor = [UIColor redColor];
    //            [viewForNoData addSubview:imageView];
    //
    //            conversationListController.viewForNoData = viewForNoData;
    //            conversationListController.viewForNoData.backgroundColor  = [UIColor redColor];
    //
    //        }
    
    {
        __weak typeof(conversationListController) weakController = conversationListController;
        
        [conversationListController setViewWillAppearBlock:^(BOOL aAnimated) {
            
            [weakController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
            [weakController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
            lab.text = @"沟通";
            lab.textAlignment = NSTextAlignmentCenter;
            weakController.navigationItem.titleView = lab;
            weakController.navigationController.navigationBar.translucent = NO;
            weakController.extendedLayoutIncludesOpaqueBars = NO;
            weakController.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        }];
        
        
        [conversationListController setViewWillDisappearBlock:^(BOOL aAnimated) {
            [weakController.navigationController setNavigationBarHidden:NO ];
            
        }];
        
        [conversationListController setViewDidLoadBlock:^{
            
            [weakController.navigationController setNavigationBarHidden:YES animated:YES];
            //                weakController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:weakSelf action:@selector(addCustomConversation)];
            
            //                // 加入搜索栏
            //                weakController.tableView.tableHeaderView = weakController.searchBar;
            //                CGPoint contentOffset = CGPointMake(0, weakController.searchBar.frame.size.height);
            //                [weakController.tableView setContentOffset:contentOffset animated:NO];
            
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
    
    SPBaseNavigationController * selectionNav = [[SPBaseNavigationController alloc]initWithRootViewController:conversationListController];
    
    return selectionNav;
}

#pragma mark - tabbarDelegate
//代理方法,这个方法是来判断当点击某个tabBarItem时是否要点击下去,
//其实你可以这样理解:就是是否要点击这个tabBarItem.
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
   
    if ([viewController.tabBarItem.title isEqualToString:@"首页"]) {
        return YES;
    }else if ([viewController.tabBarItem.title isEqualToString:@"发布"])
    {
        XWPopMenuController *vc = [[XWPopMenuController alloc]init];
        SPBaseNavigationController *nav = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
        vc.title = @"fabu";
        //虚化背景
        UIImage *image = [UIImage imageWithCaputureView:self.view];
        
        vc.backImg = image;
        
        [self presentViewController:nav animated:NO completion:nil];
        
        return NO;
        
    }else{
        [IQKeyboardManager sharedManager].enable = YES;
    }
    
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        if (isEmptyString([StorageUtil getId])) {
            
            YSJFastLoginVC *vc =[[YSJFastLoginVC alloc]init];
            SPBaseNavigationController *nav = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
        self.selectedIndex= 4;
        
        return YES;
    }
    
    if ([viewController.tabBarItem.title isEqualToString:@"租约"]) {
        
        self.selectedIndex= 3;
        
        return YES;
    }
    return YES;
}

//动画
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}

- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //动画效果
            [imageView transformAnimation];
        }
    }
}


@end
