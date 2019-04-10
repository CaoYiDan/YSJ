//
//  MineViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

//第三方角标
#import "UITabBar+SPTabbarBadge.h"
#import "UIView+Frame.h"
#import "WZLBadgeImport.h"
//第三方上传头像
#import "BDImagePicker.h"
//进度条
#import "HWProgressView.h"
//本地
#import "MineViewController.h"
#import "RegisterViewController.h"
#import "MineSetViewController.h"
#import "SPMyAppointmentVC.h"//预约
#import "SPLzsMyFocusViewController.h"//关注
#import "SPNewMyProfileVC.h"//我的详细
#import "SPMylevelVC.h"//我的等级
//#import "SPMyProflieVC.h"//完善档案
//测试
#import "SPPerfecSexVC.h"
#import "SPMyKungFuVC.h"
//我的动态
#import "SPProfileDynamicVC.h"
//我的消息
#import "SPMyMessageViewController.h"
//我的兴趣
#import "SPMyInterestVC.h"
//分享界面
#import "SPShareView.h"

//登录
#import "SPLzsLoginView.h"
//我的技能
#import "SPLzsMySkillsVC.h"
//我的需求
#import "SPMineNeededVC.h"

#import "SPMineIdentificationVC.h"
//我的钱包
#import "SPLzsMineWalletViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,LoginViewDelegate>
//个人中心底部分类
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,strong) NSMutableArray * titleBtnNumArr;
@property (nonatomic,strong) NSMutableArray * badgeNumArr;
//tableHead部分
@property(nonatomic,copy) NSString * notBigCow;
@property(nonatomic,copy) NSString * nickStr;
@property(nonatomic,copy) NSString * signatureStr;

@property(nonatomic,copy) NSString *topRightGoodStr;//点赞数
@property(nonatomic,copy) NSString * headImageStr;
@property(nonatomic,strong) UILabel * nickNameLab;

@property(nonatomic,strong) UIImageView * headIV;
@property(nonatomic,strong) UILabel * signatureLab;
@property (nonatomic, weak) HWProgressView *progressView;//进度条
@property (nonatomic, strong) NSTimer *timer;//进度条
@property(nonatomic,assign)CGFloat timerProgerss;
@property (nonatomic,strong)UIButton * detailsBtn;//详情
@property (nonatomic,copy)NSString * gender;//性别
@property(nonatomic,strong)SPShareView *shareView;
//@property(nonatomic,assign)int praiseNum;//点赞数

//主页面
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView * headView;
//分享的图片image
@property(nonatomic,strong) UIImage * shareImage;
@end

@implementation MineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - initLoginView
- (void)initLoginView{
    
    SPLzsLoginView * loginView = [[SPLzsLoginView alloc]initWithFrame:self.view.bounds];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

- (void)changeToHome{
    
    self.tabBarController.selectedIndex = 0;
}

- (void)loadNewData{
    
}

#pragma mark - createUI
- (void)createUI{
    
    self.titleArr = @[@"兴趣设置",@"认证中心",@"应用分享"];
    self.titleImageArr = @[@"wd_sz_xq",@"wd_sz_rz",@"wd_sz_fx"];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight, 0);
    self.tableView.backgroundColor = grayF2F2F2;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIImageView * imageIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wd_01"]];
    self.headView.frame = CGRectMake(0, 0, SCREEN_W, 340);
    imageIV.frame = self.headView.frame;
    imageIV.contentMode = UIViewContentModeScaleAspectFill;
    [self.headView insertSubview:imageIV atIndex:0];
    
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    UIView * footerView = [[UIView alloc]init];
    self.tableView.tableFooterView = footerView;
}

#pragma mark - login去登陆

