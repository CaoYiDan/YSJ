//
//  SPLzsGetMoneyVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsGetMoneyVC.h"
#import "SPPublishModel.h"
#import "SPDepositView.h"
#import "SPRechargeVC.h"
#import "SPPublishFinishPopView.h"
#import "SPSkillWorkExp.h"
#import "IQKeyboardManager.h"
#import "SPExperienceForMakeMonery.h"
@interface SPLzsGetMoneyVC ()<UITextViewDelegate>
@property (nonatomic,strong)UILabel * placeHolder;//介绍占位符
@property (nonatomic,strong)UILabel * placeHolder2;//优势占位符
@property (nonatomic,strong)UILabel * placeHolder3;//备注占位符
@property (nonatomic,strong)UIButton * commitButton;//下一步
@property (nonatomic,strong)UIButton * hourMoneyBtn;//元/小时
@property (nonatomic,strong)UITextField * hourMoneyTF;//元/小时输入框
@property (nonatomic,strong)UIButton * timeMoneyBtn;//元/次
@property (nonatomic,strong)UITextField * timeMoneyTF;//元/次输入框
@property (nonatomic,strong)NSMutableArray * btnArr;//星期数组
@property (nonatomic,strong)NSMutableArray * seletedBtnArr;//已选择星期数组
@property (nonatomic,strong)SPPublishModel *publishModel;
//保证金规则ID
@property(nonatomic,copy)NSString *bailRuleId;
@property(nonatomic,assign)BOOL bailEnough;
@property (nonatomic,strong)SPDepositView *depositView;

@end

@implementation SPLzsGetMoneyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    self.view.backgroundColor = WC;
    
    [self getSkillMessage];
    
    [self initWithNav];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.depositView getMyWall];
}

#pragma  mark  请求数据

