//
//  RegisterViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "SPKitExample.h"
#import "SPLoginProtocolVCViewController.h"

@interface RegisterViewController ()
{
    
    LabelAndImage * _phoneNumber;
    
}

@property (nonatomic,strong)LabelAndImage * phoneCode;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property (nonatomic,copy)NSString * maStr;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"dl2"];
    [self.view insertSubview:imageView atIndex:0];
    [self createUI];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
    //dl_r1_c2 dl_r3_c1@3x dl_r5_c3@2x
}

#pragma mark - backClick
- (void)backClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - createUI
- (void)createUI{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 20, 40, 40);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIView * phoneView = [[UIView alloc]init];
    phoneView.backgroundColor = AlphaBack;
    phoneView.layer.cornerRadius = 8;
    phoneView.layer.masksToBounds = YES;
    [self.view addSubview:phoneView];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(SCREEN_H/2);
        make.left.offset(SCREEN_W/2-130);
        make.width.offset(260);
        make.height.offset(40);
    }];
    
    _phoneNumber = [[LabelAndImage alloc]init];
    _phoneNumber.imageType = -3;
    [_phoneNumber setLabelText:@"手机号" WithColor:WC];
    [_phoneNumber setImageView:@"dl_r1_c2"];
    
    [phoneView addSubview:_phoneNumber];
    
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneView.mas_top).offset(10);
        make.left.equalTo(phoneView.mas_left).offset(10);
        make.width.offset(80);
        make.height.offset(20);
    }];
    
    self.phoneTF = [[UITextField alloc]init];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.textColor = WC;
    self.phoneTF.font = Font(14);
    self.phoneTF.textAlignment = NSTextAlignmentLeft;
    [phoneView addSubview:self.phoneTF];
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneView.mas_top).offset(10);
        make.left.equalTo(_phoneNumber.mas_right).offset(5);
        make.width.offset(160);
        make.height.offset(20);
        
        
    }];
    
    
    UIView * phoneCodeView = [[UIView alloc]init];
    phoneCodeView.layer.backgroundColor = AlphaBack.CGColor;
    phoneCodeView.layer.cornerRadius = 8;
    phoneCodeView.layer.masksToBounds = YES;
    [self.view addSubview:phoneCodeView];
    
    [phoneCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneView.mas_bottom).offset(20);
        make.left.offset(SCREEN_W/2-130);
        make.width.offset(260);
        make.height.offset(40);
        
        
    }];
    
    self.phoneCode = [[LabelAndImage alloc]init];
    self.phoneCode.imageType = -3;
    [self.phoneCode setLabelText:@"验证码" WithColor:WC];
    [self.phoneCode setImageView:@"dl_r3_c1"];
    
    [phoneCodeView addSubview:self.phoneCode];
    
    [self.phoneCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(10);
        make.left.equalTo(phoneCodeView.mas_left).offset(10);
        make.width.offset(80);
        make.height.offset(20);
    }];
    
    self.phoneCodeTF= [[UITextField alloc]init];
    self.phoneCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneCodeTF.textColor = WC;
    self.phoneCodeTF.font = Font(14);
    self.phoneCodeTF.textAlignment = NSTextAlignmentLeft;
    [phoneCodeView addSubview:self.phoneCodeTF];
    
    [self.phoneCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(10);
        make.left.equalTo(self.phoneCode.mas_right).offset(5);
        make.width.offset(60);
        make.height.offset(20);
        
    }];
    
    UIButton * getMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getMaBtn setTitle:@"获取校验码" forState:UIControlStateNormal];
    [getMaBtn addTarget:self action:@selector(getClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getMaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getMaBtn = getMaBtn;
    [phoneCodeView addSubview:getMaBtn];
    
    [getMaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(10);
        make.left.equalTo(self.phoneCodeTF.mas_right).offset(10);
        make.width.offset(95);
        make.height.offset(20);
        
        
    }];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"dl_r5_c3"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_bottom).offset(40);
        make.left.offset(SCREEN_W/2-90);
        make.width.offset(180);
        make.height.offset(40);
        
        
    }];
    
    UILabel * agreeLabel = [[UILabel alloc]init];
    agreeLabel.font = [UIFont systemFontOfSize:13];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNext)];
    [agreeLabel addGestureRecognizer:tap];
    agreeLabel.userInteractionEnabled = YES;
    agreeLabel.textAlignment = NSTextAlignmentLeft;
    agreeLabel.text = @"登录即表示接受 《小猪约使用协议》";
    agreeLabel.textColor = [UIColor whiteColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:agreeLabel.text];
    //NSRange daryGray = NSMakeRange(0,[[noteStr string] rangeOfString:@" "].location);
    //[noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:daryGray];
    [noteStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange([[noteStr string] rangeOfString:@"小"].location,7)];
    [agreeLabel setAttributedText:noteStr] ;
    [agreeLabel sizeToFit];
    agreeLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_bottom).offset(10);
        make.left.equalTo(phoneCodeView.mas_left);
        make.width.offset(260);
        make.height.offset(20);
        
        
    }];

    
    
}

