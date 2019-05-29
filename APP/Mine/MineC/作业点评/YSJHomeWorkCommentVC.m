#import "YSJHomeWorkVC.h"
#import "YSJHomeWorkCell.h"
#import "YSJHomeWorkTypeListCell.h"
#import "YSJHomeWorkCommentVC.h"
#import "YSJOrderCourseView.h"
#import "StarView.h"
#import "YSJPostVideoOrImgView.h"
@interface YSJHomeWorkCommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LGTextView *textView;
@property (nonatomic,strong) StarView *star1;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * sectionArr;
@property (nonatomic,strong) NSArray * subTitleArr;
@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,assign) NSInteger sectionNum;

@end

@implementation YSJHomeWorkCommentVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"作业点评";
    
    self.sectionArr  = @[];
   
    self.titleArr = @[@{@"img":@"ic_buzhi",@"name":@"布置作业"},@{@"img":@"ic_dianpin",@"name":@"点评作业"},@{@"img":@"tijiao ",@"name":@"提交作业"}];
    
    self.subTitleArr = @[@"guize",@"geren",@"kefu",@"fankui"];
    
    [self.view addSubview:self.tableView];
    
    [self setSaveButton];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self getData];
    [self getNum];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)getNum{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YNumber parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSDictionary * re = responseObject;
        NSMutableDictionary *numdic = re.mutableCopy;
        [numdic setObject:@(0) forKey:@"haveLook"];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger num = 0;
    
    if (self.homeWorkDetailType == HomeWorkDetailCheckMyPublish) {
        num = 1;
    }else if (self.homeWorkDetailType == HomeWorkDetailCheckComment){
        num = 3;
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitCommit) {
        num = 1;
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitComment){
        num = 2;
    }
    
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJHomeWorkCell *cell = [YSJHomeWorkCell loadCode:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 102+56;
    }else{
        return 56;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 102+56)];
        header.backgroundColor =KWhiteColor;
        //课程评价
        YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 00, kWindowW, 102)];
   
        UIView *bottomLine22 = [[UIView alloc]init];
        bottomLine22.backgroundColor = grayF2F2F2;
        [view addSubview:bottomLine22];
        [bottomLine22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.width.offset(kWindowW);
            make.height.offset(1);
            make.bottom.equalTo(view).offset(0);
        }];
        [header addSubview:view];
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 102, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业题目";
        sectionTitle.textColor = KBlack333333;
        [header addSubview:sectionTitle];
        
        return header;
        
    }else {
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业内容";
        sectionTitle.textColor = KBlack333333;
        return sectionTitle;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
         return 600;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
       return  self.footerView;
    }else{
        return [[UIView alloc]init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YSJCellType type = 0;
    
    if (indexPath.row==0){
        
        type = HomeWorkPublish;
        
    } else if (indexPath.row==1){
        
        type = HomeWorkComment;
        
    }else{
        
        type = HomeWorkCommit;
        
    }
    
    YSJHomeWorkVC *vc = [[YSJHomeWorkVC alloc]init];
    vc.homeWorkType = type;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = grayF2F2F2;
        _tableView.backgroundColor = KWhiteColor;
        _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49);
        
        _tableView.rowHeight = 81+17;
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

-(void)save{
    
}

-(void)setSaveButton{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"发布" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}


- (UIView *)footerView{
    if (!_footerView) {
        
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 600)];
        footer.backgroundColor =KWhiteColor;
        _footerView = footer;
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业评价";
        sectionTitle.textColor = KBlack333333;
        [footer addSubview:sectionTitle];
        
        //评分
        _star1 = [[StarView alloc]initWithFrame:CGRectMake(SCREEN_W/2-80, 13, 140, 30)];
        _star1.font_size=23;
        _star1.canSelected = YES;
        [footer addSubview:_star1];
        WeakSelf;
        _star1.StarBlock = ^(NSInteger showShar) {
            NSLog(@"%ld",(long)showShar);
            if (showShar>100) {
                showShar =100;
            }
            weakSelf.index = showShar/20-1;
            
        };
        
        
        //总评价
        //    UILabel * evaluate = [[UILabel alloc]init];
        //    evaluate.font = font(14);
        //    evaluate.text = @"";
        //    evaluate.textColor = [UIColor hexColor:@"BBBBBB"];
        //    self.evaluate = evaluate;
        //    [self.topView addSubview:evaluate];
        //    [evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(_star1.mas_right).offset(0);
        //        make.height.offset(20);
        //        make.top.offset(28);
        //        make.centerY.equalTo(evaluateTitle).offset(0);
        //    }];
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = grayF2F2F2;
        [footer addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.offset(kWindowW);
            make.height.offset(1);
            make.top.offset(55);
        }];
        
        //作业题目
        UILabel * sectionTitle2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56, kWindowW, 56)];
        sectionTitle2.font = font(16);
        sectionTitle2.text = @"  上传点评";
        sectionTitle2.textColor = KBlack333333;
        [footer addSubview:sectionTitle2];
        
        LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56*2, SCREEN_W-2*kMargin, 100)];
        self.textView = textView;
        [footer addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.height.offset(100);
            make.width.offset(SCREEN_W-2*kMargin); make.top.equalTo(sectionTitle2.mas_bottom).offset(0);
        }];
        
        textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
        textView.textColor = black666666;
        textView.delegate = self;
        textView.font  = font(14);
        textView.placeholder = @"详细描述作业完成情况";
        [footer addSubview:textView];
        
        YSJPostVideoOrImgView *view = [[YSJPostVideoOrImgView alloc]initWithFrame:CGRectMake(0, 210, kWindowW, 300)];
        view.canNotSelectedVideo = YES;
        [footer addSubview:view];
        
        return footer;
    }
    return _footerView;
}


@end
