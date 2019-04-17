//
//  SPChangePhoneViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "MFLoginVC.h"
#import <CommonCrypto/CommonDigest.h>
#import <SMS_SDK/SMSSDK.h>
#import "MFSetPasswordVC.h"
#import "YSJFastLoginVC.h"

@interface YSJFastLoginVC ()
{
    
}
@property (nonatomic,strong)UILabel*phoneNumber;
@property (nonatomic,strong)UILabel * phoneCode;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property (nonatomic,copy)NSString * maStr;
@end

@implementation YSJFastLoginVC
{
    UIScrollView *_scrollView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self createUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - createUI

- (void)createUI{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(0, 700);
    
    
    UIButton *back = [FactoryUI createButtonWithFrame:CGRectMake(0, SafeAreaStateHeight, 66, 44) title:@"" titleColor:KBlackColor imageName:@"return" backgroundImageName:nil target:self selector:@selector(back)];
    [self.view addSubview:back];
    
    
    UIButton *rightItem = [FactoryUI createButtonWithFrame:CGRectMake(kWindowW-135, SafeAreaStateHeight, 120, 44) title:@"账号密码登录" titleColor:KWhiteColor imageName:@"" backgroundImageName:nil target:self selector:@selector(accountLoginClick)];
    rightItem.titleLabel.font = font(18);
    rightItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:rightItem];
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(16, imgH+SafeAreaStateHeight, kWindowW-2*16, 440)];
    centerView.backgroundColor = KWhiteColor;
    centerView.layer.cornerRadius = 8;
    centerView.clipsToBounds = YES;
    [SPCommon setShaowForView:centerView];
    [_scrollView addSubview:centerView];
    
    
    UILabel *welcomeLab = [FactoryUI createLabelWithFrame:CGRectZero text:@"手机号快捷登录" textColor:KBlackColor font:[UIFont boldSystemFontOfSize:34]];
    welcomeLab.textAlignment =NSTextAlignmentLeft;
    [centerView addSubview:welcomeLab];
    [welcomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(34);
        make.size.offset(CGSizeMake(320, 48));
        make.top.offset(24);
    }];
    
    
    UILabel *phoneLab = [FactoryUI createLabelWithFrame:CGRectZero text:@"手机号" textColor:gray999999 font:font(15)];
    phoneLab.textAlignment =NSTextAlignmentLeft;
    [centerView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(34);
        make.size.offset(CGSizeMake(320, 21));
        make.top.equalTo(welcomeLab.mas_bottom).offset(31);
    }];
    
    UIButton * getMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getMaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getMaBtn.layer.cornerRadius = 4;
    getMaBtn.clipsToBounds = YES;
    getMaBtn.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [getMaBtn addTarget:self action:@selector(getClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getMaBtn setTitleColor:KMainColor forState:0];
    getMaBtn.titleLabel.font = font(14);
    self.getMaBtn = getMaBtn;
    [centerView addSubview:getMaBtn];
    
    [getMaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneLab.mas_bottom).offset(10);
        make.right.offset(-34);
        make.width.offset(95);
        make.height.offset(40);
    }];
    
    _phoneTF = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"  请输入手机号码"];
    _phoneTF.layer.cornerRadius = 4;
    _phoneTF.clipsToBounds = YES;
    //    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTF.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [centerView addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLab);
        make.right.equalTo(getMaBtn.mas_left).offset(10);
        make.height.offset(40);
        make.top.equalTo(phoneLab.mas_bottom).offset(10);
    }];
    
    
    UILabel *passwordLab = [FactoryUI createLabelWithFrame:CGRectZero text:@"密码" textColor:gray999999 font:font(15)];
    passwordLab.textAlignment =NSTextAlignmentLeft;
    [centerView addSubview:passwordLab];
    [passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(34);
        make.size.offset(CGSizeMake(320, 21));
        make.top.equalTo(_phoneTF.mas_bottom).offset(28);
    }];
    
    _phoneCodeTF= [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"  请输入验证码"];
    _phoneCodeTF.secureTextEntry = YES;
    _phoneCodeTF.layer.cornerRadius = 4;
    _phoneCodeTF.clipsToBounds = YES;
    [centerView addSubview:_phoneCodeTF];
    //    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneCodeTF.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [centerView addSubview:_phoneCodeTF];
    [_phoneCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLab);
        make.right.offset(-34);
        make.height.offset(40);
        make.top.equalTo(passwordLab.mas_bottom).offset(10);
    }];
    
    UIButton *tip = [FactoryUI createButtonWithtitle:@"未注册过的手机将自动创建为艺术加账号" titleColor:black666666 imageName:@"xuanzhong0" backgroundImageName:nil target:self selector:@selector(remberClick)];
    tip.userInteractionEnabled  = NO;
    [centerView addSubview:tip];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLab);
        
        make.height.offset(40);
        make.top.equalTo(_phoneCodeTF.mas_bottom).offset(7);
    }];
    
    //    _automicLoginBtn = [FactoryUI createButtonWithtitle:@" 自动登录" titleColor:gray999999 imageName:@"xuanzhong0" backgroundImageName:nil target:self selector:@selector(automicLoginClick)];
    //    [centerView addSubview:_automicLoginBtn];
    //    [_automicLoginBtn setImage:[UIImage imageNamed:@"choose1"] forState:UIControlStateSelected];
    //    [_automicLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_remberBtn.mas_right).offset(20);
    //        make.width.offset(100);
    //        make.height.offset(40);
    //        make.top.equalTo(_passwordTF.mas_bottom).offset(10);
    //    }];
    
    
    UIButton *accountLoginBtn = [FactoryUI createButtonWithtitle:@"账号密码登录" titleColor:gray999999 imageName:nil backgroundImageName:nil target:self selector:@selector(accountLoginClick)];
    [centerView addSubview:accountLoginBtn];
    [accountLoginBtn setTitleColor:[UIColor hexColor:@"262628"] forState:0];
    accountLoginBtn.titleLabel.font = font(15);
    [accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-34);
        make.height.offset(21);
        make.top.equalTo(_phoneCodeTF.mas_bottom).offset(50);
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    [centerView addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginbg"] forState:0];
    [loginBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 4;
    loginBtn.clipsToBounds = YES;
    loginBtn.titleLabel.font=Font(16);
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(34);
        make.right.offset(-34);
        make.height.offset(48);
        make.top.equalTo(accountLoginBtn.mas_bottom).offset(31);
    }];
    
}

