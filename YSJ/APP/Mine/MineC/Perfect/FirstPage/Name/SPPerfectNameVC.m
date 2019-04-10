//
//  SPPerfectNameVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPerfectNameVC.h"
#import "CMInputView.h"
#import "AddressViewController.h"
#import "SPMyKungFuVC.h"
#import "SPBaseNavigationController.h"
@interface SPPerfectNameVC ()<UITextFieldDelegate>
//@property (nonatomic,strong) UIButton *coverView;//覆盖的View
@end

@implementation SPPerfectNameVC
{

    UITextField *_formTextFiled;
    CMInputView *_nameTextFiled;
    UITextField *_oftenTextFiled;
    
    UITextField *_currentTextFiled;//当前编辑的textFiled
}

#pragma  mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_name"]];
    
    [self createUI];
    
    //.检测键盘的弹出和隐藏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choseCity:) name:NotificationChoseCity object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//创建UI
-(void)createUI{
    
    CGFloat wid = SCREEN_W-50-60;
    CGFloat height = 50;
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 50, 70)];
    [leftImg setImage:[UIImage imageNamed:@"grxx4_pic2"]];
    [self.view addSubview:leftImg];
    
    //Form
    UITextField *formTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_W-wid-30, 170-height, wid , height)];
    formTextFiled.placeholder = @"From - 请选择";
    formTextFiled.alpha = 0.6;
    formTextFiled.delegate = self;
    _formTextFiled = formTextFiled;
    formTextFiled.layer.cornerRadius = 15;
    formTextFiled.clipsToBounds = YES;
    formTextFiled.layer.borderColor = [UIColor grayColor].CGColor;
    formTextFiled.layer.borderWidth=1;
    formTextFiled.font = [UIFont boldSystemFontOfSize:20];
    [formTextFiled setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    formTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:formTextFiled];
    
    //nameBtn
    UIButton *nameImg = [[UIButton alloc]initWithFrame:CGRectMake(0 ,0, 200, 200)];
    nameImg.center = self.view.center;
    [nameImg addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [nameImg setImage:[UIImage imageNamed:@"grxx4_pic3"] forState:0];
    [self.view addSubview:nameImg];
    
   CMInputView * nameTextFiled= [[CMInputView alloc]initWithFrame:CGRectMake(0, 0, nameImg.frameWidth, 40)];
    nameTextFiled.center = nameImg.center;
    _nameTextFiled = nameTextFiled;
    //昵称
//    UITextView*nameTextFiled = [[UITextView alloc]initWithFrame:CGRectMake(0, nameImg.frameHeight/2-25, nameImg.frameWidth, 50)];
//    _nameTextFiled = nameTextFiled;
    nameTextFiled.textAlignment = NSTextAlignmentCenter;
    nameTextFiled.alpha = 0.6;
     nameTextFiled.font = [UIFont boldSystemFontOfSize:18];
    nameTextFiled.placeholder = @"请修改昵称";
    [nameTextFiled setPlaceTextAlight];
    [self.view addSubview:nameTextFiled];
    WeakSelf;
    [nameTextFiled textValueDidChanged:^(NSString *text, CGFloat textHeight) {
        nameTextFiled.frameHeight =textHeight;
    }];
    
    //Often
    UITextField *oftenTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(30, SCREEN_H2-150, wid , height)];
    oftenTextFiled.placeholder = @"Often -常出没的地方";
    _oftenTextFiled = oftenTextFiled;
    oftenTextFiled.delegate = self;
    oftenTextFiled.alpha = 0.6;
    oftenTextFiled.layer.cornerRadius = 15;
    oftenTextFiled.layer.borderWidth = 1;
    oftenTextFiled.layer.borderColor =[UIColor grayColor].CGColor;
    oftenTextFiled.clipsToBounds= YES;
    oftenTextFiled.font = [UIFont boldSystemFontOfSize:20];
    [oftenTextFiled setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    oftenTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:oftenTextFiled];
    
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-20-50,oftenTextFiled.mj_origin.y, 50, 70)];
    [rightImg setImage:[UIImage imageNamed:@"grxx4_pic4"]];
    [self.view addSubview:rightImg];
    
    if (self.formMyCenter) {
        formTextFiled.text = self.user.beFrom;
        _oftenTextFiled.text = self.user.haunt;
        _nameTextFiled.text = self.user.nickName;
        [_nameTextFiled textDidChange2];
    }else{
    //获取之前存储的用户信息,给信息赋值
    NSDictionary *userDict = [StorageUtil getUserDict];
    NSLog(@"%@",userDict);
    NSLog(@"%@",userDict[@"nickName"]);
    if (!isEmptyString(userDict[@"beFrom"])) {
        formTextFiled.text = userDict[@"beFrom"];
    }
    
    if (!isEmptyString(userDict[@"haunt"])) {
        _oftenTextFiled.text = userDict[@"haunt"];
    }
    
    if (!isEmptyString(userDict[@"nickName"]) && self.formMyCenter) {
        
        _nameTextFiled.text = userDict[@"nickName"];
        
        [_nameTextFiled textDidChange2];
    }
    }
}

//#pragma mark - 通知事件
//
//- (void)keyboardWillShow:(NSNotification *)notification {
//    //获取键盘高度，在不同设备上，以及中英文下是不同的
//    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    
////    self.coverView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H2-kbHeight);
////    
//}
//
////-(UIButton *)coverView{
////    if (!_coverView) {
////        _coverView =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 150)];
////        [self.coverView addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchDown];
////        self.coverView .backgroundColor = [UIColor clearColor];
////        [self.view addSubview:self.coverView];
////    }
////    return _coverView;
////}
//
/////键盘消失事件
//- (void)keyboardWillHide:(NSNotification *)notify {
//    
//}
//
//选择了城市
-(void)choseCity:(NSNotification *)notify{
    _currentTextFiled.text = notify.object;
}

#pragma  mark - textfiled delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _formTextFiled) {
          _currentTextFiled = textField;
        AddressViewController *addressVC = [[AddressViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:addressVC];
        [self presentViewController:naVC animated:YES completion:nil];
    }
}

#pragma  mark - action

//-(void)tap1{
//
//    [_nameTextFiled resignFirstResponder];
////    [UIView animateWithDuration:0.1 animations:^{
////        self.coverView.originY = -SCREEN_H2;
////    }];
//}

-(void)click{
    [_nameTextFiled becomeFirstResponder];
}

-(void)next{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
//    if (!isEmptyString(_formTextFiled.text)) {
        [dict setObject:_formTextFiled.text forKey:@"beFrom"];
//    }
    
//    if (!isEmptyString(_nameTextFiled.text)) {
        [dict setObject:_nameTextFiled.text forKey:@"nickName"];
//    }
    
//    if (!isEmptyString(_oftenTextFiled.text)) {
        [dict setObject:_oftenTextFiled.text forKey:@"haunt"];
//    }
    
    [self postMessage:dict pushToVC:NSStringFromClass([SPMyKungFuVC class])];
}

-(void)jump{
    [self pushViewCotnroller:NSStringFromClass([SPMyKungFuVC class])];
}

@end
