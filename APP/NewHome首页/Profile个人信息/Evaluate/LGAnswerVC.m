//
//  LGEvaluateVC.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "LGAnswerVC.h"
#import "CMInputView.h"
#import "LGEvaluateCell.h"
#import "LGEvaluateStatus.h"

#import "LGEvaluateStatusFrame.h"
@interface LGAnswerVC ()
//评论模型
@property (nonatomic,strong) LGEvaluateStatusFrame *frameModel;
@property (nonatomic,strong) UIView *baseInputView;//baseView
@property (nonatomic,strong) CMInputView *inputView;//回复编辑框
@property (nonatomic,strong) UIButton *sendAnswerBtn;//发送按钮
@property (nonatomic,strong) UIView *coverView;//覆盖的View
@property (nonatomic,strong) NSMutableArray *dataForAnswer;//回复数据源
//被评价的code
@property (nonatomic,copy) NSString *beCommentedCode;
//被评价的人的code
@property (nonatomic,copy) NSString *beCommented;

@property (nonatomic,copy) NSString *replyName;

@property (nonatomic,strong) UIButton *coverBtn;
@end

@implementation LGAnswerVC
{
    CGFloat keyHeight;//键盘高度
    int  _page;
}

-(NSMutableArray*)dataForAnswer{
    if (!_dataForAnswer) {
        _dataForAnswer = [[NSMutableArray alloc]init];
    }
    return _dataForAnswer;
}

-(LGEvaluateStatusFrame *)frameModel{
    if (!_frameModel) {
        _frameModel = [[LGEvaluateStatusFrame alloc]init];
        //        _frameModel.type = EvaluateCellTypeForEvaluate;
    }
    return _frameModel;
}

#pragma  mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self initView];
    [self load];//加载数据
    
}

-(void)coverTap{
    Toast(@"暂不支持评论自己");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.baseInputView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.baseInputView.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.baseInputView removeFromSuperview];
    [self.coverView removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)config{
    
    self.beCommentedCode = self.frameModel.status.code;
    self.beCommented = self.frameModel.status.commentor;
}

-(void)ifLookMySelf{
    
    if ([[StorageUtil getCode] isEqualToString:self.frameModel.status.commentor]) {
        UIButton *coverBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 38)];
        coverBtn.backgroundColor = [UIColor clearColor];
        [coverBtn addTarget:self action:@selector(coverTap) forControlEvents:UIControlEventTouchDown];
        self.coverBtn =coverBtn;
        [self.baseInputView addSubview:coverBtn];
        return;
    }
}

-(void)load{
    
    _page = 1;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.code forKey:@"mainCode"];
    [dict setObject:@(_page) forKey:@"pageNum"];
    [dict setObject:@(6) forKey:@"pageSize"];
    [dict setObject:@"COMMENT" forKey:@"type"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlCommnetList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        NSLog(@"%@",[StorageUtil getCode]);
        //评价的主题Model
        self.frameModel = [[LGEvaluateStatusFrame alloc]init];
        self.frameModel.status.commentMain = YES;
        self.frameModel.status = [LGEvaluateStatus mj_objectWithKeyValues:responseObject[@"data"][@"comment"]];
        self.frameModel.status.commentMain = YES;
        //根据获取的数据 对一些数据赋值
        [self config];
        [self ifLookMySelf];
        //获取回复数据
        NSMutableArray *arr = (NSMutableArray *)[LGEvaluateStatus mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"replyList"]];
        NSMutableArray *arr2 = [[NSMutableArray alloc]init];
        for (LGEvaluateStatus *status in arr) {
            LGEvaluateStatusFrame *frameModel = [[LGEvaluateStatusFrame alloc]init];
            frameModel.status = status;
            
            [arr2 addObject:frameModel];
        }
        self.dataForAnswer = arr2;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        /** 如果是最后一页，则底部不显示加载更多*/
        BOOL isLastPage = ![responseObject[@"hasNext"] boolValue];
        if (!isLastPage){
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}

