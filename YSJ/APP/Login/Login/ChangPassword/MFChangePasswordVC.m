//
//  SPChangePhoneViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "MFSetPasswordVC.h"
#import "MFChangePasswordVC.h"
#import <SMS_SDK/SMSSDK.h>
@interface MFChangePasswordVC ()
{
}
@property (nonatomic,strong)UILabel*phoneNumber;
@property (nonatomic,strong)UILabel * phoneCode;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property (nonatomic,copy)NSString * maStr;
@end

@implementation MFChangePasswordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
//    self.title= @"修改密码";
    UILabel *titleLab = [[UILabel alloc]init];
    [self.view addSubview:titleLab];
    titleLab.text = @"验证手机号";
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
//        make.width.offset(200);
        make.height.offset(100);
        make.top.equalTo(self.view).offset(0);
    }];
    
    _phoneNumber = [[UILabel alloc]init];
    
    _phoneNumber.text = @"手机号:";
    
    self.phoneNumber.textColor = KBlackColor;
    
    [self.view addSubview:_phoneNumber];
    
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(120);
        make.left.offset(kMargin);
//        make.width.offset(80);
        make.height.offset(40);
    }];
    
    self.phoneTF = [[UITextField alloc]init];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.font = Font(14);
    self.phoneTF.textAlignment = NSTextAlignmentLeft;
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTF.placeholder = @"请输入11位手机号";
//    self.phoneTF.text = [StorageUtil getUserPhone];
    [self.view addSubview:self.phoneTF];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(120);
        make.left.equalTo(_phoneNumber.mas_right).offset(5);
        make.width.offset(160);
        make.height.offset(40);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = grayF2F2F2;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_phoneTF.bottom).offset(1);
        make.right.offset(-10);
    }];
    
    UIView * phoneCodeView = [[UIView alloc]init];
    phoneCodeView.layer.cornerRadius = 8;
    phoneCodeView.layer.masksToBounds = YES;
    [self.view addSubview:phoneCodeView];
    
    [phoneCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_phoneTF.bottom).offset(20);
        make.left.offset(12);
        make.width.offset(kWindowW);
        make.height.offset(40);
    }];
    
    self.phoneCode = [[UILabel alloc]init];
    
    self.phoneCode.text = @"验证码:";
    self.phoneCode.textColor = KBlackColor;
    [phoneCodeView addSubview:self.phoneCode];
    self.phoneCode.frame = CGRectMake(0, 0, 80, 40);
    
    //设置优先级
    [self.phoneCode setContentHuggingPriority:UILayoutPriorityRequired
                                      forAxis:UILayoutConstraintAxisHorizontal];
    
    
    self.phoneCodeTF= [[UITextField alloc]init];
    self.phoneCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneCodeTF.placeholder = @"请输入验证码";
    self.phoneCodeTF.font = Font(14);
    self.phoneCodeTF.textAlignment = NSTextAlignmentLeft;
   
    [phoneCodeView addSubview:self.phoneCodeTF];
    
    [self.phoneCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(0);
        make.left.equalTo(self.phoneCode.mas_right).offset(5);
        make.width.offset(120);
        make.height.offset(40);
        
    }];
    
    UIButton * getMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getMaBtn setTitle:@" 发送验证码 " forState:UIControlStateNormal];
    [getMaBtn setTitleColor:[UIColor grayColor] forState:0];
    getMaBtn.titleLabel.font = Font(12);
    getMaBtn.backgroundColor = gray999999;
    getMaBtn.layer.cornerRadius = 5;
    
    [getMaBtn addTarget:self action:@selector(getClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.getMaBtn = getMaBtn;
    [phoneCodeView addSubview:getMaBtn];
    
    [getMaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    make.top.equalTo(phoneCodeView.mas_top).offset(5);
        make.left.equalTo(self.phoneCodeTF.mas_right).offset(10);
        make.height.offset(30);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = grayF2F2F2;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_phoneCode.bottom).offset(1);
        make.right.offset(-10);
    }];
    
    UIButton *nextBtn = [[UIButton alloc]init];
    nextBtn.titleLabel.font = Font(15);
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.offset(-50);
        make.height.offset(42);
        make.top.equalTo(line2.bottom).offset(40);
    }];
}

#pragma mark - loginBtn登录按钮
- (void)nextClick{
    
   
    
    [SMSSDK commitVerificationCode:self.phoneCodeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            MFSetPasswordVC *vc = [[MFSetPasswordVC alloc]init];
            vc.tel = self.phoneTF.text;
            vc.setOrFind = @"reset";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            // error
            Toast(@"验证失败");
        }
    }];
    
}


#pragma mark - 获取验证码事件
- (void)getClicked:(UIButton *  )btn{
    WeakSelf;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTF.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            [weakSelf openCountdown];
        }
        else
        {
            // error
        }
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
        
        Toast(@"手机号不能为空");
        
        return NO;
        
    }
    
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


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.phoneTF resignFirstResponder];
    [self.phoneCodeTF resignFirstResponder];
    
}
- (NSString *)md5WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
