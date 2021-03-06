//
//  MineSetViewController.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/26.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "MineSetViewController.h"
#import "SetTableViewCell.h"
#import "LzsOtherViewController.h"
#import "SPCountSetVC.h"
#import "SPKitExample.h"
//隐私设置
#import "SPPersonalPrivacyVC.h"
@interface MineSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView * _tableView;
}
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,copy) NSString * detailStr;
@property (nonatomic,assign) CGFloat folderSize;

@end

@implementation MineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAINCOLOR;
    [self createUI];
    [self createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//   self.folderSize =  [self folderSizeWithPath:[self getPath]];
//    
//    self.detailStr = [NSString stringWithFormat:@"本地缓存%.2fM",self.folderSize];
}

#pragma mark - createUI
- (void)createUI{
    
    self.titleLabel.text = @"设置";
//    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 44)];
//    topView.backgroundColor = MAINCOLOR;
//    [self.view addSubview:topView];
//    
//    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    returnBtn.frame = CGRectMake(10, 5, 30, 30);
//    [returnBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:returnBtn];
//    
//    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-40, 7, 80, 30)];
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.text = @"设置";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [topView addSubview:titleLabel];
    //,@"隐私设置" ,@"lb_r5_c1" ,@"意见反馈" ,@"lb_r13_c1"
    self.titleArr = @[@"账号设置",@"关于我们",@"帮助中心"];
    self.titleImageArr = @[@"lb_r1_c1",@"lb_r9_c1",@"lb_r11_c1"];
    
    UIButton * quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    quitBtn.frame = CGRectMake(20, IS_IPHONE_X?SCREEN_H-34-70:SCREEN_H-70, SCREEN_W - 40, 40);
    //[quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    //[quitBtn setBackgroundImage:[UIImage imageNamed:@"but_red"] forState:UIControlStateNormal];
    [quitBtn setImage:[UIImage imageNamed:@"lb_r15_c3"] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:quitBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //self.detailStr = [NSString stringWithFormat:@"本地缓存%0.2fM",self.folderSize];
    
}

#pragma mark - quitBtnClick退出登录
- (void)quitBtnClick:(UIButton *)quitBtn{

    UIAlertAction * alertAc = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [StorageUtil saveId:nil];
        [StorageUtil saveCode:nil];
        [StorageUtil saveUserMobile:nil];
        [StorageUtil saveFirstLogin:nil];
        [StorageUtil saveIm_password:nil];
        [StorageUtil saveNickName:nil];
        [StorageUtil saveUserDict:@{}];
        [StorageUtil saveIfQuit:@"1"];
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"loginStatus"];
        //self.tabBarController.selectedIndex = 0;
        [self.navigationController popViewControllerAnimated:NO];
        //IM退出
        [[SPKitExample sharedInstance]callThisBeforeISVAccountLogout];
        
    }];
    UIAlertAction * alertNo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"退出提示" message:@"您是否要退出" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:alertAc];
    [alertVC addAction:alertNo];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    NSLog(@"点击了退出登录");
    
}