-(void)loadMore{
    
    _page ++;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.code forKey:@"mainCode"];
    [dict setObject:@(_page) forKey:@"pageNum"];
    [dict setObject:@(6) forKey:@"pageSize"];
    [dict setObject:@"COMMENT" forKey:@"type"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlCommnetList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        //获取回复数据
        NSMutableArray *arr = (NSMutableArray *)[LGEvaluateStatus mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"replyList"]];
        NSMutableArray *arr2 = [[NSMutableArray alloc]init];
        for (LGEvaluateStatus *status in arr) {
            LGEvaluateStatusFrame *frameModel = [[LGEvaluateStatusFrame alloc]init];
            frameModel.status = status;
            
            [arr2 addObject:frameModel];
        }
        [self.dataForAnswer addObjectsFromArray:arr2];
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
        /** 如果是最后一页，则底部不显示加载更多*/
        BOOL isLastPage = ![responseObject[@"hasNext"] boolValue];
        if (!isLastPage){
            self.tableView.mj_footer.hidden = NO;
        }else{
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

-(void)initView{
    
    self.title = @"回复";
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor =[UIColor whiteColor];
    //header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(load)];
    // footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_footer.hidden = YES;
    
    //添加到window上，不会随着tableView滑动
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //添加输入框和发送按钮
    [window addSubview:self.baseInputView];
    //添加阀盖View
    [window addSubview:self.coverView];
    //.注册通知。检测键盘的弹出和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataForAnswer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LGEvaluateCell *cell=[LGEvaluateCell cellWithTableView:tableView];
    WeakSelf;
    if (indexPath.section == 0) {//评论
        cell.statusFrame = self.frameModel;
        //        cell.block = ^(NSString *evaluateId){
        //            [weakSelf.inputView becomeFirstResponder];
        //            weakSelf.inputView.placeholder = @"回复点什么吧...";
        //            weakSelf.beCommentedCode = weakSelf.frameModel.status.evaluateId;
        //        };
    }else{//回复
        LGEvaluateStatusFrame *statusFrame = self.dataForAnswer[indexPath.row];
        cell.statusFrame = statusFrame;
        //    cell.block = ^(NSString *evaluateId){
        //        [weakSelf.inputView becomeFirstResponder];
        ////        weakSelf.inputView.placeholder = [NSString stringWithFormat:@"回复%@",statusFrame.status.userName];
        ////        weakSelf.postUserName = YES;//需要上传userName参数
        ////        weakSelf.parentId = statusFrame.status.evaluateId;
        ////        weakSelf.replyName = statusFrame.status.userName;
        //    };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return self.frameModel.cellHeight;
    }
    
    LGEvaluateStatusFrame *statusFrame = self.dataForAnswer[indexPath.row];
    return statusFrame.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *baseView = [[UIView alloc]init];
    
    UILabel *totalLabel = [[UILabel alloc]init];
    totalLabel.frame= CGRectMake(0, 0, SCREEN_W, 30);
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.backgroundColor = [UIColor whiteColor];
    
    totalLabel.text = [NSString stringWithFormat:@"回复（%ld）",(long)self.dataForAnswer.count];
    [baseView addSubview:totalLabel];
    return baseView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    //得到被回复人Id
    if (indexPath.section == 0) {
        
        if ([[StorageUtil getCode] isEqualToString:self.frameModel.status.commentor]) {
            Toast(@"不能评论自己");
            return;
        }
        self.coverBtn.hidden = NO;
        [self config];
        self.inputView.placeholder = @"回复点什么吧...";
        //调起键盘
        [self.inputView becomeFirstResponder];
        
    }else{
        
        LGEvaluateStatusFrame *statusF = self.dataForAnswer[indexPath.row];
        if ([[StorageUtil getCode] isEqualToString:statusF.status.commentor]) {
            Toast(@"不能回复自己");
            return;
        }
        [self.coverBtn removeFromSuperview];
        self.inputView.placeholder = [NSString stringWithFormat:@"回复%@",statusF.status.commentorName];
        self.beCommentedCode = statusF.status.code;
        self.beCommented = statusF.status.commentor;
        //调起键盘
        [self.inputView becomeFirstResponder];

    }
}

#pragma mark - 消息触发事件
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyHeight= kbHeight;
    
    self.coverView.frame=CGRectMake(0,0 , kWindowW, kWindowH-keyHeight-self.baseInputView.frameHeight);
    //将视图上移计算好的偏移
    NSLog(@"margin - %f",kbHeight);
    
    [UIView animateWithDuration:duration animations:^{
        CGRect newRect = CGRectMake(0,  kWindowH-keyHeight-self.baseInputView.frameHeight,kWindowW, self.baseInputView.frameHeight);
        self.baseInputView.frame = newRect;
    }];
}

///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    
    self.coverView.frame=CGRectMake(0,kWindowH, kWindowW, kWindowH-keyHeight-self.baseInputView.frameHeight);
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    /*
     你想下沉到哪里就到哪里
     */
    [UIView animateWithDuration:duration animations:^{
        
        self.baseInputView.frame = CGRectMake(0, kWindowH-self.baseInputView.frameHeight, kWindowW, self.baseInputView.frameHeight);
//        self.inputView.frameHeight = 38;
    }];
}

#pragma  mark - 点击事件