-(void)getSkillMessage{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    [dic setObject:self.skillCode forKey:@"skillCode"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeQuery parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"大声的%@",responseObject);
        self.publishModel = [SPPublishModel mj_objectWithKeyValues:responseObject[@"data"]];
        if (isEmptyString(responseObject[@"data"])) {
            self.publishModel = [[SPPublishModel alloc]init];
        }
        [self config];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark  根据请求的数据配置信息

-(void)config{
    
    if (isEmptyString(self.publishModel.skillCode)) {
        self.publishModel.priceUnit = @"HOUR";
        self.publishModel.skillCode = self.skillCode;
        return;
    }
    
    NSDictionary *weekDic = @{@"MON":@"10",@"TUE":@"11",@"WED":@"12",@"THU":@"13",@"FRI":@"14",@"SAT":@"15",@"SUN":@"16"};
    NSArray *weekArr = [self.publishModel.serTime componentsSeparatedByString:@","];
    for (NSString *week in weekArr) {
        UIButton *weekBtn = (UIButton *)[self.view viewWithTag:[weekDic[week] integerValue]];
        weekBtn.selected = YES;
        [weekBtn setBackgroundColor:RGBCOLOR(249, 26, 82)];
        [weekBtn setTitleColor:WC forState:UIControlStateSelected];
        weekBtn.layer.borderWidth = 0;
    }
    
    for (UIButton *btn  in self.btnArr) {
        NSLog(@"%ld",(long)btn.tag);
        
    }
    //    TIME("TIME","次"),
    //    //天
    //    DAY("DAY","天"),
    //    //小时
    //    HOUR("HOUR","小时");
    if ([self.publishModel.priceUnit isEqualToString:@"TIME"]) {
        self.timeMoneyTF.text = self.publishModel.price;
        self.timeMoneyBtn.selected = YES;
        self.hourMoneyBtn.selected = NO;
        self.hourMoneyTF.userInteractionEnabled = NO;
    }else if ([self.publishModel.priceUnit isEqualToString:@"HOUR"]){
        self.hourMoneyTF.text = self.publishModel.price;
        self.hourMoneyBtn.selected = YES;
        self.timeMoneyBtn.selected = NO;
        self.timeMoneyTF.userInteractionEnabled = NO;
    }else{
        self.publishModel.priceUnit = @"HOUR";
    }
    
    //服务介绍
    if (!isEmptyString(self.publishModel.serIntro)) {
        self.serveInfoTV.text = self.publishModel.serIntro;
        self.placeHolder.hidden = YES;
    }
    
    //服务优势
    if (!isEmptyString(self.publishModel.serIntro)) {
        self.serveGoodTV.text = self.publishModel.serContent;
        self.placeHolder2.hidden = YES;
    }
    
    //备注
    if (!isEmptyString(self.publishModel.serIntro)) {
        self.serveRemarkTV.text = self.publishModel.serRemark;
        self.placeHolder3.hidden = YES;
    }
}

//-(void)addTapGestureRecognizer{
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
//}

#pragma mark - initUI
- (void)initUI{
    
    UIScrollView * scrollViewMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    scrollViewMain.backgroundColor = WC;
    [self.view addSubview:scrollViewMain];
    
    //技能类别
    self.skillCategoryLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.skillCategoryLab];
    
    [self.skillCategoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.offset(15);
        make.width.offset(SCREEN_W - 50);
        make.height.offset(20);
    }];
    
    self.skillCategoryLab.text = [NSString stringWithFormat:@"技能类别: %@",self.skill];
    self.skillCategoryLab.textColor = [UIColor blackColor];
    self.skillCategoryLab.textAlignment = NSTextAlignmentLeft;
    self.skillCategoryLab.font = font(15);
    
    //服务价格
    self.servePriceLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.servePriceLab];
    
    [self.servePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.skillCategoryLab.mas_bottom).offset(30);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(20);
        
    }];
    
    self.servePriceLab.text = [NSString stringWithFormat:@"服务价格"];
    self.servePriceLab.textColor = RGBCOLOR(60, 61, 62);
    self.servePriceLab.textAlignment = NSTextAlignmentLeft;
    self.servePriceLab.font = Font(15);
    
    //价格选择
    self.hourMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollViewMain addSubview:self.hourMoneyBtn];
    
    [self.hourMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.servePriceLab.mas_bottom).offset(10);
        make.left.offset(25);
        make.width.offset(20);
        make.height.offset(20);
    }];
    
    [self.hourMoneyBtn setImage:[UIImage imageNamed:@"fa_xx_djw"] forState:UIControlStateNormal];
    self.hourMoneyBtn.selected = YES;
    self.hourMoneyBtn.tag = 1;
    [self.hourMoneyBtn setImage:[UIImage imageNamed:@"fb_xx_dj"] forState:UIControlStateSelected];
    [self.hourMoneyBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //输入框
    self.hourMoneyTF = [[UITextField alloc]init];
    [scrollViewMain addSubview:self.hourMoneyTF];
    
    [self.hourMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.servePriceLab.mas_bottom).offset(10);
        make.left.equalTo(self.hourMoneyBtn.mas_right).offset(5);
        make.width.offset(60);
        make.height.offset(20);
        
    }];
    
    self.hourMoneyTF.clipsToBounds = YES;
    self.hourMoneyTF.layer.borderColor = RGBCOLOR(197, 198, 199).CGColor;
    self.hourMoneyTF.layer.borderWidth = 1;
    self.hourMoneyTF.layer.cornerRadius = 6;
    self.hourMoneyTF.keyboardType = UIKeyboardTypeNumberPad;
    
    //Lab
    UILabel * hourMoneyLab = [[UILabel alloc]init];
    [scrollViewMain addSubview:hourMoneyLab];
    
    [hourMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.hourMoneyTF.mas_top);
        make.left.equalTo(self.hourMoneyTF.mas_right).offset(10);
        make.width.offset(50);
        make.height.offset(20);
        
    }];
    
    hourMoneyLab.text = @"元/小时";
    hourMoneyLab.font = Font(13);
    hourMoneyLab.textColor = RGBCOLOR(60, 61, 62);
    hourMoneyLab.textAlignment = NSTextAlignmentLeft;
    
    //价格元/次
    self.timeMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollViewMain addSubview:self.timeMoneyBtn];
    
    [self.timeMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.servePriceLab.mas_bottom).offset(10);
        make.left.equalTo(hourMoneyLab.mas_right).offset(10);
        make.width.offset(20);
        make.height.offset(20);
    }];
    //fb_xx_dj
    [self.timeMoneyBtn setImage:[UIImage imageNamed:@"fa_xx_djw"] forState:UIControlStateNormal];
    [self.timeMoneyBtn setImage:[UIImage imageNamed:@"fb_xx_dj"] forState:UIControlStateSelected];
    self.timeMoneyBtn.tag = 2;
    [self.timeMoneyBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //输入框
    self.timeMoneyTF = [[UITextField alloc]init];
    [scrollViewMain addSubview:self.timeMoneyTF];
    
    [self.timeMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.servePriceLab.mas_bottom).offset(10);
        make.left.equalTo(self.timeMoneyBtn.mas_right).offset(5);
        make.width.offset(60);
        make.height.offset(20);
        
    }];
    
    self.timeMoneyTF.textAlignment = NSTextAlignmentCenter;
    self.hourMoneyTF.textAlignment = NSTextAlignmentCenter;
    self.timeMoneyTF.clipsToBounds = YES;
    self.timeMoneyTF.layer.borderColor = RGBCOLOR(197, 198, 199).CGColor;
    self.timeMoneyTF.layer.borderWidth = 1;
    self.timeMoneyTF.layer.cornerRadius = 6;
    self.timeMoneyTF.keyboardType = UIKeyboardTypeNumberPad;
    self.timeMoneyTF.userInteractionEnabled = NO;
    
    //Lab
    UILabel * timeMoneyLab = [[UILabel alloc]init];
    [scrollViewMain addSubview:timeMoneyLab];
    
    [timeMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeMoneyTF.mas_top);
        make.left.equalTo(self.timeMoneyTF.mas_right).offset(10);
        make.width.offset(60);
        make.height.offset(20);
        
    }];
    
    timeMoneyLab.text = @"元/次";
    timeMoneyLab.font = Font(13);
    timeMoneyLab.textColor = RGBCOLOR(60, 61, 62);
    timeMoneyLab.textAlignment = NSTextAlignmentLeft;
    
    //服务时间
    self.serveTimeLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.serveTimeLab];
    
    [self.serveTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.servePriceLab.mas_bottom).offset(60);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(20);
        
    }];
    
    self.serveTimeLab.text = [NSString stringWithFormat:@"服务时间"];
    self.serveTimeLab.textColor = RGBCOLOR(60, 61, 62);
    self.serveTimeLab.textAlignment = NSTextAlignmentLeft;
    self.serveTimeLab.font = Font(15);
    //星期btn tag从10开始
    NSArray * weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSLog(@"%f",self.serveTimeLab.frame.origin.y+self.serveTimeLab.frame.size.height);
    self.btnArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<7; i++) {
        
        UIButton * weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [weekBtn setTitle:weekArr[i] forState:UIControlStateNormal];
        [weekBtn setTitleColor:RGBCOLOR(60, 61, 62) forState:UIControlStateNormal];
        
        weekBtn.tag = i+10;
        //weekBtn.frame = CGRectMake(15+(SCREEN_W-20-30)/4*i+i*5, self.serveTimeLab.frame.origin.y+self.serveTimeLab.frame.size.height+5,(SCREEN_W-20-30)/4 , 25);
        weekBtn.clipsToBounds = YES;
        weekBtn.layer.borderColor = RGBCOLOR(197, 198, 199).CGColor;
        weekBtn.layer.borderWidth = 1;
        weekBtn.layer.cornerRadius = 6;
        [weekBtn addTarget:self action:@selector(weekBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollViewMain addSubview:weekBtn];
        [self.btnArr addObject:weekBtn];
        
        if (i<5) {
            //weekBtn.frame = CGRectMake(15+(SCREEN_W-20-30)/5*i+i*5, self.serveTimeLab.frame.origin.y+self.serveTimeLab.frame.size.height+5,(SCREEN_W-20-30)/5 , 25);
            [weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.serveTimeLab.mas_bottom).offset(5);
                make.left.offset(15+(SCREEN_W-20-30)/5*i+i*5);
                make.width.offset((SCREEN_W-20-30)/5);
                make.height.offset(25);
            }];
        }else{
            
            int ii = i-5;
            //weekBtn.frame = CGRectMake(15+(SCREEN_W-20-30)/5*i+i*5, self.serveTimeLab.frame.origin.y+self.serveTimeLab.frame.size.height+35,(SCREEN_W-20-30)/5 , 25);
            [weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.serveTimeLab.mas_bottom).offset(35);
                make.left.offset(15+(SCREEN_W-20-30)/5*ii+ii*5);
                make.width.offset((SCREEN_W-20-30)/5);
                make.height.offset(25);
            }];
        }
        
    }
    
    
    //服务介绍
    self.serveInfoLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.serveInfoLab];
    
    [self.serveInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveTimeLab.mas_bottom).offset(90);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(25);
        
    }];
    
    self.serveInfoLab.text = [NSString stringWithFormat:@"服务介绍"];
    self.serveInfoLab.textColor = RGBCOLOR(60, 61, 62);
    self.serveInfoLab.textAlignment = NSTextAlignmentLeft;
    self.serveInfoLab.font = Font(15);
    
    //服务介绍输入框
    self.serveInfoTV = [[UITextView alloc]init];
    [scrollViewMain addSubview:self.serveInfoTV];
    
    [self.serveInfoTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveInfoLab.mas_bottom).offset(5);
        make.left.equalTo(self.serveInfoLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(90);
        
    }];
    
    self.serveInfoTV.textColor = [UIColor blackColor];
    self.serveInfoTV.font = Font(13);
    self.serveInfoTV.clipsToBounds = YES;
    self.serveInfoTV.layer.borderColor = RGBCOLOR(192, 193, 194).CGColor;
    self.serveInfoTV.layer.borderWidth = 1;
    self.serveInfoTV.layer.cornerRadius = 8;
    self.serveInfoTV.keyboardType = UIKeyboardTypeDefault;
    self.serveInfoTV.contentMode = UIViewContentModeCenter;
    self.serveInfoTV.delegate = self;
    
    //介绍占位符
    self.placeHolder = [[UILabel alloc]init];
    
    [self.serveInfoTV addSubview:self.placeHolder];
    
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveInfoTV.mas_top).offset(3);
        make.left.equalTo(self.serveInfoTV.mas_left).offset(5);
        make.width.offset(260);
        make.height.offset(25);
    }];
    self.placeHolder.userInteractionEnabled = NO;
    self.placeHolder.text = @"请介绍你该技能的服务宗旨和工作经验等";
    self.placeHolder.textColor = RGBCOLOR(198, 199, 200);
    self.placeHolder.textAlignment = NSTextAlignmentLeft;
    self.placeHolder.font = Font(13);
    
    //服务优势
    
    self.serveGoodLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.serveGoodLab];
    
    [self.serveGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveInfoTV.mas_bottom).offset(30);
        make.left.equalTo(self.skillCategoryLab.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(20);
        
    }];
    
    self.serveGoodLab.text = [NSString stringWithFormat:@"服务优势"];
    self.serveGoodLab.textColor = RGBCOLOR(60, 61, 62);
    self.serveGoodLab.textAlignment = NSTextAlignmentLeft;
    self.serveGoodLab.font = Font(15);
    
    //服务优势输入框
    self.serveGoodTV = [[UITextView alloc]init];
    [scrollViewMain addSubview:self.serveGoodTV];
    
    [self.serveGoodTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveGoodLab.mas_bottom).offset(5);
        make.left.equalTo(self.serveGoodLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(90);
        
    }];
    
    self.serveGoodTV.textColor = [UIColor blackColor];
    self.serveGoodTV.font = Font(13);
    self.serveGoodTV.clipsToBounds = YES;
    self.serveGoodTV.layer.borderColor = RGBCOLOR(192, 193, 194).CGColor;
    self.serveGoodTV.layer.borderWidth = 1;
    self.serveGoodTV.layer.cornerRadius = 8;
    self.serveGoodTV.keyboardType = UIKeyboardTypeDefault;
    self.serveGoodTV.contentMode = UIViewContentModeCenter;
    self.serveGoodTV.delegate = self;
    
    //介绍占位符
    self.placeHolder2 = [[UILabel alloc]init];
    
    [self.serveGoodTV addSubview:self.placeHolder2];
    
    [self.placeHolder2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveGoodTV.mas_top).offset(3);
        make.left.equalTo(self.serveGoodTV.mas_left).offset(5);
        make.width.offset(180);
        make.height.offset(20);
    }];
    self.placeHolder2.userInteractionEnabled = NO;
    self.placeHolder2.text = @"请介绍你该技能的特点等";
    self.placeHolder2.textColor = RGBCOLOR(198, 199, 200);
    self.placeHolder2.textAlignment = NSTextAlignmentLeft;
    self.placeHolder2.font = Font(13);
    
    //备注
    self.serveRemarkLab  = [[UILabel alloc]init];
    [scrollViewMain addSubview:self.serveRemarkLab];
    
    [self.serveRemarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveGoodTV.mas_bottom).offset(30);
        make.left.equalTo(self.serveGoodTV.mas_left);
        make.width.offset(SCREEN_W - 120);
        make.height.offset(20);
        
    }];
    
    self.serveRemarkLab.text = [NSString stringWithFormat:@"备注"];
    self.serveRemarkLab.textColor = RGBCOLOR(60, 61, 62);
    self.serveRemarkLab.textAlignment = NSTextAlignmentLeft;
    self.serveRemarkLab.font = Font(15);
    
    //服务优势输入框
    self.serveRemarkTV = [[UITextView alloc]init];
    [scrollViewMain addSubview:self.serveRemarkTV];
    
    [self.serveRemarkTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveRemarkLab.mas_bottom).offset(5);
        make.left.equalTo(self.serveRemarkLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(90);
        
    }];
    
    self.serveRemarkTV.textColor = [UIColor blackColor];
    self.serveRemarkTV.font = Font(13);
    self.serveRemarkTV.clipsToBounds = YES;
    self.serveRemarkTV.layer.borderColor = RGBCOLOR(192, 193, 194).CGColor;
    self.serveRemarkTV.layer.borderWidth = 1;
    self.serveRemarkTV.layer.cornerRadius = 8;
    self.serveRemarkTV.keyboardType = UIKeyboardTypeDefault;
    self.serveRemarkTV.contentMode = UIViewContentModeCenter;
    self.serveRemarkTV.delegate = self;
    
    //介绍占位符
    self.placeHolder3 = [[UILabel alloc]init];
    
    [self.serveRemarkTV addSubview:self.placeHolder3];
    
    [self.placeHolder3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serveRemarkTV.mas_top).offset(3);
        make.left.equalTo(self.serveRemarkTV.mas_left).offset(5);
        make.width.offset(180);
        make.height.offset(25);
    }];
    self.placeHolder3.userInteractionEnabled = NO;
    self.placeHolder3.text = @"你还有什么想要介绍的";
    self.placeHolder3.textColor = RGBCOLOR(198, 199, 200);
    self.placeHolder3.textAlignment = NSTextAlignmentLeft;
    self.placeHolder3.font = Font(13);
    
    //保证金
    SPDepositView *depositView = [[SPDepositView alloc]initWithFeeType:BAIL_FEE];
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
    
    [scrollViewMain addSubview:depositView];
    [depositView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(SCREEN_W);
        make.top.equalTo(self.serveRemarkTV.mas_bottom);
        if (kiPhone5)
        {
            make.height.offset(255+20);
        }else
        {
            make.height.offset(258);
        }
    }];
    
    //下一步
    
    self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
 
    self.commitButton.backgroundColor = RGBCOLOR(249, 26, 82);
    [self.commitButton setTitle:@"发布" forState:UIControlStateNormal];

    [scrollViewMain addSubview:self.commitButton];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView.mas_bottom).offset(45);
        make.left.offset(30);
        make.width.offset(SCREEN_W-60);
        make.height.offset(40);
    }];
    
    self.commitButton.clipsToBounds = YES;
    self.commitButton.layer.cornerRadius = 10;
    [self.commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    scrollViewMain.contentSize = CGSizeMake(SCREEN_W,800+400);
    //    _star.show_star = level*20;
    //    //重新绘制
    //    [_star setNeedsDisplay];
}

