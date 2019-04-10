//
//  SPChangePhoneViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChangePhoneViewController.h"
#import "SPKitExample.h"
@interface SPChangePhoneViewController ()
{
    
    LabelAndImage * _phoneNumber;
    
}

@property (nonatomic,strong)LabelAndImage * phoneCode;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property (nonatomic,copy)NSString * maStr;
@end

@implementation SPChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self createUI];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

#pragma mark - createUI
- (void)createUI{
    
    self.titleLabel.text= @"修改手机号";
    
    UIView * phoneView = [[UIView alloc]init];
    phoneView.backgroundColor = AlphaBack;
    phoneView.layer.cornerRadius = 8;
    phoneView.layer.masksToBounds = YES;
    [self.view addSubview:phoneView];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
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
    self.phoneTF.font = font(14);
    self.phoneTF.textAlignment = NSTextAlignmentLeft;
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTF.text = [StorageUtil getUserMobile];
    [phoneView addSubview:self.phoneTF];
    
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
    self.phoneCodeTF.font = font(14);
    self.phoneCodeTF.textAlignment = NSTextAlignmentLeft;
    //self.phoneCodeTF.clearButtonMode =UITextFieldViewModeAlways;
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
    [loginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
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
    
    
}
#pragma mark - loginBtn登录按钮
- (void)loginBtn:(UIButton *)btn{
    
    if ([self checkTel:self.phoneTF.text] &&self.phoneCodeTF.text.length !=0) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.phoneTF.text forKey:@"toMobile"];
        [dic setObject:@"xzbj" forKey:@"appDomain"];
        [dic setObject:@"xzbj_login" forKey:@"serviceDomain"];
        [dic setObject:self.phoneCodeTF.text forKey:@"verifyCode"];
        //[dic setObject:@"" forKey:self.phoneTF.text];
        
        [[HttpRequest sharedClient]httpRequestPOST:CheckVerifyCodeUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            //存储用户信息

            //Toast(@"修改成功");
            [self changePhone];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else{
        
        Toast(@"有空未填");
    }
    
    
}
#pragma mark - changePhone修改手机号接口
- (void)changePhone{

    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    [dic setObject:self.phoneTF.text forKey:@"mobile"];
    //[dic setObject:@"xzbj_login" forKey:@"serviceDomain"];
    //[dic setObject:self.phoneCodeTF.text forKey:@"verifyCode"];
    //[dic setObject:@"" forKey:self.phoneTF.text];
    //[self nextController];
    NSLog(@"dic%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:ChangeMobileUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSLog(@"修改接口responseObject%@",responseObject);
        
        if ([responseObject[@"status"]integerValue]==200) {
            
            Toast(@"修改成功");
            
            [self nextController];
            
        }else{
            
            Toast(responseObject[@"error"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - 登录跳转
- (void)nextController{
    
    //NSArray * vcArr = self.navigationController.viewControllers;
    
    //[self.navigationController popToViewController:vcArr[2] animated:YES];
    NSLog(@"点击了退出登录");
    [StorageUtil saveId:nil];
    [StorageUtil saveCode:nil];
    [StorageUtil saveUserMobile:nil];
    [StorageUtil saveFirstLogin:nil];
    [StorageUtil saveIm_password:nil];
    [StorageUtil saveNickName:nil];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"loginStatus"];
    //self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    //IM退出
    [[SPKitExample sharedInstance]callThisBeforeISVAccountLogout];
    
}

#pragma mark - 获取验证码事件
- (void)getClicked:(UIButton *  )btn{
    
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

@end
