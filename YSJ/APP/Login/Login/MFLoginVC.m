//
//  MFLoginVC.m
//  MoFang
//
//  Created by xujf on 2018/9/12.
//  Copyright © 2018年 ZBZX. All rights reserved.
//

#import "MFLoginVC.h"
#import "MFRegistVC.h"
#import "MFFindPasswordVC.h"
#import "YSJFastLoginVC.h"
@interface MFLoginVC ()

@end

@implementation MFLoginVC
{
    UITextField *_phoneTF;
    UITextField *_passwordTF;
    
    UIButton *_remberBtn;
    UIButton *_automicLoginBtn;
    UIScrollView *_scrollView;
}

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    if (YES) {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }
  
}

-(void)dealloc{
    
}


#pragma mark CustomDelegate

#pragma mark event response
-(void)remberClick{
    _remberBtn.selected = !_remberBtn.isSelected;
    
}

-(void)automicLoginClick{
    _automicLoginBtn.selected = !_automicLoginBtn.selected;
}

-(void)loginClick{
    
   
    
    if (isEmptyString(_phoneTF.text)) {
        Toast(@"请输入手机号");
        return;
    }
    
    if (isEmptyString(_passwordTF.text)) {
        Toast(@"请输入密码");
        return;
    }
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:_phoneTF.text forKey:@"phone"];
    [dic setObject:_passwordTF.text forKey:@"pswwword"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherBanner parameters:dic progress:nil
                                        sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                                            
                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                            
                                        }];
}

-(void)registClick{
    MFRegistVC *vc = [[MFRegistVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)fastLoginClick{
    YSJFastLoginVC *vc = [[YSJFastLoginVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)learnMoreClick{
    
}

-(void)back{
    
    MFRegistVC *vc = [[MFRegistVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark private methods

#pragma mark getters and setters

-(void)setUI{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(0, 700);
    
    
    UIButton *back = [FactoryUI createButtonWithFrame:CGRectMake(0, SafeAreaStateHeight, 66, 44) title:@"" titleColor:KBlackColor imageName:@"return" backgroundImageName:nil target:self selector:@selector(back)];
    [self.view addSubview:back];
    
    UIButton *rightItem = [FactoryUI createButtonWithFrame:CGRectMake(kWindowW-145, SafeAreaStateHeight, 140, 44) title:@"手机号快捷登录" titleColor:KWhiteColor imageName:@"" backgroundImageName:nil target:self selector:@selector(fastLoginClick)];
    rightItem.titleLabel.font = font(18);
    rightItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:rightItem];
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(16, imgH+SafeAreaStateHeight, kWindowW-2*16, 430)];
    centerView.backgroundColor = KWhiteColor;
    centerView.layer.cornerRadius = 8;
    centerView.clipsToBounds = YES;
    [SPCommon setShaowForView:centerView];
    [_scrollView addSubview:centerView];
    
    
    UILabel *welcomeLab = [FactoryUI createLabelWithFrame:CGRectZero text:@"欢迎登陆" textColor:KBlackColor font:[UIFont boldSystemFontOfSize:34]];
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

    _phoneTF = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"  请输入手机号码"];
    _phoneTF.layer.cornerRadius = 4;
    _phoneTF.clipsToBounds = YES;
//    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTF.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [centerView addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLab);
        make.right.offset(-34);
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
    
    _passwordTF = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:@"  请输入密码"];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.layer.cornerRadius = 4;
    _passwordTF.clipsToBounds = YES;
    [centerView addSubview:_passwordTF];
//    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTF.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [centerView addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLab);
        make.right.offset(-34);
        make.height.offset(40);
        make.top.equalTo(passwordLab.mas_bottom).offset(10);
    }];
    
   
   
    _remberBtn = [FactoryUI createButtonWithtitle:@" 记住密码" titleColor:gray999999 imageName:@"xuanzhong0" backgroundImageName:nil target:self selector:@selector(remberClick)];
    [_remberBtn setImage:[UIImage imageNamed:@"choose1"] forState:UIControlStateSelected];
    [centerView addSubview:_remberBtn];



//    [_remberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(welcomeLab);
//        make.width.offset(80);
//        make.height.offset(40);
//    make.top.equalTo(_passwordTF.mas_bottom).offset(10);
//    }];
//
//    _automicLoginBtn = [FactoryUI createButtonWithtitle:@" 自动登录" titleColor:gray999999 imageName:@"xuanzhong0" backgroundImageName:nil target:self selector:@selector(automicLoginClick)];
//    [centerView addSubview:_automicLoginBtn];
//    [_automicLoginBtn setImage:[UIImage imageNamed:@"choose1"] forState:UIControlStateSelected];
//    [_automicLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_remberBtn.mas_right).offset(20);
//        make.width.offset(100);
//        make.height.offset(40);
//        make.top.equalTo(_passwordTF.mas_bottom).offset(10);
//    }];

    


    UIButton *fastLoginBtn = [FactoryUI createButtonWithtitle:@"手机号快捷登录" titleColor:gray999999 imageName:nil backgroundImageName:nil target:self selector:@selector(fastLoginClick)];
    [centerView addSubview:fastLoginBtn];
    [fastLoginBtn setTitleColor:[UIColor hexColor:@"262628"] forState:0];
    fastLoginBtn.titleLabel.font = font(15);
    [fastLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.offset(-34);
        make.height.offset(21);
        make.top.equalTo(_passwordTF.mas_bottom).offset(27);
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
        make.top.equalTo(fastLoginBtn.mas_bottom).offset(41);
    }];

//    NSString *registStr = @"没有账号？立即注册";
//
//    UIButton *regist = [FactoryUI createButtonWithtitle:registStr titleColor:KMainColor imageName:nil backgroundImageName:nil target:self selector:@selector(registClick)];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",registStr]];
//
//    [str addAttribute:NSForegroundColorAttributeName value:gray999999 range:NSMakeRange(0,5)];
//    [regist setAttributedTitle:str forState:UIControlStateNormal];
//    [centerView addSubview:regist];
//    [regist mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.height.offset(60);
//        make.bottom.offset(-10);
//    }];

//    UIButton *learnMoreBtn = [FactoryUI createButtonWithtitle:@"了解更多" titleColor:gray999999 imageName:nil backgroundImageName:nil target:self selector:@selector(learnMoreClick)];
//    [centerView addSubview:learnMoreBtn];
//    [learnMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(0);
//        make.width.offset(100);
//        make.height.offset(60);
//        make.bottom.offset(-10);
//    }];
}
-(void)nextClick{
    
    if (![self checkTel:_phoneTF.text]) {
        
        return;
    }
    
    if (isEmptyString(_passwordTF.text)) {
        Toast(@"请输入密码");
        return;
    }
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:_phoneTF.text forKey:@"phone"];
    [dic setObject:_passwordTF.text forKey:@"password"];
  
    [[HttpRequest sharedClient]httpRequestPOST:YLogin parameters:dic progress:nil
     
        sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            [StorageUtil saveId:responseObject[@"token"]];
            [StorageUtil saveNickName:responseObject[@"nickname"]];
            
            [StorageUtil saveRole:responseObject[@"role"]];
            [StorageUtil savePhoto:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,responseObject[@"photo"]]];
            [self.navigationController dismissViewControllerAnimated:yellowEE9900 completion:nil];
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
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
@end
