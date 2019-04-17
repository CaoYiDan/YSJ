//
//  SPChangePhoneViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "MFSetPasswordVC.h"

@interface MFSetPasswordVC ()

@property (nonatomic,strong)UILabel*phoneNumber;
@property (nonatomic,strong)UILabel *phoneNumberLab;

@property (nonatomic,strong)UITextField * firstPasswordTF;
@property (nonatomic,strong)UITextField * secondPasswordTF;

@end

@implementation MFSetPasswordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - createUI
- (void)createUI{
    
    UILabel *titleLab = [[UILabel alloc]init];
    [self.view addSubview:titleLab];
    titleLab.text = @"设置密码";
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
//        make.width.offset(200);
        make.height.offset(100);
        make.top.equalTo(self.view).offset(0);
    }];
    
    _phoneNumberLab = [[UILabel alloc]init];
    
    _phoneNumberLab.text = @"您的手机号";
    
    self.phoneNumberLab.textColor = KBlackColor;
    
    [self.view addSubview:_phoneNumberLab];
    
    [_phoneNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(120);
        make.left.offset(20);
        make.height.offset(40);
    }];
    
    _phoneNumber = [[UILabel alloc]init];
    
    _phoneNumber.text = self.tel;
    
    self.phoneNumber.textColor = KMainColor;
    
    [self.view addSubview:_phoneNumber];
    
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(120);
        make.left.equalTo(_phoneNumber.mas_right).offset(10);
        make.width.offset(140);
        make.height.offset(40);
    }];
    
    self.firstPasswordTF = [[UITextField alloc]init];
//    self.firstPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    self.firstPasswordTF.font = Font(14);
    self.firstPasswordTF.textAlignment = NSTextAlignmentLeft;
    self.firstPasswordTF.clearButtonMode = UITextFieldViewModeAlways;
    self.firstPasswordTF.placeholder = @"请输入密码(6-16位字母,数字或符号)";
    //    self.firstPasswordTF.text = [StorageUtil getUserName];
    [self.view addSubview:self.firstPasswordTF];
    
    [self.firstPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneNumberLab.bottom).offset(20);
    make.left.equalTo(_phoneNumberLab).offset(0);
        make.right.offset(-10);
        make.height.offset(40);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = grayF2F2F2;
    [self.view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_firstPasswordTF.bottom).offset(1);
        make.right.offset(-10);
    }];
    
    self.secondPasswordTF= [[UITextField alloc]init];
//    self.secondPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.secondPasswordTF.font = Font(14);
    self.secondPasswordTF.textAlignment = NSTextAlignmentLeft;
    //self.secondPasswordTF.clearButtonMode =UITextFieldViewModeAlways;
    [self.view addSubview:self.secondPasswordTF];
    
    self.secondPasswordTF.placeholder = @"请再次输入密码";
     self.firstPasswordTF.secureTextEntry = YES;
    self.secondPasswordTF.secureTextEntry = YES;
    [self.secondPasswordTF mas_makeConstraints:^(MASConstraintMaker *make){
        
make.top.equalTo(_firstPasswordTF.bottom).offset(20);
     make.left.equalTo(_phoneNumberLab).offset(0);
        make.right.offset(-10);
        make.height.offset(40);
    }];
    
    
//    UIImageView *rightLockImg = [[UIImageView alloc]init];
//    rightLockImg.image = [UIImage imageNamed:@"login_code_in_png"];
//    [self.firstPasswordTF addSubview:rightLockImg];
//    [rightLockImg makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-15);
//        make.width.offset(20);
//        make.height.offset(20);
//        make.top.offset(0);
//    }];
    
//    UIImageView *rightLockImg2 = [[UIImageView alloc]init];
//    rightLockImg2.image = [UIImage imageNamed:@"login_code_in_png"];
//    [self.secondPasswordTF addSubview:rightLockImg2];
//    [rightLockImg2 makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-15);
//        make.width.offset(20);
//        make.height.offset(20);
//        make.top.offset(0);
//    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = grayF2F2F2;
    [self.view addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.offset(1);
        make.bottom.equalTo(self->_secondPasswordTF.bottom).offset(1);
        make.right.offset(-10);
    }];
    
    UIButton *nextBtn = [[UIButton alloc]init];
    nextBtn.titleLabel.font = Font(15);
    [self.view addSubview:nextBtn];
    [nextBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.offset(-50);
        make.height.offset(48);
        make.top.equalTo(line2.bottom).offset(40);
    }];
}


/**
 注册成功后，再给后台发送一个祖册时间的请求。（鸡肋）
 */
-(void)postUserRegistTime{
//    [[HttpRequest sharedClient]postWithUrl:KRegisterTime body:@{@"phone":[StorageUtil getUserPhone],@"time":[Common getRegistTimes].mutableCopy} success:^(NSDictionary *response) {
//        Toast(@"注册成功");
//    } failure:^(NSError *error) {
//
//    }];
}
#pragma mark -提交
- (void)commitClicked:(UIButton *  )btn{
    
    if (isEmptyString(self.firstPasswordTF.text)) {
        Toast(@"请输入密码");
        return;
    }
    
    if ([self.firstPasswordTF.text isEqualToString:self.secondPasswordTF.text]) {
       
    }else{
        Toast(@"俩次输入密码不同");
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.firstPasswordTF resignFirstResponder];
    
    [self.secondPasswordTF resignFirstResponder];
    
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
