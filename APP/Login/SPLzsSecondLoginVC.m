//
//  SPLzsSecondLoginVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/11/1.
//  Copyright © 2017年 李智帅. All rights reserved.

#import "SPLzsSecondLoginVC.h"
#import "SPPerfectViewController.h"
#import "SPKitExample.h"
#import "MyTabbarController.h"
#import "SPLoginProtocolVCViewController.h"

@interface SPLzsSecondLoginVC ()
@property(nonatomic,strong) MyTabbarController * myTabbar;
@end

@implementation SPLzsSecondLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self createLoginView];
    // Do any additional setup after loading the view.
}

#pragma mark -  开始登录页
- (void)createLoginView{
    
    //登陆页
    self.loginView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.loginView.backgroundColor = WC;
    [self.view addSubview:self.loginView];
    //[self.myTabbar.view addSubview:self.loginView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.loginView addGestureRecognizer:tapGestureRecognizer];
    
    UIView * view = [[UIView alloc]initWithFrame:SCREEN_B];
    view.backgroundColor = WC;
    [self.loginView addSubview:view];
    //logo图
    UIImageView * logoIV = [[UIImageView alloc]init];
    
    [self.loginView addSubview:logoIV];
    
    [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(75+20);
        make.left.offset(SCREEN_W/2-40);
        make.width.offset(80);
        make.height.offset(80);
        
    }];
    
    logoIV.image = [UIImage imageNamed:@"dl_logo"];
    
    //获取验证码
    UIButton * getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginView addSubview:getCodeBtn];
    self.getMaBtn = getCodeBtn;
    getCodeBtn.titleLabel.font = Font(12);
    [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"dl_yzm"] forState:UIControlStateNormal];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(logoIV.mas_bottom).offset(30);
        make.right.offset(-25);
        make.width.offset(120);
        make.height.offset(40);
        
    }];
    
    //手机号
    UITextField * phoneTF = [[UITextField alloc]init];
    self.phoneTF = phoneTF;
    //self.phoneTF.text = @"15822651613";
    [self.loginView addSubview:phoneTF];
    
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(logoIV.mas_bottom).offset(40);
        make.left.offset(25);
        make.height.offset(30);
        
    }];
    
    phoneTF.placeholder = @"请输入您的手机号";
    
    //第一条
    UIView * firstLineView = [[UIView alloc]init];
    
    [self.loginView addSubview:firstLineView];
    
    [firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(getCodeBtn.mas_bottom).offset(10);
        make.left.offset(25);
        make.width.offset(SCREEN_W-50);
        make.height.offset(1);
    }];
    
    firstLineView.backgroundColor = RGBA(234, 235, 236, 1);
    
    //输入验证码
    UITextField * codeTF = [[UITextField alloc]init];
    self.phoneCodeTF = codeTF;
    //self.phoneCodeTF.text = @"651613";
    [self.loginView addSubview:codeTF];
    
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
make.top.equalTo(firstLineView.mas_bottom).offset(10);
        make.left.offset(25);
        make.height.offset(30);
        
    }];
    
    codeTF.placeholder = @"请输入验证码";
    
    //第二条
    UIView * secondLineView = [[UIView alloc]init];
    
    [self.loginView addSubview:secondLineView];
    
    [secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeTF.mas_bottom).offset(10);
        make.left.offset(25);
        make.width.offset(SCREEN_W-50);
        make.height.offset(1);
    }];
    
    secondLineView.backgroundColor = RGBA(234, 235, 236, 1);
    
    //登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.loginView addSubview:loginBtn];
    
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"dl_"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(secondLineView.mas_bottom).offset(35);
        make.left.offset(25);
        make.width.offset(SCREEN_W-50);
        make.height.offset(50);
        
    }];
    
    UILabel * agreeLabel = [[UILabel alloc]init];
    agreeLabel.font = [UIFont systemFontOfSize:13];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNext)];
    [agreeLabel addGestureRecognizer:tap];
    agreeLabel.userInteractionEnabled = YES;
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    agreeLabel.text = @"登录即表示接受 《小猪约使用协议》";
    agreeLabel.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:agreeLabel.text];
    NSRange daryGray = NSMakeRange(0,[[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:RGBA(139, 140, 142, 1) range:daryGray];
    [noteStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange([[noteStr string] rangeOfString:@"小"].location,7)];
    [agreeLabel setAttributedText:noteStr] ;
    [agreeLabel sizeToFit];
    agreeLabel.adjustsFontSizeToFitWidth = YES;
    [self.loginView addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.left.equalTo(loginBtn.mas_left);
        make.width.offset(SCREEN_W-50);
        make.height.offset(20);
        
    }];
    
//    UILabel * textLab = [[UILabel alloc]init];
//    [self.loginView addSubview:textLab];
//
//    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(agreeLabel.mas_bottom).offset(45);
//        make.left.offset(SCREEN_W/2-40);
//        make.width.offset(80);
//        make.height.offset(15);
//
//    }];
//
//    textLab.font = Font(13);
//    textLab.textColor = RGBA(106, 107, 108, 1);
//    textLab.text = @"其他方式登录";
//    textLab.textAlignment = NSTextAlignmentCenter;
//
//    //微信
//    UIButton * wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.loginView addSubview:wechatBtn];
//
//    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(textLab.mas_bottom).offset(20);
//        make.left.offset(60);
//        make.height.offset(40);
//        make.width.offset(40);
//
//    }];
//
//    [wechatBtn setImage:[UIImage imageNamed:@"sf_wx"] forState:UIControlStateNormal];
//
//    [wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    //
//    UILabel * wechatLab = [[UILabel alloc]init];
//    wechatLab.textAlignment = NSTextAlignmentCenter;
//    [self.loginView addSubview:wechatLab];
//
//    [wechatLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(wechatBtn.mas_bottom).offset(20);
//        make.left.equalTo(wechatBtn);
//        make.width.offset(40);
//        make.height.offset(20);
//    }];
//    wechatLab.text = @"微信";
//    wechatLab.font = Font(13);
//    wechatLab.textColor = RGBA(106, 107, 108, 1);
//
//    //qq
//    UIButton * qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.loginView addSubview:qqBtn];
//
//    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(textLab.mas_bottom).offset(20);
//        make.left.equalTo(wechatBtn.mas_right).offset((SCREEN_W-240)/2);
//        make.height.offset(40);
//        make.width.offset(40);
//
//    }];
//
//    [qqBtn setImage:[UIImage imageNamed:@"sf_qq"] forState:UIControlStateNormal];
//
//    [qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
//
//
//    //
//    UILabel * qqLab = [[UILabel alloc]init];
//    qqLab.textAlignment = NSTextAlignmentCenter;
//    [self.loginView addSubview:qqLab];
//
//    [qqLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(qqBtn.mas_bottom).offset(20);
//        make.left.equalTo(qqBtn);
//        make.width.offset(40);
//        make.height.offset(20);
//    }];
//    qqLab.text = @"QQ";
//    qqLab.font = Font(13);
//    qqLab.textColor = RGBA(106, 107, 108, 1);
//
//    //wb
//    UIButton * weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.loginView addSubview:weiboBtn];
//
//    [weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(textLab.mas_bottom).offset(20);
//        make.left.equalTo(qqBtn.mas_right).offset((SCREEN_W-240)/2);
//        make.height.offset(40);
//        make.width.offset(40);
//
//    }];
//
//    [weiboBtn setImage:[UIImage imageNamed:@"sf_wb"] forState:UIControlStateNormal];
//
//    [weiboBtn addTarget:self action:@selector(weiboBtnClick) forControlEvents:UIControlEventTouchUpInside];
//
//    //
//    UILabel * wbLab = [[UILabel alloc]init];
//    wbLab.textAlignment = NSTextAlignmentCenter;
//    [self.loginView addSubview:wbLab];
//
//    [wbLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weiboBtn.mas_bottom).offset(20);
//        make.left.equalTo(weiboBtn);
//        make.width.offset(40);
//        make.height.offset(20);
//    }];
//    wbLab.text = @"微博";
//    wbLab.font = Font(13);
//    wbLab.textColor = RGBA(106, 107, 108, 1);
//
    
}