- (void)login{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"dl_pic"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGoLogin)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    [self.headView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(50);
        make.left.offset(SCREEN_W/2-60);
        make.size.with.offset(120);
        make.size.height.offset(120);
        
    }];
    
    UILabel * perfectLab = [[UILabel alloc]init];
    perfectLab.text = @"档案完善度:0%";
    perfectLab.textColor = [UIColor blackColor];
    perfectLab.textAlignment = NSTextAlignmentCenter;
    perfectLab.font = [UIFont boldSystemFontOfSize:15];
    [self.headView addSubview:perfectLab];
    
    [perfectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.offset (SCREEN_W/2-60);
        make.width.offset(120);
        make.height.offset(40);
        
    }];
    //[self mineCategory:200];
    
    
}

#pragma mark - tapGoLogin点击登录

- (void)tapGoLogin{
    
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:registerVC];
//    self.hidesBottomBarWhenPushed = YES;
    registerVC.fromMine = YES;
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark - logined已经登录
- (void)logined{
    
    //设置
    UIButton * setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headView addSubview:setBtn];
    
    [setBtn setImage:[UIImage imageNamed:@"wd_sz"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(SafeAreaStateHeight);
        make.right.offset(-15);
        make.width.offset(40);
        make.height.offset(40);
        
    }];
    
    //编辑
    UIButton * editBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    
    [self.headView addSubview:editBtn];
    
    [editBtn addTarget:self action:@selector(perfectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    editBtn.clipsToBounds = YES;
    editBtn.layer.cornerRadius = 8;
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.font = font(12);
    [editBtn setTitleColor:RGBCOLOR(153, 153, 153) forState:UIControlStateNormal];
    [editBtn setBackgroundColor:RGBA(255, 255, 255, 0.5)];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(setBtn);
        make.right.equalTo(setBtn.mas_left).offset(-10);
        make.width.offset(60);
        make.height.offset(25);
        
    }];
    
    //头像
    UIImageView * imageView = [[UIImageView alloc]init];
    //imageView.backgroundColor = MAINCOLOR;
    self.headIV = imageView;
    //imageView.userInteractionEnabled= YES;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 30;
    [self.headView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(50);
        make.left.offset(SCREEN_W/2-30);
        make.width.offset(60);
        make.height.offset(60);
    }];
    
    if (self.headImageStr.length) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.headImageStr]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        //[self.detailsBtn setImage:[UIImage imageNamed:@"me_xq"] forState:UIControlStateNormal];
    }else{
        
        imageView.contentMode = UIViewContentModeCenter;
        NSLog(@"%@",self.gender);
        if ([self.gender intValue]==1) {
            imageView.image = [UIImage imageNamed:@"boy_image"];
            
        }else{
            
            imageView.image = [UIImage imageNamed:@"girl_image"];
        }
    }
    