#pragma mark - 获取验证码事件
- (void)getClicked:(UIButton *)btn{
    
    if ([self checkTel:self.phoneTF.text]) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTF.text zone:@"86"  result:^(NSError *error) {
            
            if (!error)
            {
                // 请求成功
                [self openCountdown];
            }
            else
            {
                Toast(@"出错了，请重试");
                NSLog(@"%@",error);
                // error
            }
        }];
    }
}

#pragma mark - 登录点击

- (void)nextClick{
    
    
    
    if (![self checkTel:self.phoneTF.text]) {
        return;
    }
    
    if (isEmptyString(self.phoneCodeTF.text)) {
        Toast(@"请输入验证码");
        return;
    }
    WeakSelf;
    
    [SMSSDK commitVerificationCode:self.phoneCodeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            [weakSelf postLogin];
        }
        else
        {
            // error
            Toast(@"验证失败");
        }
    }];
    
}

-(void)postLogin{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:_phoneTF.text forKey:@"phone"];
    [dic setObject:[StorageUtil getUserLon] forKey:@"longitude"];
    [dic setObject:[StorageUtil getUserLat] forKey:@"latitude"];
    [[HttpRequest sharedClient]httpRequestPOST:YRegister parameters:dic progress:nil
    sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [StorageUtil saveId:responseObject[@"token"]];
        
        [StorageUtil saveNickName:responseObject[@"nickname"]];
        
        [StorageUtil saveRole:responseObject[@"role"]];
        
        [StorageUtil savePhoto:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,responseObject[@"photo"]]];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark -  开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.getMaBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                
                self.getMaBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getMaBtn setTitle:[NSString stringWithFormat:@"发送(%.2ds)", seconds] forState:UIControlStateNormal];
                
                self.getMaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 判断手机号是不是有效
- (BOOL)checkTel:(NSString *)str
{
    
    NSString *regex = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        Toast(@"您输入的手机号码有误请重新输入");
        return NO;
        
    }
    
    else
    {
        
        return YES;
    }
    
}

-(void)back{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.phoneTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
}

-(void)accountLoginClick{
    
    MFLoginVC *vc = [[MFLoginVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