#pragma mark - weiboBtnClick
- (void)weiboBtnClick{
    
    
}

#pragma mark - qqBtnClick
- (void)qqBtnClick{
    
    //qq
}

#pragma mark - wechatBtnClick 第三方登录
- (void)wechatBtnClick{
    //微信
}

#pragma mark - loginBtnClick 登录按钮

- (void)loginBtnClick:(UIButton *)btn{
    
    if (![self checkTel:self.phoneTF.text]) {
        //Toast(@"请输入正确的手机号");
        return;
    }else{
        
        if (self.phoneCodeTF.text.length !=0) {
            showMBP;
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            [dic setObject:self.phoneTF.text forKey:@"mobile"];
            [dic setObject:@"xzbj" forKey:@"appDomain"];
            [dic setObject:@"xzbj_login" forKey:@"serviceDomain"];
            [dic setObject:self.phoneCodeTF.text forKey:@"verifyCode"];
            //[dic setObject:@"" forKey:self.phoneTF.text];
            
            [[HttpRequest sharedClient]httpRequestPOST:kUrlLogin parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                hidenMBP;
                NSLog(@"delegate登录%@",responseObject);
                //存储用户信息
                
                if ([responseObject[@"status"] integerValue]==200) {
                    
                    [StorageUtil saveId:responseObject[@"data"][@"id"]];
                    [StorageUtil saveCode:responseObject[@"data"][@"code"]];
                    [StorageUtil saveNickName:responseObject[@"data"][@"nickName"]];
                    [StorageUtil saveIm_password:responseObject[@"data"][@"imPasswd"]];
                    [StorageUtil saveFirstLogin:responseObject[@"data"][@"firstLogin"]];
                    [StorageUtil saveUserMobile:responseObject[@"data"][@"mobile"]];
                   [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"firstLogin"] forKey:@"firstStatus"]; NSLog(@"%@",responseObject[@"data"][@"firstLogin"]);
                    [self loginIM];//登录IM
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"loginStatus"];
                    //[self.delegate changeToHome];
                    //[self.loginView removeFromSuperview];
                    //[self removeFromSuperview];
                    
                    [self nextController:responseObject[@"data"][@"firstLogin"]];
                    
                    
                }else{
                    
                    Toast(@"登录失败");
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                hidenMBP;
                Toast(@"登录失败");
            }];
        }else{
            Toast(@"请输入验证码");
        }
    }
}