//    imageView.badgeBgColor = [UIColor redColor];
//    imageView.badgeCenterOffset = CGPointMake(45,45);
//    NSInteger value = [self.topRightGoodStr integerValue];
//    [imageView showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeNone];
    //点赞图
    UIImageView * priseIV = [[UIImageView alloc]init];
    [self.headView addSubview:priseIV];
    priseIV.image = [UIImage imageNamed:@"wd_dz"];
    [priseIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(imageView.mas_bottom).offset(5);
        make.left.offset(SCREEN_W/2+10);
        make.width.offset(50);
        make.height.offset(25);
        
    }];
    NSLog(@"%@",self.topRightGoodStr);
    //点赞数
    UILabel * priseLab = [[UILabel alloc]init];
    priseLab.text = [NSString stringWithFormat:@"%@",self.topRightGoodStr];
    priseLab.textColor = WC;
    priseLab.textAlignment = NSTextAlignmentCenter;
    priseLab.font = [UIFont boldSystemFontOfSize:11];
    [priseIV addSubview:priseLab];
    
    [priseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(priseIV.mas_top).offset(6);
        make.left.equalTo(priseIV.mas_left).offset(20);
        make.width.offset(28);
        make.height.offset(20);
        
    }];
    //昵称
    self.nickNameLab = [[UILabel alloc]init];
    self.nickNameLab.text = self.nickStr;
    self.nickNameLab.textColor = RGBCOLOR(249, 0, 124);
    self.nickNameLab.textAlignment = NSTextAlignmentCenter;
    self.nickNameLab.font = [UIFont boldSystemFontOfSize:18];
    [self.headView addSubview:self.nickNameLab];
    
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.left.offset(SCREEN_W/2-150);
        make.width.offset(300);
        make.height.offset(25);
        
    }];
    
    
    //签名
    
    self.signatureLab = [[UILabel alloc]init];
    
    if (self.signatureStr.length>0) {
        self.signatureLab.text = self.signatureStr;
    }else{
        
        self.signatureLab.text = @"这家伙很懒,没有个性签名~";
    }
    
    self.signatureLab.textColor =RGBCOLOR(245, 48, 143);
    self.signatureLab.textAlignment = NSTextAlignmentCenter;
    self.signatureLab.font = [UIFont systemFontOfSize:13];
    
    self.signatureLab.numberOfLines = 1;//表示label可以多行显示UILineBreakModeCharacterWrap
    
    //self.signatureLab.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，与上面的计算保持一致。
    
    [self.headView addSubview:self.signatureLab];
    
    [self.signatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nickNameLab.mas_bottom).offset(5);
        make.left.offset (SCREEN_W/2-140);
        make.width.offset(280);
        make.height.offset(20);
        
    }];
    
    UILabel * perfectLab = [[UILabel alloc]init];
    perfectLab.text = [NSString stringWithFormat:@"档案完善度:%.f%@",self.timerProgerss *100,@"%"];
    //NSLog(@"%@<%.2f",perfectLab.text,self.timerProgerss);
    perfectLab.textColor = [UIColor blackColor];
    perfectLab.textAlignment = NSTextAlignmentLeft;
    perfectLab.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:perfectLab];
    
    [perfectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.signatureLab.mas_bottom).offset(50);
        make.left.offset (35);
        make.width.offset(120);
        make.height.offset(20);
        
    }];
    
    //去完善档案button
    UIButton * perfectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    perfectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [perfectBtn setTitle:@"去完善档案>" forState:UIControlStateNormal];
    [perfectBtn setTitleColor:RGBCOLOR(143, 143, 143) forState:UIControlStateNormal];
    [perfectBtn addTarget:self action:@selector(perfectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:perfectBtn];
    
    [perfectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(perfectLab.mas_top);
        make.right.offset(-25);
        make.width.offset(100);
        make.height.offset(20);
        
    }];
    //分类按钮
    
    //总数
    //[self.titleBtnNumArr addObject:@0];
    self.titleBtnNumArr = [NSMutableArray arrayWithCapacity:0];
    [self.titleBtnNumArr addObject:@"我的技能"];
    [self.titleBtnNumArr addObject:@"我的需求"];
    [self.titleBtnNumArr addObject:@"我的关注"];
    [self.titleBtnNumArr addObject:@"我的动态"];
    [self.titleBtnNumArr addObject:@"我的消息"];
    
    //    self.badgeNumArr = [NSMutableArray arrayWithCapacity:0];
    //    [self.badgeNumArr addObject:@"1"];
    //    [self.badgeNumArr addObject:@"2"];
    //    [self.badgeNumArr addObject:@"3"];
    //    [self.badgeNumArr addObject:@"4"];
    //    [self.badgeNumArr addObject:@"5"];
    //@"me_r7_c2",
    NSArray * imageArr = @[@"wd_jn_",@"wd_xq_",@"wd_gz_",@"wd_dt_",@"wd_xx_"];
    
    NSLog(@"%@ %@",self.badgeNumArr,self.titleBtnNumArr);
    
    for (int i = 0; i<5; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.frame = CGRectMake(i * (SCREEN_W/3),bottom+10, SCREEN_W/3-10,60);
        
        //[btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(mineCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //btn.layer.cornerRadius = btn.width/2;
        
        
        UIButton * btnLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLabel setTitleColor:RGBCOLOR(143, 143, 143) forState:UIControlStateNormal];
        btnLabel.titleLabel.font =font(13);
        [btnLabel setTitle:self.titleBtnNumArr[i] forState:UIControlStateNormal];
        
        [self.headView addSubview:btnLabel];
        [self.headView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(perfectLab.mas_bottom).offset(28);
            make.left.offset(10+(SCREEN_W-20)/5*i);
            make.width.offset((SCREEN_W-20)/5);
            make.height.offset(30);
            //            make.top.equalTo(perfectLab.mas_bottom).offset(28);
            //            make.left.offset(35+(SCREEN_W-70-100)/5*i+i*25);
            //            make.width.offset((SCREEN_W-70-100)/5);
            //            make.height.offset(30);
        }];
        
        [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(btn.mas_bottom).offset(5);
            make.left.equalTo(btn.mas_left);
            make.width.equalTo(btn.mas_width);
            make.height.offset(20);
        }];
        if (i<=5) {
            //角标
            btn.badgeBgColor = [UIColor redColor];
            btn.badgeCenterOffset = CGPointMake(42,10);
            NSInteger value = [self.badgeNumArr[i] integerValue];
            [btn showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeNone];
            
            NSLog(@"iiiiiii%d value%ld badgeNum%@",i,value,self.badgeNumArr[i]);
            
        }
        
    }
    
    //    self.topRightIV = [[UIImageView alloc]init];
    //    self.topRightIV.image = [UIImage imageNamed:@"sp_r3_c13"];
    //    [self.headView addSubview:self.topRightIV];
    //
    //    [self.topRightIV mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.offset(10);
    //        make.right.offset(-10);
    //        make.width.offset(110);
    //        make.height.offset(45);
    //
    //    }];
    //
    //    //等级
    //    UILabel * gredeLab = [[UILabel alloc]init];
    //    self.topRightGradeLab = gredeLab;
    //    //NSLog(@"self.topRightGradeStr%ld",self.topRightGradeStr);
    //    gredeLab.text =@"0";
    //    gredeLab.textColor = [UIColor blackColor];
    //    gredeLab.textAlignment = NSTextAlignmentCenter;
    //    gredeLab.font = [UIFont boldSystemFontOfSize:16];
    //    [self.topRightIV addSubview:gredeLab];
    //
    //    [gredeLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.topRightIV.mas_top).offset(12);
    //        make.left.equalTo(self.topRightIV.mas_left).offset(21);
    //        make.width.offset(20);
    //        make.height.offset(20);
    //
    //    }];
    //
    //
    //    //点赞
    //    UILabel * goodLab = [[UILabel alloc]init];
    //    self.topRightGoodLab = goodLab;
    //
    //    //NSLog(@"self.topRightGoodStr%@",self.topRightGoodStr);
    //    goodLab.text = gredeLab.text =[NSString stringWithFormat:@"%@",self.topRightGoodStr];
    //    goodLab.textColor = [UIColor whiteColor];
    //    goodLab.textAlignment = NSTextAlignmentLeft;
    //    goodLab.font = [UIFont boldSystemFontOfSize:10];
    //    [self.topRightIV addSubview:goodLab];
    //
    //    [goodLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.topRightIV.mas_top).offset(15);
    //        make.right.equalTo(self.topRightIV.mas_right).offset(10);
    //        make.width.offset(50);
    //        make.height.offset(20);
    //
    //    }];
    
    
    //    UIButton *praisedNum = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-60, 0, 40, 40)];
    //    [praisedNum setBackgroundImage:[UIImage imageNamed:@"60"] forState:0];
    //    NSLog(@"%ld",(long)_topRightGoodStr);
    //
    //    [praisedNum setTitle:[NSString stringWithFormat:@"%@",self.topRightGoodStr] forState:0];
    //    [self.headView addSubview:praisedNum];
    
    
    
    //点击上传头像
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headIMGTap)];
    //    imageView.userInteractionEnabled = YES;
    //    [imageView addGestureRecognizer:tap];
    
    //详情
    //    UIButton * detailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    self.detailsBtn = detailsBtn;
    //
    //    [imageView addSubview:detailsBtn];
    //
    //    //    if (self.headImageStr.length) {
    //    //
    //    //
    //    //    }
    //    [detailsBtn setImage:[UIImage imageNamed:@"me_xq"] forState:UIControlStateNormal];
    //    [detailsBtn addTarget:self action:@selector(detailsBtnClickNext:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [detailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(imageView.mas_top).offset(15);
    //        make.left.equalTo(imageView.mas_left).offset(3);
    //        make.width.offset(80);
    //        make.height.offset(25);
    //
    //    }];
    
    
    
    
    
    
    
    //进度条
    //    HWProgressView *progressView = [[HWProgressView alloc] initWithFrame:CGRectMake(10, perfectLab.frame.origin.y+22, SCREEN_W-20, 15)];
    //
    //    [self.headView addSubview:progressView];
    //    self.progressView = progressView;
    //    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(perfectLab.mas_bottom).offset(2);
    //        make.left.equalTo(perfectLab.mas_left);
    //        make.width.offset(SCREEN_W-20);
    //        make.height.offset(15);
    //
    //    }];
    //
    //    self.progressView.progress = self.timerProgerss;
    //
    //    //[self addTimer];
    //
    //    if (self.headImageStr.length) {
    //
    //        [self mineCategory:160+(SCREEN_W-20)/1.35];
    //
    //    }else{
    //
    //        //[self mineCategory:370];
    //        [self mineCategory:160+(SCREEN_W-20)/1.35];
    //    }
    
    
}

