//
//  SPFindPeopleVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPDepositView.h"
#import "SPFindPeopleVC.h"
#import "SPLzsGetMoneyVC.h"
#import "SPRechargeVC.h"
#import "SPMineNeededModel.h"
#import "SPLzsRadarViewController.h"
@interface SPFindPeopleVC ()<UITextViewDelegate>
@property (nonatomic,copy)NSString *bailRuleId;
@property(nonatomic,assign)BOOL bailEnough;
@property (strong, nonatomic)UILabel *placeHolder;
@property (strong, nonatomic)UIButton *commitButton;
@property (strong, nonatomic)UITextView *feedBackTextView;
@property (nonatomic,strong)SPDepositView *depositView;
@end

@implementation SPFindPeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WC;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initWithNav];
    [self initUI];
    //如果是再发一单，则赋值
    [self configForPublishAgain];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.depositView getMyWall];
}

#pragma  mark  如果是再发一单，则赋值

-(void)configForPublishAgain{
    
    if (self.publishAgain) {
        self.skillCategoryLab.text = self.needModel.skill;
        self.flashSwich.on = [self.needModel.flushFlag boolValue];
        self.feedBackTextView.text = self.needModel.content;
        self.placeHolder.hidden = YES;
    }
}

#pragma mark - initUI
- (void)initUI{
    UIScrollView *baseScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:baseScrollView];
    //技能类别
    self.skillCategoryLab  = [[UILabel alloc]init];
    [baseScrollView addSubview:self.skillCategoryLab];
    
    [self.skillCategoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.left.offset(15);
        make.width.offset(SCREEN_W - 50);
        make.height.offset(25);
        
    }];
    
    self.skillCategoryLab.text = [NSString stringWithFormat:@"技能类别: %@",self.skill];
    self.skillCategoryLab.textColor = [UIColor blackColor];
    self.skillCategoryLab.textAlignment = NSTextAlignmentLeft;
    self.skillCategoryLab.font = Font(15);
    
    //闪约
    self.flashDatingLab  = [[UILabel alloc]init];
    [baseScrollView addSubview:self.flashDatingLab];
    
    [self.flashDatingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.skillCategoryLab.mas_bottom).offset(20);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(25);
        
    }];
    
    self.flashDatingLab.text = [NSString stringWithFormat:@"是否闪约 (24小时内为闪约)"];
    self.flashDatingLab.textColor = RGBCOLOR(60, 61, 62);
    self.flashDatingLab.textAlignment = NSTextAlignmentLeft;
    self.flashDatingLab.font = Font(15);
    
    /*
     //2. create switch
     self.mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 70, 0, 0)];
     [self.view addSubview:self.mainSwitch];
     
     //缩小或者放大switch的size
     self.mainSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
     self.mainSwitch.layer.anchorPoint = CGPointMake(0, 0.3);
     
     //    self.mainSwitch.onImage = [UIImage imageNamed:@"on.png"];   //无效
     //    self.mainSwitch.offImage = [UIImage imageNamed:@"off.png"]; //无效
     
     //    self.mainSwitch.backgroundColor = [UIColor yellowColor];    //它是矩形的
     
     // 设置开关状态(默认是 关)
     //    self.mainSwitch.on = YES;
     [self.mainSwitch setOn:YES animated:true];  //animated
     
     //判断开关的状态
     if (self.mainSwitch.on) {
     NSLog(@"switch is on");
     } else {
     NSLog(@"switch is off");
     }
     
     //添加事件监听
     [self.mainSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
     
     //定制开关颜色UI
     //tintColor 关状态下的背景颜色
     self.mainSwitch.tintColor = [UIColor redColor];
     //onTintColor 开状态下的背景颜色
     self.mainSwitch.onTintColor = [UIColor yellowColor];
     //thumbTintColor 滑块的背景颜色
     self.mainSwitch.thumbTintColor = [UIColor blueColor];
     */
    self.flashSwich = [[UISwitch alloc]init];
    [baseScrollView addSubview:self.flashSwich];
    
    [self.flashSwich mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.flashDatingLab.mas_top).offset(-4);
        make.left.equalTo(self.flashDatingLab.mas_right).offset(20);
        make.width.offset(50);
        make.height.offset(20);
        
    }];
    
    [self.flashSwich setOn:NO animated:YES];
    
    [self.flashSwich addTarget:self action:@selector(flashSwichClick:) forControlEvents:UIControlEventValueChanged];
    self.flashSwich.onTintColor = RGBCOLOR(248, 27, 82);
    
    //需求描述
    self.needLab  = [[UILabel alloc]init];
    [baseScrollView addSubview:self.needLab];
    
    [self.needLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.flashDatingLab.mas_bottom).offset(30);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(25);
        
    }];
    
    self.needLab.text = [NSString stringWithFormat:@"需求描述"];
    self.needLab.textColor = RGBCOLOR(60, 61, 62);
    self.needLab.textAlignment = NSTextAlignmentLeft;
    self.needLab.font = Font(15);
    
    //输入框
    self.feedBackTextView = [[UITextView alloc]init];
    [baseScrollView addSubview:self.feedBackTextView];
    
    [self.feedBackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.needLab.mas_bottom).offset(20);
        make.left.equalTo(self.needLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(200);
    }];
    
    self.feedBackTextView.textColor = [UIColor blackColor];
    self.feedBackTextView.font = Font(13);
    self.feedBackTextView.clipsToBounds = YES;
    self.feedBackTextView.layer.borderColor = RGBCOLOR(192, 193, 194).CGColor;
    self.feedBackTextView.layer.borderWidth = 1.3;
    self.feedBackTextView.layer.cornerRadius = 15;
    self.feedBackTextView.keyboardType = UIKeyboardTypeDefault;
    self.feedBackTextView.contentMode = UIViewContentModeCenter;
    self.feedBackTextView.delegate = self;
    
    //站位
    self.placeHolder = [[UILabel alloc]init];
    
    [self.feedBackTextView addSubview:self.placeHolder];
    
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make)
    {
        
  make.top.equalTo(self.feedBackTextView.mas_top).offset(3);
  make.left.equalTo(self.feedBackTextView.mas_left).offset(5);
      make.width.offset(180);
      make.height.offset(25);
    }];
    self.placeHolder.userInteractionEnabled = NO;
    self.placeHolder.text = @"请详细说明你的需求";
    self.placeHolder.textColor = RGBCOLOR(198, 199, 200);
    self.placeHolder.textAlignment = NSTextAlignmentLeft;
    self.placeHolder.font = Font(13);
    
    WeakSelf;
    //保证金
    SPDepositView *depositView = [[SPDepositView alloc]initWithFeeType:FAITH_FEE];
    self.depositView = depositView;
    depositView.block = ^(NSString *type, NSString *deposit) {
        if ([type isEqualToString:@"保证金ID"])
        {
            self.bailEnough = YES;
            self.bailRuleId = deposit;
        }else if ([type isEqualToString:@"协议"])
        {
            
        }else if ([type isEqualToString:@"金额不够"])
        {
            self.bailEnough = NO;
        }
    };
        [baseScrollView addSubview:depositView];
        [depositView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.offset(SCREEN_W);
            make.top.equalTo(self.feedBackTextView.mas_bottom);
            if (kiPhone5) {
                make.height.offset(275);
            }else{
                make.height.offset(255);
            }
        }];
    
    //
    self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.commitButton.backgroundColor = [UIColor lightGrayColor];
    self.commitButton.backgroundColor = RGBCOLOR(249, 26, 82);
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    //self.commitButton.userInteractionEnabled = NO;
    
    [baseScrollView addSubview:self.commitButton];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    make.top.equalTo(depositView.mas_bottom).offset(10);
        make.left.offset(30);
        make.width.offset(SCREEN_W-60);
        make.height.offset(40);
        
    }];
    
    self.commitButton.clipsToBounds = YES;
    self.commitButton.layer.cornerRadius = 10;
    [self.commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    _star.show_star = level*20;
    //    //重新绘制
    //    [_star setNeedsDisplay];
    baseScrollView.contentSize = CGSizeMake(0, 800);
}

