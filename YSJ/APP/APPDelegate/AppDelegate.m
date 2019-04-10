//
//  AppDelegate.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPBaseNavigationController.h"
#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MyTabbarController.h"//tabbar
#import "IQKeyboardManager.h"
#import "GuideView.h"
#import "WXApi.h"
#import "UMessage.h"
#import "UserNotifications/UserNotifications.h"
#import "WeiboSDK.h"
#import "SPKitExample.h"

#import "SPLzsSecondLoginVC.h"//登录
@interface AppDelegate ()<removeGuideView,WXApiDelegate,WeiboSDKDelegate,UNUserNotificationCenterDelegate>
@property(nonatomic,strong) MyTabbarController * myTabbar;
@property(nonatomic,strong) GuideView * guideView;
@property (nonatomic,strong)UIButton * getMaBtn;
@property(nonatomic,strong) UIView * adverView;
@property(nonatomic,strong) UIButton * nextBtn;
@property(nonatomic,strong) UIView * loginView;
@end

@implementation AppDelegate
// {"from_user":"1549950269066756729","context":"begin","to_users":"1769090182153047665"}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [self makeKeyWindows];
 
    [self setTableViewForIos11];
    
    [self IQKeyBoardSet];
  
    //登录IM
//    [self loginIM];
    
   
    //微信分享初始化
//    [self startWX];
    
    //微博初始化
//    [self startWB];
    
  
    //获取APP更新
//    [self hsUpdateApp];
    
    //注册通知服务
//    [self registerNotificationWithOptions:launchOptions];
    
//    [self registerIMNotification];
    
    return YES;
}

//键盘第三方IQKeyboardManager设置
-(void)IQKeyBoardSet{
    //键盘第三方IQKeyboardManager设置
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

//设置window
-(void)makeKeyWindows{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.myTabbar = [[MyTabbarController alloc]init];
    self.window.rootViewController = self.myTabbar;
}

-(void)setTableViewForIos11{
    
//    if (@available(ios 11.0,*)) {
  UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
//    }
}
-(void)registerIMNotification{
    /// 需要区分iOS SDK版本和iOS版本。
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else
#endif
    {
        /// 去除warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#pragma clang diagnostic pop
    }
    
//     [[[YWAPI sharedInstance] getGlobalPushService] setXPushCertName:@"SmallPigPushProvisioning"];
}
//注册通知
-(void)registerNotificationWithOptions:(NSDictionary *)launchOptions{
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings
//                                            settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //适配https
//    [UMessage startWithAppkey:@"your appkey" launchOptions:launchOptions httpsenable:YES ];
    //启动
    [UMessage startWithAppkey:@"59aca700aed1794b8f001247" launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
}

#pragma mark - createMyTabbar
- (void)createMyTabbar{
    
    self.myTabbar = [[MyTabbarController alloc]init];
    self.window.rootViewController = self.myTabbar;
    [self.myTabbar.view addSubview:self.adverView];
}

/// iOS8下申请DeviceToken
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

#endif

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    [WXApi handleOpenURL:url delegate:self];
    
    [WeiboSDK handleOpenURL:url delegate:self];
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    [WXApi handleOpenURL:url delegate:self];
    
    [WeiboSDK handleOpenURL:url delegate:self];
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic valueForKey:@"resultStatus"] integerValue] == 9000) {
                Toast(@"支付成功");//支付成功
            }else{
                Toast(@"支付失败");
            }
        }];
    }
    return YES;
}

//登录IM
-(void)loginIM{
    
    //初始化IMSDK
    [[SPKitExample sharedInstance] callThisInDidFinishLaunching];
    
    if (isEmptyString([StorageUtil getId])) return;
    //应用登陆成功后，调用SDK
    [[SPKitExample sharedInstance]callThisAfterISVAccountLoginSuccessWithYWLoginId:[StorageUtil getCode] passWord:[StorageUtil getIm_password] preloginedBlock:nil successBlock:^{
        
    } failedBlock:^(NSError *aError) {
        
    }];
    
}

-(void)startWX{
     //向微信注册
   
    [WXApi registerApp:@"wx132562f5a04bd5df"];
    
}

-(void)startWB{
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"3290914059"];
    
}

-(void)onReq:(BaseReq *)req{
    if ([req isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)req;
        switch(response.errCode){
            case WXSuccess:
                Toast(@"充值成功！");
                break;
                
            default:
                Toast(@"充值失败。");
                break;
        }
    }
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                Toast(@"充值成功！");
                break;
                
            default:
                Toast(@"充值失败。");
                break;
        }
    }
}