#pragma  mark 上传图片
- (void)upDateHeadIcon:(UIImage *)photo{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         
                                                         @"text/html",
                                                         
                                                         @"image/jpeg",
                                                         
                                                         @"image/png",
                                                         
                                                         @"application/octet-stream",
                                                         
                                                         @"text/json",
                                                         
                                                         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval =10.f;
    
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
    [imageData writeToFile:fullPath atomically:NO];
    
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"image"];
    [dictT setObject:@"/usr/local/tomcat/webapps/" forKey:@"imageUploadPath"];
    //NSLog(@"dictT%@",dictT);
    [manager POST:kUrlPostImg parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"responseObject%@",dic);
        NSString * resultStr = dic[@"image"];
        self.headImageStr = resultStr;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)headIMGTap{
    
    __weak typeof(self) weakSelf = self;
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            
            self.headIV.image = image;
            [weakSelf upDateHeadIcon:image];
        }
        
    }];
}

#pragma mark - detailsBtnClick 详情
- (void)detailsBtnClickNext:(UIButton *)btn{
    
    SPNewMyProfileVC * profileVC= [[SPNewMyProfileVC alloc]init];
    profileVC.nickName = self.nickStr;
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileVC animated:YES];
}

#pragma mark - perfectBtnClick去完善按钮
- (void)perfectBtnClick{
    
    SPNewMyProfileVC * profileVC= [[SPNewMyProfileVC alloc]init];
    profileVC.nickName = self.nickStr;
//    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileVC animated:YES];
}