#pragma  mark  提示是否去充值

-(void)gotoRechargeTip{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"诚意金可以提升服务者对您的信任度\n支付诚意金后系统将通知服务者\n您的余额不足，快去充值吧" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self gotoRecharge];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma  mark  跳转到充值界面

-(void)gotoRecharge{
    SPRechargeVC *vc = [[SPRechargeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  commitButtonClick  提交按钮
- (void)commitButtonClick{
    if (isEmptyString(self.feedBackTextView.text))
    {
        Toast(@"请填写需求描述"); return;
    }
    
    //保证金不够
    if (!self.bailEnough) {
        [self gotoRechargeTip];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (self.publishAgain)
    {
        [dic setObject:self.needModel.skillCode forKey:@"code"];
        [dic setObject:self.needModel.skill forKey:@"propertyName"];
    }else
    {
        [dic setObject:self.code forKey:@"code"];
        [dic setObject:self.skill forKey:@"propertyName"];
    }
    
    [dic setObject:self.bailRuleId forKey:@"bailRuleId"];
    
    [dic setObject:[StorageUtil getCity] forKey:@"cityName"];
    [dic setObject:self.feedBackTextView.text forKey:@"content"];
    [dic setObject:[StorageUtil getCode] forKey:@"createBy"];
    //    是否闪约（0是1否）
    [dic setObject:self.flashSwich.on?@(0):@(1) forKey:@"flushFlag"];
    
    [dic setObject:[SPCommon getLoncationDic][@"lon"] forKey:@"sendx"];
    [dic setObject:[SPCommon getLoncationDic][@"lat"] forKey:@"sendy"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFindPeople parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        
        SPLzsRadarViewController *vc = [[SPLzsRadarViewController alloc]init];
        vc.idStr = responseObject[@"data"];
        [self.navigationController pushViewController:vc animated:YES];
        
//

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    
    self.placeHolder.hidden = YES;
 
    //实时显示字数
    //self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/100", (unsigned long)textView.text.length];
    //self.stirngLenghLabel.hidden = NO;
    //字数限制操作
    //    if (textView.text.length >= 100) {
    //
    //        textView.text = [textView.text substringToIndex:100];
    //        self.stirngLenghLabel.text = @"100/100";
    //        //self.stirngLenghLabel.textColor = RGBCOLOR(249, 26, 82);
    //
    //    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeHolder.hidden = NO;
    }
}

#pragma mark - flashSwichClick: 开关
- (void)flashSwichClick:(UISwitch *)swich{
    
    //开关
    if (swich.on) {
        
    }else{
        
        
    }
    
}

#pragma mark - initWithNav
- (void)initWithNav{
    
    self.titleLabel.text = @"找人服务";
    self.titleLabel.textColor = [UIColor blackColor];
    //[self.rightButton setTitle:@"评价" forState:UIControlStateNormal];
    //    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.feedBackTextView resignFirstResponder];
    //[self.phoneCodeTF resignFirstResponder];
    
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