-(void)addGuideView{
    
    
    //[[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"isRun"];
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRun"]boolValue]) {
        
        NSArray * guideArray = @[@"guideImage2.jpg"];
        
        self.guideView = [[GuideView alloc]initWithFrame:self.window.bounds imageArray:guideArray];
        self.guideView.delegate = self;
        [self.adverView addSubview:self.guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRun"];
        
    }else {
        
        [self createAdvertisement];
    }
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self.guideView action:@selector(inputButton)];
    //    self.guideView.userInteractionEnabled = YES;
    //    [self.guideView addGestureRecognizer:tap];
    //[self.guideView.inputButton addTarget:self action:@selector(inputButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - guideViewDelegate
- (void)removeGuideView:(BOOL)remove{
    
    if (remove) {
        
        [self inputButton];
    }
}

- (void)inputButton{
    
    //    [self.window.rootViewController presentViewController:self.myTabbar animated:YES completion:nil];
    [self.guideView removeFromSuperview];
    [self createAdvertisement];
    //[MBProgressHUD hideHUDForView:self.myTabbar.view animated:YES];
}

#pragma mark - createAdvertisement广告
- (void)createAdvertisement{
    //
    UIView * view = [[UIView alloc]initWithFrame:SCREEN_B];
    view.backgroundColor = WC;
    [self.adverView addSubview:view];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W,(SCREEN_H+64)/4*3)];
    
    webView.scalesPageToFit = YES;
    webView.backgroundColor = WC;
    //AdvertisementURL
    NSURL * url = [NSURL URLWithString:@"http://59.110.70.112:8080/web/adv.html"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [webView loadRequest:request];
    
    [view addSubview:webView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,(SCREEN_H2)/4*3,SCREEN_W,(SCREEN_H2)/4)];
    imageView.image=[UIImage imageNamed:@"gg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    self.nextBtn.layer.cornerRadius = 8;
    self.nextBtn.clipsToBounds = YES;
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [webView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(webView.mas_top).offset(SafeAreaStateHeight+10);
        make.left.offset(SCREEN_W-120);
        make.width.offset(100);
        make.height.offset(30);
    }];
    
    
    [self.nextBtn addTarget:self action:@selector(deleteAdvertisement) forControlEvents:UIControlEventTouchUpInside];
    //[self.nextBtn setTitle:@"跳过" forState:UIControlStateNormal];
    self.nextBtn.clipsToBounds = YES;
    self.nextBtn.layer.cornerRadius = 10;
    [self.nextBtn setBackgroundColor:RGBA(142, 142, 142, 0.5)];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self openCountdown];
    
}

#pragma mark -  开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 5; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                //                [self.nextBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //
                //                self.nextBtn.userInteractionEnabled = YES;
                [self deleteAdvertisement];
            });
            
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.nextBtn setTitle:[NSString stringWithFormat:@"跳过(%.2ds)", seconds] forState:UIControlStateNormal];
                //[self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                //self.getMaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -  删除广告页开始登录页
- (void)deleteAdvertisement{
    
    [self.adverView removeFromSuperview];
    NSLog(@"[StorageUtil getCode]:%@ [StorageUtil getid]:%@",[StorageUtil getCode],[StorageUtil getId]);
}

/**
 *  天朝专用检测app更新
 */
-(void)hsUpdateApp
{
    //1.获取一个全局串行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.把任务添加到队列中执行
    dispatch_async(queue, ^{
        
        //2先获取当前工程项目版本号
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
        
        //3从网络获取appStore版本号
        NSError *error;
        NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
        if (response == nil) {
            
            return;
        }
        
        NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            
            return;
        }
        NSArray *array = appInfoDic[@"results"];
        NSDictionary *dic = [array lastObject];
        NSString *appStoreVersion = dic[@"version"];
        
        //4当前版本号小于商店版本号,就更新
        if([currentVersion floatValue]<[appStoreVersion floatValue])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
                [alert show];
            });
            
        }else{
            //不做任何处理
        }
        
    });
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/lets-gou/id%@?l=zh&ls=1&mt=8", STOREAPPID]];
        NSLog(@"%@",url);
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
   [[UIApplication sharedApplication] setApplicationIconBadgeNumber: [[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService].countOfUnreadMessages];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if (isEmptyString([StorageUtil getCode])) return;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:[SPCommon getLoncationDic] forKey:@"location"];
    
    [dic setObject:[StorageUtil getCity] forKey:@"city"];
    
    [dic setObject:isEmptyString([StorageUtil getUserAddresssDict][@"SubLocality"])?@"":[StorageUtil getUserAddresssDict][@"SubLocality"] forKey:@"locationValue"];
    
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:KUrlUpdateLiveness parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"dsd");
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //[StorageUtil saveId:@""];
    //[StorageUtil saveCode:@""];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        //        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        //        [alert show];
    }
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭U-Push自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

@end