#pragma mark - 分类
- (void)mineCategory:(CGFloat )bottom{
    
    if (bottom>250) {
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, bottom+100);
        //bottom = 300;
    }else{
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 300);
        //总数
        //[self.titleBtnNumArr addObject:@0];
        self.titleBtnNumArr = [NSMutableArray arrayWithCapacity:0];
        [self.titleBtnNumArr addObject:@0];
        [self.titleBtnNumArr addObject:@0];
        [self.titleBtnNumArr addObject:@0];
        //新动态
        //[self.badgeNumArr addObject:@"0"];
        self.badgeNumArr = [NSMutableArray arrayWithCapacity:0];
        [self.badgeNumArr addObject:@"0"];
        [self.badgeNumArr addObject:@"0"];
        [self.badgeNumArr addObject:@"0"];
    }
    //@"me_r7_c2",
    NSArray * imageArr = @[@"me_r7_c7",@"wd_gz",@"me_r7_c14"];
    
    //NSLog(@"%@ %@",self.badgeNumArr,self.titleBtnNumArr);
    
    for (int i = 0; i<3; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (SCREEN_W/3),bottom+10, SCREEN_W/3-10,60);
        //[btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(mineCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = btn.width/2;
        //竖线
        if (i<2) {
            
            UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width+btn.frame.origin.x, btn.frame.origin.y+20, 1, btn.frame.size.height-40)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.headView addSubview:lineView];
        }
        
        //角标
        btn.badgeBgColor = KProgressColor;
        btn.badgeCenterOffset = CGPointMake(-35,+10);
        NSInteger value = [self.badgeNumArr[i] integerValue];
        [btn showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeNone];
        
        UIButton * btnLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLabel.frame = CGRectMake(btn.frame.origin.x+btn.frame.size.width/2-12.5, btn.frame.origin.y + btn.frame.size.height+3, 25, 25);
        [btnLabel setBackgroundImage:[UIImage imageNamed:@"me_r9_c4"] forState:UIControlStateNormal];
        
        [btnLabel setTitle:[self.titleBtnNumArr[i] stringValue] forState:UIControlStateNormal];
        
        btnLabel.selected = NO;
        [self.headView addSubview:btnLabel];
        [self.headView addSubview:btn];
        
    }
}
#pragma mark - mineCategoryBtnClick分类点击事件
- (void)mineCategoryBtnClick:(UIButton *)btn{
    
    if ([StorageUtil getId]) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
        if (btn.tag==1) {//我的技能
            //[dict setObject:@"FEED" forKey:@"type"];
            //[self getiNextVCWith:btn.tag];
            
        }else if (btn.tag==2) {
            
            //我的需求
            [dict setObject:@"DEMAND" forKey:@"type"];
        }else if (btn.tag==3) {
            
            //我的关注
            [dict setObject:@"FOLLOWED" forKey:@"type"];
            
        }else if (btn.tag==4) {
            
            //我的动态
            [dict setObject:@"FEED" forKey:@"type"];
            
        }else if (btn.tag==5) {
            
            //我的消息
            [dict setObject:@"MESSAGE" forKey:@"type"];
            
        }
        if (1<btn.tag&&btn.tag<5) {
            [[HttpRequest sharedClient]httpRequestPOST:ClearNewMessage parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                
                NSLog(@"%@",responseObject);
                
                [self getiNextVCWith:btn.tag];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }else{
            
            [self getiNextVCWith:btn.tag];
        }
        
        
    }else{
        
        [self tapGoLogin];
        
    }
    
}