//登录IM
-(void)loginIM{
    
    if (isEmptyString([StorageUtil getId])) return;
    //应用登陆成功后，调用SDK
    [[SPKitExample sharedInstance]callThisAfterISVAccountLoginSuccessWithYWLoginId:[StorageUtil getCode] passWord:[StorageUtil getIm_password] preloginedBlock:nil successBlock:^{
        
    } failedBlock:^(NSError *aError) {
        
    }];
}

#pragma mark - 登录跳转
- (void)nextController:(NSString * )firstLogin{
    
    NSLog(@"%d",[StorageUtil getFirstLogin]);
    
    if ([firstLogin intValue]) {
        
        SPPerfectViewController * sexvc = [[SPPerfectViewController alloc]init];
        [self.navigationController pushViewController:sexvc animated:YES];
//        [self presentViewController:sexvc animated:YES completion:nil];
    }else{
        
//        self.myTabbar = [[MyTabbarController alloc]init];
//        
//            (([UIApplication sharedApplication].delegate)).window.rootViewController = self.myTabbar;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
    //    if (self.fromMine) {
    //
    //        //if (firstLogin) {
    //        self.firstLogin = [firstLogin integerValue];
    //        LoginViewController * loginVC = [[LoginViewController alloc]init];
    //        loginVC.firstLogin = self.firstLogin;
    //        [self.navigationController pushViewController:loginVC animated:NO];
    //
    //        //        }else{
    //        //
    //        //            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"forHome"];
    //        //
    //        //            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //        //        }
    //
    //
    //    }else{
    //
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //    }
    
}

#pragma mark - getCodeBtnClick 获取验证码

- (void)getCodeBtnClick:(UIButton * )btn{
    
    NSLog(@"点击了获取验证码");
    if ([self checkTel:self.phoneTF.text]) {
        NSDictionary * dic = @{@"toMobile":self.phoneTF.text,@"appDomain":@"xzbj",@"serviceDomain":@"xzbj_login"};
        [[HttpRequest sharedClient]httpRequestPOST:MessageSend parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            //NSString * str  ;
            if ([responseObject[@"success"] integerValue] ==1) {
                Toast(@"发送成功");
                [self openGetCodeCountdown];
                
            }else{
                
                Toast(@"获取失败");
            }
            //[self registerPhone:str];
            NSLog(@"responseObject%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
        
    }else{
        
        //Toast(@"手机号输入有误请重新输入");
    }
}

#pragma mark -  开启获取验证码倒计时效果
-(void)openGetCodeCountdown{
    
    __block NSInteger time = 89; //倒计时时间
    
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
            
            int seconds = time % 90;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getMaBtn setTitle:[NSString stringWithFormat:@"发送中(%.2ds)", seconds] forState:UIControlStateNormal];
                //[self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
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
    if ([str length] == 0)
    {
        
        //                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号不能为空" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        //
        //                [alert show];
        Toast(@"手机号不能为空");
        
        return NO;
        
    }else{
        
        NSString *regex = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:str];
        
        if (!isMatch)
        {
            
            //                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入有效的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //
            //                [alert show];
            Toast(@"您输入的手机号码有误请重新输入");
            
            return NO;
            
        }else
        {
            
            return YES;
        }
    }
    
    // NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.phoneTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
    
}



#pragma mark - tapNext协议点击
- (void)tapNext{
    SPLoginProtocolVCViewController*vc=[[SPLoginProtocolVCViewController alloc]init];
    vc.titleStr=@"小猪约协议";
    //[self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
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
