//
//  SPPerfectBaseVCViewController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPMyButtton.h"
#import "SPNameChangedObj.h"
#import "SPPerfectBaseVCViewController.h"

@interface SPPerfectBaseVCViewController ()<UIAlertViewDelegate>
//全背景图片
@property (nonatomic, strong)UIImageView *baseImg;
//返回按钮
@property (nonatomic, strong)UIButton *backBtn;

@end

@implementation SPPerfectBaseVCViewController

- (void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self.view addSubview:self.baseImg];
    [self.view addSubview:self.backBtn];
    //[self.view addSubview:self.jumpBtn];
    [self.view addSubview:self.nextBtn];
    //返回时，是否拦截
    self.needShow = YES;
    if (self.formMyCenter) {
        self.nextBtn.hidden = YES;
        self.jumpBtn.hidden = YES;
        
        //保存
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-70 , SafeAreaStateHeight+5, 70, 44)];
        self.saveBtn = save;
        [save addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
        [save setTitle:@"保存" forState:0];
//        save.backgroundColor = [UIColor whiteColor];
//        save.layer.cornerRadius = 22;
//        save.clipsToBounds = YES;
        [save setTitleColor:[UIColor blackColor] forState:0];
        [self.view addSubview:save];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)laod{

}
//返回按钮
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,SafeAreaStateHeight, 60, 60)];
        //交给子类实现
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    }
    return _backBtn;
}

//全背景图片
-(UIImageView *)baseImg{
    if (!_baseImg) {
        _baseImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _baseImg;
}
//跳过
-(UIButton *)jumpBtn{
    if (!_jumpBtn) {
        _jumpBtn = [[SPMyButtton alloc]initWithFrame:CGRectMake(20,SCREEN_H2-70-SafeAreaBottomHeight, 40, 60)];
        [_jumpBtn setTitle:@"跳过" forState:0];
        [_jumpBtn setTitleColor:[UIColor blackColor] forState:0];
        //交给子类实现
        [_jumpBtn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchDown];
        [_jumpBtn setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    }
    return _jumpBtn;
}

//下一步
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[SPMyButtton alloc]initWithFrame:CGRectMake(SCREEN_W-80,SCREEN_H2-70-SafeAreaBottomHeight, 40, 60)];
        //交给子类实现
        [_nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
        [_nextBtn setTitle:@"下一步" forState:0];
        [_nextBtn setTitleColor:[UIColor blackColor] forState:0];
        [_nextBtn setImage:[UIImage imageNamed:@"grxx_r3_c3"] forState:0];
    }
    return _nextBtn;
}

//设置背景图片
-(void)setBaseImgViewWithImgage:(UIImage *)image{
    [self.baseImg setImage:image];
}

//交给子类实现
-(void)next{}
-(void)jump{}
-(void)save{}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAliterView{
//    if(self.needShow){
//    NSString *tip = self.formMyCenter?@"如需保存请点击右上角保存按钮":@"如需保存请点击右下角的下一步按钮";
//    //初始化AlertView
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改未保存"
//                                                    message:tip
//                                                   delegate:self
//                                          cancelButtonTitle:@"放弃保存"
//                                          otherButtonTitles:@"取消",nil];
//    alert.delegate = self;
//    [alert show];
//    }else{
        [self.navigationController popViewControllerAnimated:YES];
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//上传信息
-(void)postMessage:(NSMutableDictionary *)paragram pushToVC:(NSString *)vc{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [paragram setObject:[StorageUtil getId] forKey:@"id"];
    [paragram setObject:[StorageUtil getCode] forKey:@"code"];
    if ([vc isEqualToString:@"dismiss"]) {
        [paragram setObject:@(1) forKey:@"firstLogin"];
    }
    
[[HttpRequest sharedClient]httpRequestPOST:kUrlUpdateUser parameters:paragram progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
    NSLog(@"%@",responseObject);
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    //将 数据存储
    [StorageUtil saveUserDict:responseObject[@"data"]];
    
    if (self.formMyCenter) {
    
    [self.navigationController popViewControllerAnimated:YES];
   
        //block 层级回传
  !self.perfaceBlock?:self.perfaceBlock(responseObject[@"data"]);
        //观察者模式。
        [[SPNameChangedObj share] postChangedNowIs:responseObject[@"data"][@"nickName"]];
        return ;
      }

    if ([vc isEqualToString:@"dismiss"]) {//约定如果是dismiss ，就退出登录navigationController
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"forHome"];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [StorageUtil saveUserDict:nil];
        
    }else if([vc isEqualToString:@"pop"]){
        
        [self.navigationController popViewControllerAnimated:YES];
       
    }else{
       [self pushViewCotnroller:vc];
    }
   
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   }];
}

@end
