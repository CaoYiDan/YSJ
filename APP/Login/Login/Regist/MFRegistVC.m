 //
//  SPChangePhoneViewController.m
//  SmallPig
//


#import <CommonCrypto/CommonDigest.h>
#import <SMS_SDK/SMSSDK.h>
#import "MFSetPasswordVC.h"
#import "MFRegistVC.h"

@interface MFRegistVC ()
{
    
}
@property (nonatomic,strong)UILabel*phoneNumber;
@property (nonatomic,strong)UILabel * phoneCode;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property (nonatomic,copy)NSString * maStr;
@end

@implementation MFRegistVC

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - createUI

- (void)createUI{
    
    self.title= @"注册";
    
    _phoneNumber = [[UILabel alloc]init];
    
    _phoneNumber.text = @"手机号:";
    
    self.phoneNumber.textColor = KMainColor;
    
    [self.view addSubview:_phoneNumber];
    
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.offset(20);
        make.width.offset(80);
        make.height.offset(40);
    }];
    
    self.phoneTF = [[UITextField alloc]init];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.font = Font(14);
    self.phoneTF.textAlignment = NSTextAlignmentLeft;
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTF.placeholder = @"请输入11位手机号码";
//    self.phoneTF.text = [StorageUtil getUserName];
    [self.view addSubview:self.phoneTF];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.equalTo(_phoneNumber.mas_right).offset(5);
        make.width.offset(160);
        make.height.offset(40);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor hexColor:@"f2f2f2"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_phoneTF.mas_bottom).offset(1);
        make.right.offset(-10);
    }];
    
    UIView * phoneCodeView = [[UIView alloc]init];
    phoneCodeView.layer.cornerRadius = 8;
    phoneCodeView.layer.masksToBounds = YES;
    [self.view addSubview:phoneCodeView];
    
    [phoneCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneTF.mas_bottom).offset(20);
        make.left.offset(20);
        make.width.offset(kWindowW);
        make.height.offset(40);
    }];
    
    self.phoneCode = [[UILabel alloc]init];
    
    self.phoneCode.text = @"验证码:";
    self.phoneCode.textColor = KMainColor;
    [phoneCodeView addSubview:self.phoneCode];
    
    [self.phoneCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(0);
        make.left.equalTo(phoneCodeView.mas_left).offset(0);
        make.width.offset(80);
        make.height.offset(40);
    }];
    
    self.phoneCodeTF= [[UITextField alloc]init];
    self.phoneCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneCodeTF.font = Font(14);
    self.phoneCodeTF.textAlignment = NSTextAlignmentLeft;
    //self.phoneCodeTF.clearButtonMode =UITextFieldViewModeAlways;
    [phoneCodeView addSubview:self.phoneCodeTF];
    self.phoneCodeTF.placeholder = @"请输入验证码";
    [self.phoneCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(0);
        make.left.equalTo(self.phoneCode.mas_right).offset(5);
        make.width.offset(120);
        make.height.offset(40);
        
    }];
    
    UIButton * getMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getMaBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [getMaBtn setTitleColor:KMainColor forState:0];
    
    getMaBtn.layer.cornerRadius = 5;
    
    [getMaBtn addTarget:self action:@selector(getClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getMaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getMaBtn = getMaBtn;
    [phoneCodeView addSubview:getMaBtn];
    
    [getMaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneCodeView.mas_top).offset(5);
        make.left.equalTo(self.phoneCodeTF.mas_right).offset(10);
        make.width.offset(95);
        make.height.offset(30);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor =grayF2F2F2;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_phoneCode.mas_bottom).offset(1);
        make.right.offset(-10);
    }];
    
    UIButton *nextBtn = [[UIButton alloc]init];
    
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.left.offset(50);
        make.height.offset(48);
        make.top.equalTo(line2.mas_bottom).offset(40);
    }];
    line2.hidden = YES;
    phoneCodeView.hidden = YES;
}

#pragma mark - 获取验证码事件
- (void)getClicked:(UIButton *)btn{
    
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

#pragma mark - loginBtn登录按钮
- (void)nextClick{
    
    if ([self checkTel:self.phoneTF.text]) {
        MFSetPasswordVC *vc = [[MFSetPasswordVC alloc]init];
        vc.tel = self.phoneTF.text;
        vc.setOrFind = @"set";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        Toast(@"请输入正确的手机号码");
    }
    
    return;
    
    NSLog(@"%@,%@",self.phoneCode.text,self.phoneTF.text);
    WeakSelf;
    [SMSSDK commitVerificationCode:self.phoneCodeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            
        }
        else
        {
            // error
            Toast(@"验证失败");
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
    
    if (str.length != 11)
    {
        Toast(@"您输入的手机号码有误请重新输入");
        return NO;
    }
    return YES;
    
//    NSString *regex = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:str];
//
//    if (!isMatch)
//    {
//        Toast(@"您输入的手机号码有误请重新输入");
//        return NO;
//
//    }
//
//    else
//    {
//
//        return YES;
//    }
//
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