#pragma mark - returnClick
- (void)returnClick:(UIButton *)returnBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - createTableView
- (void)createTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    //self.detailStr = [NSString stringWithFormat:@"本地缓存%0.2fM",[self folderSizeWithPath:[self getPath]]];
    
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SetTableViewCell * setCell = [SetTableViewCell tableViewCellWithTableView:tableView];
    
    setCell.textLabel.text = self.titleArr[indexPath.row];
    setCell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    return setCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0) {//账号设置
        
        SPCountSetVC * setVC = [[SPCountSetVC alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if (indexPath.row ==1) {//关于我们
        
        LzsOtherViewController * otherVC = [[LzsOtherViewController alloc]init];
        otherVC.titleStr = @"关于我们";
        [self presentViewController:otherVC animated:YES completion:nil];
        //隐私设置
        //SPPersonalPrivacyVC * personalVC = [[SPPersonalPrivacyVC alloc]init];
        //[self.navigationController pushViewController:personalVC animated:YES];
        
    }else if (indexPath.row ==2) {//帮助中心
        
        LzsOtherViewController * otherVC = [[LzsOtherViewController alloc]init];
        otherVC.titleStr = @"帮助中心";
        //[self.navigationController pushViewController:otherVC animated:YES];
        [self presentViewController:otherVC animated:YES completion:nil];

        
    }else if (indexPath.row ==3) {//意见反馈
        
//        LzsOtherViewController * otherVC = [[LzsOtherViewController alloc]init];
//        otherVC.titleStr = @"意见反馈";
//        
//        //[self.navigationController pushViewController:otherVC animated:YES];
//        [self presentViewController:otherVC animated:YES completion:nil];
        
    }else if (indexPath.row ==4) {
        
        
    }

}
#pragma mark - 版本自动更新检测
/**
 *  天朝专用检测app更新
 */
//-(void)hsUpdateApp
//{
//    //2先获取当前工程项目版本号
//    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//    NSLog(@"%@",infoDic);
//    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
//    
//    //3从网络获取appStore版本号
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
//    if (response == nil) {
//        NSLog(@"你没有连接网络哦");
//        return;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        NSLog(@"hsUpdateAppError:%@",error);
//        return;
//    }
//    //    NSLog(@"%@",appInfoDic);
//    NSArray *array = appInfoDic[@"results"];
//    
//    if (array.count < 1) {
//        NSLog(@"此APPID为未上架的APP或者查询不到");
//        return;
//    }
//    
//    NSDictionary *dic = array[0];
//    NSString *appStoreVersion = dic[@"version"];
//    //打印版本号
//    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
//    //设置版本号
//    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//    if (currentVersion.length==2) {
//        currentVersion  = [currentVersion stringByAppendingString:@"0"];
//    }else if (currentVersion.length==1){
//        currentVersion  = [currentVersion stringByAppendingString:@"00"];
//    }
//    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//    if (appStoreVersion.length==2) {
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
//    }else if (appStoreVersion.length==1){
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
//    }
//    
//    //4当前版本号小于商店版本号,就更新
//    if([currentVersion floatValue] < [appStoreVersion floatValue])
//    {
//        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
//            [[UIApplication sharedApplication] openURL:url];
//        }];
//        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isUpdate"];
//        }];
//        [alercConteoller addAction:actionYes];
//        [alercConteoller addAction:actionNo];
//        [self presentViewController:alercConteoller animated:YES completion:nil];
//    }else{
//        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
//    }
//    
//}


#pragma mark - 缓存清理方法
//首先需要找到缓存的文件路径
- (NSString *)getPath{
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return path;
}
//计算缓存文件夹的大小
- (CGFloat)folderSizeWithPath:(NSString *)path{
    
    //获取文件管理类的对象
    NSFileManager * manager = [NSFileManager defaultManager];
    
    CGFloat folderSize = 0.0;
    self.folderSize = folderSize;
    if ([manager fileExistsAtPath:path]) {
        
        //首先获取文件夹下的文件
        NSArray * fileArray = [manager subpathsAtPath:path];
        for (NSString * fileName in fileArray) {
            //获取每个子文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            
            //每个子文件的大小
            long long fileSize = [manager attributesOfItemAtPath:filePath error:nil].fileSize;
            
            //从字节到M
            folderSize +=fileSize / 1024.0 / 1024.0;
            
            
        }
        //删除文件夹
        
        [self deleteFolderSizeWith:folderSize];
        
        return folderSize;
    }else{
        
        return 0.0;
    }
    
}

- (void)deleteFolderSizeWith:(CGFloat)folderSize{
    
    if (folderSize > 0.01) {
        
        //提示用户
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前有%.2fM缓存,是否需要清理",folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        
//        [alertView show];
        //[_tableView reloadData];
    } else{
        
        //表示不用清理
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,您已经清理过了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
        //[_tableView reloadData];
    }
}

#pragma mark - alertView的协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //彻底清理缓存
        [self clearCacheAtPath:[self getPath]];
        
                //[_tableView reloadData];
    }
}

- (void)clearCacheAtPath:(NSString *)path{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:path]) {
        
        NSArray * fileArray = [manager subpathsAtPath:path];
        //可以操作保留某些格式的文件缓存
        for (NSString * fileName in fileArray) {
            
            if ([fileName hasSuffix:@".text"]) {
                
                NSLog(@"不删除这类文件");
            }else{
                
                //删除其余文件
                NSString * filePath = [path stringByAppendingPathComponent:fileName];
                [manager removeItemAtPath:filePath error:nil];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
