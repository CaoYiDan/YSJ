//
//  SPSPLzsEvaluateVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPEvaluateForSkillVC.h"
#import "SPFindPeopleVC.h"
#import "StarView.h"
@interface SPEvaluateForSkillVC ()<UITextViewDelegate>
{
    StarView * _star1;
    StarView * _star2;
    int level;
}

@property (strong, nonatomic)UILabel *placeHolder;
@property (strong, nonatomic)UIButton *commitButton;
@property (strong, nonatomic)UITextView *feedBackTextView;
@property (strong, nonatomic)UILabel *stirngLenghLabel;

@end

@implementation SPEvaluateForSkillVC

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
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.feedBackTextView resignFirstResponder];
    //[self.phoneCodeTF resignFirstResponder];
    
}

#pragma mark - initUI
- (void)initUI{
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //技能
    UILabel * evaluateLab = [[UILabel alloc]init];
    [self.view addSubview:evaluateLab];
    evaluateLab.textColor = RGBCOLOR(85, 86, 87);
    evaluateLab.text = @"技能评价";
    evaluateLab.textAlignment = NSTextAlignmentCenter;
    evaluateLab.font = Font(13);
    
    [evaluateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(30);
        make.left.offset(SCREEN_W/2-40);
        make.width.offset(80);
        make.height.offset(20);
        
    }];
    
    _star1 = [[StarView alloc]initWithFrame:CGRectMake(SCREEN_W/2-68, 70, 160, 30)];
    _star1.font_size=30;
    _star1.canSelected = YES;
    //_star1.show_star = 3;
    [self.view addSubview:_star1];
    
    //态度
    UILabel * attitudeLab = [[UILabel alloc]init];
    [self.view addSubview:attitudeLab];
    attitudeLab.textColor = RGBCOLOR(85, 86, 87);
    attitudeLab.text = @"态度评价";
    attitudeLab.textAlignment = NSTextAlignmentCenter;
    attitudeLab.font = Font(13);
    
    [attitudeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_star1.mas_bottom).offset(30);
        make.left.equalTo(evaluateLab.mas_left);
        make.width.equalTo(evaluateLab.mas_width);
        make.height.equalTo(evaluateLab.mas_height);
        
    }];
    
    _star2 = [[StarView alloc]initWithFrame:CGRectMake(SCREEN_W/2-68, 170, 160, 30)];
    _star2.font_size=30;
    _star2.canSelected = YES;
    [self.view addSubview:_star2];
    
    //输入框
    self.feedBackTextView = [[UITextView alloc]init];
    [self.view addSubview:self.feedBackTextView];
    
    [self.feedBackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_star2.mas_bottom).offset(35);
        make.left.offset(45);
        make.width.offset(SCREEN_W-90);
        make.height.offset(120);
        
    }];
    
    self.feedBackTextView.textColor = [UIColor blackColor];
    self.feedBackTextView.font = Font(13);
    self.feedBackTextView.clipsToBounds = YES;
    self.feedBackTextView.layer.borderColor = RGBCOLOR(249, 28, 84).CGColor;
    self.feedBackTextView.layer.borderWidth = 1.3;
    self.feedBackTextView.layer.cornerRadius = 10;
    self.feedBackTextView.keyboardType = UIKeyboardTypeDefault;
    self.feedBackTextView.contentMode = UIViewContentModeCenter;
    self.feedBackTextView.delegate = self;
    
    //站位
    self.placeHolder = [[UILabel alloc]init];
    
    [self.feedBackTextView addSubview:self.placeHolder];
    
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.feedBackTextView.mas_top).offset(3);
        make.left.equalTo(self.feedBackTextView.mas_left).offset(5);
        make.width.offset(180);
        make.height.offset(25);
    }];
    self.placeHolder.userInteractionEnabled = NO;
    self.placeHolder.text = @"写下对于好友的评论";
    self.placeHolder.textColor = RGBCOLOR(198, 199, 200);
    self.placeHolder.textAlignment = NSTextAlignmentLeft;
    self.placeHolder.font = Font(13);
    
    //字数
    self.stirngLenghLabel = [[UILabel alloc]init];
    
    [self.feedBackTextView addSubview:self.stirngLenghLabel];
    
    [self.stirngLenghLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(SCREEN_W-142);
        make.top.equalTo(self.feedBackTextView.mas_top).offset(95);
        //make.right.equalTo(self.feedBackTextView.mas_right).offset(-90);
        make.width.offset(85);
        make.height.offset(25);
    }];
    //self.stirngLenghLabel.userInteractionEnabled = NO;
    self.stirngLenghLabel.text = @"0/100";
    self.stirngLenghLabel.textColor = RGBCOLOR(198, 199, 200);
    self.stirngLenghLabel.textAlignment = NSTextAlignmentLeft;
    self.stirngLenghLabel.font = Font(13);
    
    //按钮
    self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitButton.backgroundColor = [UIColor lightGrayColor];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.commitButton.userInteractionEnabled = NO;
    
    [self.view addSubview:self.commitButton];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(-60);
        make.left.offset(30);
        make.width.offset(SCREEN_W-60);
        make.height.offset(40);
        
    }];
    self.commitButton.clipsToBounds = YES;
    self.commitButton.layer.cornerRadius = 10;
    //    _star.show_star = level*20;
    //    //重新绘制
    //    [_star setNeedsDisplay];
    [self.commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    _star.show_star = level*20;
    //    //重新绘制
    //    [_star setNeedsDisplay];
}

#pragma mark -  commitButtonClick  提交按钮
- (void)commitButtonClick{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"SKILL" forKey:@"type"];
    [dic setObject:self.mainCode forKey:@"mainCode"];
    [dic setObject:self.mainCode forKey:@"beCommentedCode"];
    [dic setObject:[StorageUtil getCode] forKey:@"commentor"];
    [dic setObject:self.beCommentedCode forKey:@"beCommented"];
    [dic setObject:@(_star1.show_star/20) forKey:@"commentScore"];
    [dic setObject:@(_star2.show_star/20) forKey:@"attitudeScore"];
    [dic setObject:self.feedBackTextView.text forKey:@"content"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedComment parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    //FDLog(@"%@", textView.text);
    
    self.placeHolder.hidden = YES;
    //允许提交按钮点击操作
    self.commitButton.backgroundColor = RGBCOLOR(249, 26, 82);
    self.commitButton.userInteractionEnabled = YES;
    
    //实时显示字数
    self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/500", (unsigned long)textView.text.length];
    self.stirngLenghLabel.hidden = NO;
    //字数限制操作
    if (textView.text.length >= 500) {
        
        textView.text = [textView.text substringToIndex:500];
        self.stirngLenghLabel.text = @"500/500";
        //self.stirngLenghLabel.textColor = RGBCOLOR(249, 26, 82);
        
    }
    if (textView.text.length>=100) {
        self.stirngLenghLabel.hidden = YES;
    }else{
        
        self.stirngLenghLabel.hidden = NO;
    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        
        self.placeHolder.hidden = NO;
        self.stirngLenghLabel.hidden = NO;
        self.commitButton.userInteractionEnabled = NO;
        self.commitButton.backgroundColor = [UIColor lightGrayColor];
        
    }
    
}

#pragma mark - initWithNav
- (void)initWithNav{
    
    self.titleLabel.text = @"评价";
    self.titleLabel.textColor = [UIColor blackColor];
    //[self.rightButton setTitle:@"评价" forState:UIControlStateNormal];
    //    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - rightButtonClick
- (void)rightButtonClick{
    
    
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