#pragma  mark  提示是否去充值

-(void)gotoRechargeTip{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保证金可以提升服务者对您的信任度\n支付保证金后系统将通知服务者\n您的余额不足，快去充值吧" preferredStyle: UIAlertControllerStyleActionSheet];
    
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

#pragma mark - weekBtnClick:星期选择
- (void)weekBtnClick:(UIButton * )weekBtn{
    
    weekBtn.selected = !weekBtn.selected;
    if (weekBtn.selected) {
        [weekBtn setBackgroundColor:RGBCOLOR(249, 26, 82)];
        [weekBtn setTitleColor:WC forState:UIControlStateSelected];
        weekBtn.layer.borderWidth = 0;
    }else{
        
        [weekBtn setBackgroundColor:WC];
        weekBtn.layer.borderWidth = 1;
        
    }
    
}

#pragma mark -  selectClick服务价格选择
- (void)selectClick:(UIButton *)selectBtn{
    
    selectBtn.selected = !selectBtn.selected;
    
    NSLog(@"%ld",(long)selectBtn.tag);
    
    if (selectBtn.tag==1) {
        self.publishModel.priceUnit = @"HOUR";
        self.timeMoneyTF.text = @"";
    }else{
        self.publishModel.priceUnit = @"TIME";
        self.hourMoneyTF.text = @"";
    }
    
    if (selectBtn.tag==1) {
        
        if (selectBtn.selected==YES) {
            
            self.timeMoneyTF.userInteractionEnabled = NO;
            self.timeMoneyBtn.selected = NO;
            self.hourMoneyTF.userInteractionEnabled = YES;
            self.hourMoneyBtn.selected = YES;
        }else{
            
            self.timeMoneyBtn.selected = YES;
            self.timeMoneyTF.userInteractionEnabled = YES;
            self.hourMoneyTF.userInteractionEnabled = NO;
            self.hourMoneyBtn.selected = NO;
        }
        
    }else{
        
        if (selectBtn.selected !=YES ) {
            
            self.timeMoneyTF.userInteractionEnabled = NO;
            self.timeMoneyBtn.selected = NO;
            self.hourMoneyTF.userInteractionEnabled = YES;
            self.hourMoneyBtn.selected = YES;
        }else{
            
            self.timeMoneyBtn.selected = YES;
            self.timeMoneyTF.userInteractionEnabled = YES;
            self.hourMoneyBtn.selected = NO;
            self.hourMoneyTF.userInteractionEnabled = NO;
        }
    }
}

#pragma mark -  commitButtonClick  提交按钮流程

- (void)commitButtonClick{
    
    [self.view endEditing:YES];
    
    //给模型赋值
    if ([self p_assignmentForModel])
    {
        //提交发布
        [self p_publish];
    } ;
    
    
}

#pragma  mark  给模型赋值

-(BOOL)p_assignmentForModel{
    //服务价格
    if ([self.publishModel.priceUnit isEqualToString:@"HOUR"])
    {
        self.publishModel.price = self.hourMoneyTF.text;
        
    }else if([self.publishModel.priceUnit isEqualToString:@"TIME"])
    {
        self.publishModel.price = self.timeMoneyTF.text;
    }
    
    if (isEmptyString(self.publishModel.price) )
    {
        Toast(@"请输入服务价格");
        return NO;
    }
    
    //保证金不够
    if (!self.bailEnough)
    {
        [self gotoRechargeTip];
        return NO;
    }
    
    //服务时间
    self.seletedBtnArr = [NSMutableArray arrayWithCapacity:0];
    
    NSDictionary *weekDic = @{@"周一":@"MON",@"周二":@"TUE",@"周三":@"WED",@"周四":@"THU",@"周五":@"FRI",@"周六":@"SAT",@"周日":@"SUN"};
    
    for (UIButton * btn in self.btnArr)
    {
        if (btn.selected ==YES)
        {
            [self.seletedBtnArr addObject:weekDic[btn.titleLabel.text]];
        }
    }
    
    NSString *weekStr = [self.seletedBtnArr componentsJoinedByString:@","];
    NSLog(@"%@",weekStr);
    if (isEmptyString(weekStr))
    {
        Toast(@"请选择服务时间");
        return NO;
    }
    self.publishModel.serTime = weekStr;
    
    //服务介绍
    if (isEmptyString(self.serveInfoTV.text))
    {
        Toast(@"请填写服务介绍");
        return NO;
    }
    self.publishModel.serIntro = self.serveInfoTV.text;
    
    //服务优劣
    if (isEmptyString(self.serveInfoTV.text))
    {
        Toast(@"请填写服务优劣");
        return NO;
    }
    self.publishModel.serContent = self.serveGoodTV.text;
    
    //服务备注
    if (isEmptyString(self.serveInfoTV.text))
    {
        Toast(@"请填写服务备注");
        return NO;
    }
    
    if (isEmptyString(self.bailRuleId))
    {
        Toast(@"请选择保证金");
        return NO;
    }
    self.publishModel.bailRuleId = self.bailRuleId;
    self.publishModel.serRemark = self.serveRemarkTV.text;
    return YES;
}

#pragma  mark  提交发布

-(void)p_publish{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    //    信息id，当已经存在发布的技能时该id必填
    //    信息CODE，当已经存在发布的技能时该code必填
    if (!isEmptyString(self.publishModel.lucCode)) {
        [paramenters setObject:self.publishModel.lucCode forKey:@"lucCode"];
        [paramenters setObject:self.publishModel.lucID forKey:@"id"];
    }
    
    [paramenters setObject:[StorageUtil getCity] forKey:@"city"];
    [paramenters setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [paramenters setObject:[StorageUtil getCode] forKey:@"code"];
    [paramenters setObject:self.publishModel.price forKey:@"price"];
    [paramenters setObject:self.publishModel.priceUnit forKey:@"priceUnit"];
    [paramenters setObject:self.publishModel.serContent forKey:@"serContent"];
    [paramenters setObject:self.publishModel.serIntro forKey:@"serIntro"];
    [paramenters setObject:self.publishModel.serRemark forKey:@"serRemark"];
    [paramenters setObject:self.publishModel.serTime forKey:@"serTime"];
    
    [paramenters setObject:self.publishModel.serRemark forKey:@"serRemark"];
    [paramenters setObject:self.publishModel.skillCode forKey:@"skillCode"];
    
    
    //工作经历
    SPSkillWorkExp *expModel = self.publishModel.skillWorkExp[0];
    if (!isEmptyString(expModel.companyName)) {
        NSMutableArray *expArr = @[].mutableCopy;
        for (SPSkillWorkExp *exp in self.publishModel.skillWorkExp) {
            NSMutableDictionary *expDic = @{}.mutableCopy;
            [expDic setObject:exp.companyName forKey:@"companyName"];
            [expDic setObject:exp.workCity forKey:@"workCity"];
            [expDic setObject:exp.industry forKey:@"industry"];
            [expDic setObject:exp.jobTitle forKey:@"jobTitle"];
            [expDic setObject:@(exp.working) forKey:@"working"];
            [expDic setObject:exp.workBeginTime forKey:@"workBeginTime"];
            [expDic setObject:exp.workEndTime forKey:@"workEndTime"];
            [expArr addObject:expDic];
        }
        [paramenters setObject:expArr forKey:@"skillWorkExp"];
    }
    if (self.publishModel.skillImgList.count!=0) {
        [paramenters setObject:self.publishModel.skillImgList forKey:@"skillImgList"];
    }
    
    [paramenters setObject:[StorageUtil getCity] forKey:@"locationValue"];
    [paramenters setObject:self.publishModel.bailRuleId forKey:@"bailRuleId"];
    NSLog(@"%@",paramenters);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeAdd parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        //获取到已发布的lucCode,lucID,并赋值
        self.publishModel.lucCode = responseObject[@"data"][@"lucCode"];
        self.publishModel.lucID = responseObject[@"data"][@"id"];
        hidenMBP;
        
        [self popTipView];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        Toast(@"oo,出错了耶");
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma  mark  弹出 是 返回 还是继续完善发布信息View

-(void)popTipView{
    
    SPPublishFinishPopView *popView = [[SPPublishFinishPopView alloc]initWithFrame:self.view.bounds complment:^(NSString *resultStr) {
        
        if ([resultStr isEqualToString:@"补充资料"])
        {
            //跳转到工作经验VC
            [self pushToExperienceVC];
            
        }else if([resultStr isEqualToString:@"返回"])
        {
            [self back];
        }
    }];
    [self.view addSubview:popView];
}

#pragma  mark  点击了 返回

-(void)back{
    
    if (self.formWhere == 0)
    {
        //发送通知 跳转到首页
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationJumpToHome object:nil];
        //退出
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if (self.formWhere == 1)
    {
        //发送通知 跳转到租约广场
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPublishSkillFinshedForLeaseVC object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma  mark  继续完善 跳转到工作经验VC

-(void)pushToExperienceVC{
    SPExperienceForMakeMonery *vc =[[SPExperienceForMakeMonery alloc]init];
    vc.formWhere = self.formWhere;
    vc.model = self.publishModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - -----------------textViewDelegate-----------------

- (void)textViewDidChange:(UITextView *)textView
{
    //FDLog(@"%@", textView.text);
    
    if (self.serveInfoTV.text.length!=0) {
        self.placeHolder.hidden = YES;
        
    }
    if (self.serveGoodTV.text.length != 0){
        
        self.placeHolder2.hidden = YES;
    }
    if (self.serveRemarkTV.text.length !=0){
        
        self.placeHolder3.hidden = YES;
    }
    //允许提交按钮点击操作
    //self.commitButton.backgroundColor = RGBCOLOR(249, 26, 82);
    //self.commitButton.userInteractionEnabled = YES;
    
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
    //    if (textView.text.length == 0) {
    //
    //        self.placeHolder.hidden = NO;
    //        //self.commitButton.userInteractionEnabled = NO;
    //        //self.commitButton.backgroundColor = [UIColor lightGrayColor];
    //
    //    }
    if (self.serveInfoTV.text.length==0) {
        self.placeHolder.hidden = NO;
    }
    if (self.serveGoodTV.text.length == 0){
        
        self.placeHolder2.hidden = NO;
    }
    if (self.serveRemarkTV.text.length ==0){
        
        self.placeHolder3.hidden = NO;
    }
    
}



#pragma mark - initWithNav
- (void)initWithNav{
    
    self.titleLabel.text = @"我要赚钱";
    self.titleLabel.textColor = [UIColor blackColor];
}

@end