#pragma  mark 回复
- (void)send{
    //    //未登录
    //    if (isEmptyString([StorageUtil getCode])) {
    //        [self presentToLoginVC];//跳转到登录
    //        return;
    //    }
    //    //回复信息不能为空
    //    if (isEmptyString(self.inputView.text)) {
    //
    //        return;
    //    }
    //
    
//    if ([[StorageUtil getCode] isEqualToString:self.frameModel.status.commentor]) {
//        [[[iToast makeText:(@"不能评论自己")] setGravity:iToastGravityTop]                      show];
//        
//        return;
//    }
    
    //菊花显示
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"COMMENT" forKey:@"type"];
    
    [dic setObject:self.frameModel.status.code forKey:@"mainCode"];
    
    [dic setObject:self.beCommentedCode forKey:@"beCommentedCode"];
    
    [dic setObject:self.beCommented forKey:@"beCommented"];
    
    [dic setObject:[StorageUtil getCode] forKey:@"commentor"];
    
    [dic setObject:self.inputView.text forKey:@"content"];
    NSLog(@"%@",dic);
    
    //    {
    //        commentor : 1769090182153047665,
    //        mainCode : 129,
    //        content : Qwwqqw,
    //        beCommented : 1549950269066756729,
    //        type : COMMENT,
    //        beCommentedCode : 129
    //    }
    
    
    //    {
    //        id : 129,
    //        praised : 0,
    //        mainCode : 1549950269066756729,
    //        praiseNum : 0,
    //        commentNum : 1,
    //        commentorAvatar : https://neoace.github.io/img/durian1.jpeg,
    //        commentedTime : 2017-09-01 08:54:24,
    //        type : USER,
    //        code : 1548173072403631497,
    //        beCommentedName : neoace,
    //        commentor : 1552509554767642633,
    //        beCommented : 1549950269066756729,
    //        commentorName : 高鹤泉测试昵称,
    //        content : HELLO
    //    }
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedComment parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self load];
        //恢复设置
        [self.view endEditing:YES];
        self.inputView.text = @"";
        self.inputView.placeholder = @"回复点什么吧...";
//        [self.inputView layoutSubviews];
        [self.inputView textDidChange2];
        [self config];
        self.coverBtn.hidden = NO;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)tap1{
    [self.inputView resignFirstResponder];
}

#pragma  mark - setter
//看不见的键盘弹出的输入框上面的覆盖View ,
-(UIView *)coverView{
    if(_coverView==nil){
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *coverView = [[UIView alloc]init];
        coverView.backgroundColor = [UIColor clearColor];
        self.coverView = coverView;
        [window addSubview:coverView];
        //添加手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.coverView addGestureRecognizer:tapGestureRecognizer];
    }
    return  _coverView;
}

//输入框和发送按钮的base View
-(UIView *)baseInputView{
    if (_baseInputView==nil) {
        _baseInputView=[[UIView alloc]initWithFrame:CGRectMake(0 , kWindowH-38,kWindowW , 38)];
        
        [_baseInputView addSubview:self.inputView];
        [_baseInputView addSubview:self.sendAnswerBtn];
        [_sendAnswerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.width.offset(70);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
    return _baseInputView;
}

//发送按钮
- (UIButton *)sendAnswerBtn{
    if (_sendAnswerBtn == nil) {
        _sendAnswerBtn = [[UIButton alloc]init];
        [_sendAnswerBtn setTitle:@"发送" forState:0];
        _sendAnswerBtn.backgroundColor=[UIColor redColor];
        [_sendAnswerBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendAnswerBtn;
}

//输入框
- (CMInputView *)inputView{
    if (_inputView == nil) {
        
        _inputView = [[CMInputView alloc]initWithFrame:CGRectMake(0 , 0,kWindowW-70 , 38)];
        _inputView.font = [UIFont systemFontOfSize:18];
        _inputView.placeholder = @"回复点什么吧...";
        _inputView.placeholderColor = [UIColor grayColor];
        _inputView.placeholderFont = [UIFont systemFontOfSize:14];
        
        // 设置文本框最大行数
        WeakSelf;
        [_inputView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
//            textHeight+=10;
            CGRect frame = weakSelf.baseInputView.frame;
            frame.size.height = textHeight;
            frame.origin.y=kWindowH-textHeight-keyHeight;
            weakSelf.baseInputView.frame = frame;
            weakSelf.inputView.frameHeight = textHeight;
        }];
        _inputView.maxNumberOfLines = 2;
    }
    return _inputView;
}

#pragma mark 跳转到登录界面
-(void)presentToLoginVC{
    //    WeakSelf;
    //    LGLoginViewController*login=[[LGLoginViewController alloc]init];
    //    login.formWhere=@"商品详情";
    //    LGNavigationViewController*naVc=[[LGNavigationViewController alloc]initWithRootViewController:login];
    //    login.view.backgroundColor=[UIColor blackColor];
    //    [weakSelf presentViewController:naVc animated:YES completion:^{
    //
    //    }];
}

//将字符串转成字典
-(id )dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        return nil;
    }
    
    return dic;
}

@end