#pragma mark - 分类跳转
- (void)getiNextVCWith:(NSInteger )typeInt{
    
    if (typeInt==1) {//我的技能
        
        SPLzsMySkillsVC * skillVC = [[SPLzsMySkillsVC alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:skillVC animated:YES];
        
    }else if (typeInt==2) {//我的需求
        
        SPMineNeededVC * needVC = [[SPMineNeededVC alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:needVC animated:YES];
        
        
    }else if (typeInt==3) {
        
        //我的关注
        SPLzsMyFocusViewController * reserveVC = [[SPLzsMyFocusViewController alloc]init];
        
//        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:reserveVC animated:YES];
        //[self presentViewController:reserveVC animated:YES completion:nil];
        
    }else if (typeInt==4) {
        
        SPProfileDynamicVC * dynamicVC = [[SPProfileDynamicVC alloc]init];
        dynamicVC.dontNeedBottom = YES;
        dynamicVC.code = [StorageUtil getCode];
//        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:dynamicVC animated:NO];
        
    }else if (typeInt==5) {
        
        //我的消息
        SPMyMessageViewController * messageVC = [[SPMyMessageViewController alloc]init];
        
//        self.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:messageVC animated:YES];
        
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        
        return self.titleArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==1) {
        return 10;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //    if (section==1) {
    //
    //        UIView *headerView = [[UIView alloc] init];
    //        headerView.backgroundColor = RGBCOLOR(250, 250, 250);
    //        return headerView;
    //    }
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = RGBCOLOR(250, 250, 250);
    return headerView;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * mineCell = @"mineCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
    if (indexPath.section==0) {
        
        cell.textLabel.text = @"我的钱包";
        cell.imageView.image = [UIImage imageNamed:@"wd_qb"];
    }else{
        
        cell.textLabel.text = self.titleArr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    if (isEmptyString([StorageUtil getCode])) {
    //        Toast(@"请先登录");
    //        return;
    //    }
    if (indexPath.section==0) {
        //我的钱包
        SPLzsMineWalletViewController * walletVC= [[SPLzsMineWalletViewController alloc]init];

        [self.navigationController pushViewController:walletVC animated:YES];
    }else{
        
        if (indexPath.row==0) {
            SPMyInterestVC * intrestVC = [[SPMyInterestVC alloc]init];
            intrestVC.formMyCenter =YES;

            [self.navigationController pushViewController:intrestVC animated:YES];
            
        }else if (indexPath.row ==1)
        {//认证
            
            SPMineIdentificationVC * identiVC = [[SPMineIdentificationVC alloc]init];
            
            [self.navigationController pushViewController:identiVC animated:YES];
            
        }else if (indexPath.row ==2)
        {
         
            [UIView animateWithDuration:0.4 animations:^{
                [self.view addSubview:self.shareView];
                
                self.shareView.shareUrl = @"http://www.smallzhuyue.com/";
                
                self.shareView.title = @"我是小猪约";
                
                self.shareView.subTitle =@"首个“技能社交”平台，用你的时间、兴趣、技能赚钱";
                
                self.shareView.shareImg = [UIImage imageNamed:@"app"];
                
                self.shareView.hidden = NO;
                self.shareView.originY = 0;
            }];
            
        }else if (indexPath.row ==3){
            
            
        }else if (indexPath.row ==4){
            
            
            
        }
    }
    
}
#pragma mark -  第三方分享
- (void)initShareOfThird{
    
    
}



#pragma mark - createNAV
- (void)createNAV{
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    //self.navigationController.navigationBar.translucent = YES;
    
    //self.extendedLayoutIncludesOpaqueBars = NO;
    
    //    self.titleLabel.textColor = TitleColor;
    //    self.titleLabel.text =@"个人中心";
    //    [self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
    //    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightButtonClick{
    
    //SPSPLzsEvaluateVC * evaluateVC = [[SPSPLzsEvaluateVC alloc]init];
    
    //[self.navigationController pushViewController:evaluateVC animated:YES];
    if ([StorageUtil getCode].length>0) {
        MineSetViewController * setVC = [[MineSetViewController alloc]init];
        
        [self.navigationController pushViewController:setVC animated:YES];
    }else{
        
        [self tapGoLogin];
        
    }
}

#pragma mark - lazyLoad

//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        //        _shareView.shareImg = self.headIV.image;
    }
    return _shareView;
}

- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 310)];
        _headView.backgroundColor = WC;
    }
    return _headView;
}

- (NSMutableArray *)titleBtnNumArr{
    
    if (!_titleBtnNumArr) {
        _titleBtnNumArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleBtnNumArr;
}

- (NSMutableArray *)badgeNumArr{
    
    if (!_badgeNumArr) {
        _badgeNumArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _badgeNumArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 进度条定时

- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    if (!(self.timerProgerss==0)) {
        _progressView.progress += 0.05;
    }
    
    if (_progressView.progress >= self.timerProgerss) {
        [self removeTimer];
        //NSLog(@"完成");
    }
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

@end