#pragma mark - tapNext
- (void)tapNext{
    
    SPLoginProtocolVCViewController*vc=[[SPLoginProtocolVCViewController alloc]init];
    vc.titleStr=@"小猪约协议";
    //[self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - loginBtn登录按钮
- (void)loginBtn:(UIButton *)btn{
    
    if (![self checkTel:self.phoneTF.text]) {
        Toast(@"请输入正确的手机号");
        return;
    }
    
    if (self.phoneCodeTF.text.length !=0) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.phoneTF.text forKey:@"mobile"];
        [dic setObject:@"xzbj" forKey:@"appDomain"];
        [dic setObject:@"xzbj_login" forKey:@"serviceDomain"];
        [dic setObject:self.phoneCodeTF.text forKey:@"verifyCode"];
        //[dic setObject:@"" forKey:self.phoneTF.text];
        
        [[HttpRequest sharedClient]httpRequestPOST:kUrlLogin parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            //存储用户信息
            
            if ([responseObject[@"status"] integerValue]==200) {
                
                [StorageUtil saveId:responseObject[@"data"][@"id"]];
                [StorageUtil saveCode:responseObject[@"data"][@"code"]];
                [StorageUtil saveNickName:responseObject[@"data"][@"nickName"]];
                [StorageUtil saveIm_password:responseObject[@"data"][@"imPasswd"]];
                [StorageUtil saveFirstLogin:responseObject[@"data"][@"firstLogin"]];
                [StorageUtil saveUserMobile:responseObject[@"data"][@"mobile"]];
                NSLog(@"%@",responseObject[@"data"][@"firstLogin"]);
                [self loginIM];//登录IM
                [self nextController:[StorageUtil getFirstLogin]];
                
            }else{
                
                Toast(@"登录失败");
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            Toast(@"登录失败");
        }];
    }else{
        Toast(@"请输入验证码");
    }
}

//登录IM
-(void)loginIM{
    
    //应用登陆成功后，调用SDK
    [[SPKitExample sharedInstance]callThisAfterISVAccountLoginSuccessWithYWLoginId:[StorageUtil getCode] passWord:[StorageUtil getIm_password] preloginedBlock:nil successBlock:^{
        
    } failedBlock:^(NSError *aError) {
        
    }];
    
}

#pragma mark - 登录跳转
- (void)nextController:(NSString* )firstLogin{
    
    NSLog(@"%d",[StorageUtil getFirstLogin]);
    
    if (firstLogin) {
        
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

#pragma mark - 获取验证码事件
- (void)getClicked:(UIButton * )btn{
    
    NSLog(@"点击了获取验证码");
    if ([self checkTel:self.phoneTF.text]) {
        NSDictionary * dic = @{@"toMobile":self.phoneTF.text,@"appDomain":@"xzbj",@"serviceDomain":@"xzbj_login"};
        [[HttpRequest sharedClient]httpRequestPOST:MessageSend parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            //NSString * str  ;
            if ([responseObject[@"success"] integerValue] ==1) {
                Toast(@"获取成功");
                [self openCountdown];
                
            }else{
                
                Toast(@"获取失败");
            }
            //[self registerPhone:str];
            NSLog(@"responseObject%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
        
    }else{
        
        Toast(@"手机号输入有误请重新输入");
    }
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
        
    }
    
    // NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
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
        
    }
    
    else
    {
        
        return YES;
    }
    
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.phoneTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
    
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
