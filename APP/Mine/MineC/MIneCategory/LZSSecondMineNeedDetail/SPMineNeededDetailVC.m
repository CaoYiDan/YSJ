//
//  SPMineNeededDetailVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//
//分享界面
#import "SPShareView.h"
#import "SPFindPeopleVC.h"
#import "NSString+getSize.h"
#import "SPMineNeededDetailVC.h"
#import "SPMyNeededDetailTableCell.h"
@interface SPMineNeededDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    int _start;
    int _end;
}

@property(nonatomic,strong)UIView *moreView;

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * myNeededDetailTableView;
@property (nonatomic,strong) UIView * headView ;
@property(nonatomic,strong)SPShareView *shareView;
@end

@implementation SPMineNeededDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGBCOLOR(239, 239, 239);
    [self initNav];
    [self initUI];
    [self initFreshData];
    // Do any additional setup after loading the view.
}

#pragma mark - initFreshData
- (void)initFreshData{
    
    self.myNeededDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myNeededDetailTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.myNeededDetailTableView.mj_footer.hidden = YES;
    //
    [self.myNeededDetailTableView.mj_header beginRefreshing];
}

//下拉刷新
- (void)loadNewData{
    
    _start = 1;
    //_end = 8;
    [self loadData];
}

//上啦加载
- (void)loadMoreData{
    
    _start ++;
    //_end = _end +8;
    
    NSLog(@"%zd,%zd",_end,_start);
    
    [self getMoreData];
}

#pragma mark - loadData

- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:self.neededModel.ID forKey:@"demandId"];
    
    NSLog(@"%@",dict);
    //NSString * strUrl = @"http://192.168.1.32:8080/api-server/v1/demand/listUserByDeploy";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [[HttpRequest sharedClient]httpRequestPOST:MyNeedDetailUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"我的需求详细%@",responseObject);
        
        self.dataArr = [SPMineNeededDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [_myNeededDetailTableView reloadData];
        
        [_myNeededDetailTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - getMoreData
- (void)getMoreData{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:self.neededModel.ID forKey:@"demandId"];
    
    NSLog(@"%@",dict);
    
    [[HttpRequest sharedClient]httpRequestPOST:MyNeedDetailUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        //NSLog(@"我的技能%@",responseObject);
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            SPMineNeededDetailModel * model = [[SPMineNeededDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self.dataArr addObject:model];
        }
        
        [_myNeededDetailTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - initUI
- (void)initUI{
    
    self.myNeededDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.myNeededDetailTableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.myNeededDetailTableView.delegate=self;
    self.myNeededDetailTableView.dataSource=self;
    
    self.myNeededDetailTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.myNeededDetailTableView.backgroundColor = WC;
    self.myNeededDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myNeededDetailTableView.showsHorizontalScrollIndicator = NO;
    self.myNeededDetailTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.myNeededDetailTableView];
    //footVIew
    UIView * bottomView = [[UIView alloc]init];
    
    self.myNeededDetailTableView.tableFooterView = bottomView;
    //HeadView
    //动态高的需求描述
    CGSize maxSize = CGSizeMake(SCREEN_W-30, MAXFLOAT);
    NSString * serInfoStr = [NSString stringWithFormat:@"需求描述: %@            ",self.neededModel.content];
    CGSize textSize = [serInfoStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)} context:nil].size;
    //textSize = [serInfoStr sizeWithFont:font(14) maxW:SCREEN_W-30];
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 210+textSize.height+20)];
    self.headView.backgroundColor = WC;
    self.myNeededDetailTableView.tableHeaderView = self.headView;
    
    UIView * firstLineView = [[UIView alloc]init];
    [self.headView addSubview:firstLineView];
    [firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headView.mas_top).offset(0.5);
        make.left.offset(0);
        make.width.offset(SCREEN_W);
        make.height.offset(0.56);
    }];
    firstLineView.backgroundColor = RGBCOLOR(230, 230, 230);
    //技能头像
    UIImageView * headIv = [[UIImageView alloc]init];
    [self.headView addSubview:headIv];
    
    [headIv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset (15);
        make.left.offset(15);
        make.width.offset(50);
        make.height.offset(50);
        
    }];
    
    headIv.clipsToBounds = YES;
    headIv.layer.cornerRadius = 5;
    [headIv sd_setImageWithURL:[NSURL URLWithString:self.neededModel.skillImg]];
    //需求技能
    UILabel * skillLab = [[UILabel alloc]init];
    [self.headView addSubview:skillLab];
    
    [skillLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headIv.mas_top);
        make.left.equalTo(headIv.mas_right).offset(5);
        make.width.offset(180);
        make.height.offset(20);
    }];
    skillLab.textAlignment = NSTextAlignmentLeft;
    skillLab.textColor = [UIColor blackColor];
    skillLab.font =Font(14);
    skillLab.text = [NSString stringWithFormat:@"需求技能: %@",self.neededModel.skill];
    //诚意金
    UILabel * honestMoneyLab = [[UILabel alloc]init];
    [self.headView addSubview:honestMoneyLab];
    
    [honestMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headIv.mas_top);
        make.right.offset(-15);
        make.width.offset(180);
        make.height.offset(20);
    }];
    honestMoneyLab.textAlignment = NSTextAlignmentRight;
    honestMoneyLab.textColor = [UIColor blackColor];
    honestMoneyLab.font =Font(14);
    if ([self.neededModel.bailFee doubleValue]>0) {
        honestMoneyLab.text = [NSString stringWithFormat:@"已交诚意金: %@元",self.neededModel.bailFee];
    }
    
    //发布时间
    UILabel * createTimeLab = [[UILabel alloc]init];
    [self.headView addSubview:createTimeLab];
    
    [createTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(skillLab.mas_bottom).offset(5);
        make.left.equalTo(headIv.mas_right).offset(5);
        make.width.offset(SCREEN_W - 160);
        make.height.offset(20);
    }];
    createTimeLab.textAlignment = NSTextAlignmentLeft;
    createTimeLab.textColor = [UIColor blackColor];
    createTimeLab.font =Font(14);
    createTimeLab.text = [NSString stringWithFormat:@"发布时间: %@",self.neededModel.createDateStr];
    
    //需求描述
    UILabel * serInfoLab = [[UILabel alloc]init];
    [self.headView addSubview:serInfoLab];
    
    serInfoLab.text = [NSString
                       stringWithFormat:@"需求描述:%@       ",self.neededModel.content];
    serInfoLab.textAlignment = NSTextAlignmentLeft;
    //serInfoLab.lineBreakMode = NSLineBreakByCharWrapping;
    serInfoLab.textColor = [UIColor blackColor];
    serInfoLab.numberOfLines = 0;
    serInfoLab.font =Font(14);
    //CGSize textSize = [serInfoLab.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)} context:nil].size;
    
    CGFloat serInfoHeight = textSize.height +20 ;
    //serInfoLab.frame = CGRectMake(headIv.frame.origin.x, headIv.frame.origin.y+headIv.frame.size.height+15, SCREEN_W-110, serInfoHeight);
    [serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headIv.mas_bottom).offset(15);
        make.left.equalTo(headIv.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(serInfoHeight);
    }];
    
    //
    //
    
    
    //
    UIView * secondLineView = [[UIView alloc]init];
    [self.headView addSubview:secondLineView];
    [secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(serInfoLab.mas_bottom).offset(5);
        //make.top.equalTo(headIv.mas_bottom).offset(60);
        make.left.offset(15);
        make.width.offset(SCREEN_W);
        make.height.offset(0.5);
    }];
    secondLineView.backgroundColor = RGBCOLOR(230, 230, 230);
    //overdueFlag;// 该需求是否过期（NODEAL 未过期，YDEAL过期，NAVERNO永不过期）
    
    if ([self.neededModel.overdueFlag isEqualToString:@"NODEAL"]) {
        
        if ([self.neededModel.flushFlag integerValue]==0) {
            UIImageView * flashIV = [[UIImageView alloc]init];
            [self.headView addSubview:flashIV];
            
            [flashIV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(honestMoneyLab.mas_bottom).offset(0);
                make.right.offset(-40);
                make.width.offset(40);
                make.height.offset(40);
            }];
            
            flashIV.image = [UIImage imageNamed:@"wd_xq_sy"];
        }
        
    }else if ([self.neededModel.overdueFlag isEqualToString:@"YDEAL"]){
        
        //闪约图标
        if ([self.neededModel.flushFlag integerValue]==0) {
            UIImageView * flashIV = [[UIImageView alloc]init];
            [self.headView addSubview:flashIV];
            
            [flashIV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(honestMoneyLab.mas_bottom).offset(0);
                make.right.offset(-40);
                make.width.offset(40);
                make.height.offset(40);
            }];
            
            flashIV.image = [UIImage imageNamed:@"wd_xq_sy"];
        }
        
        //过期判断
        UILabel * overdueLab = [[UILabel alloc]init];
        [self.headView addSubview:overdueLab];
        
        [overdueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(serInfoLab.mas_bottom).offset(10);
            make.left.equalTo(serInfoLab.mas_left);
            make.width.offset(180);
            make.height.offset(20);
        }];
        overdueLab.textAlignment = NSTextAlignmentLeft;
        overdueLab.textColor = [UIColor blackColor];
        overdueLab.font =Font(14);
        overdueLab.text = [NSString stringWithFormat:@"需求已过期,可快速再发一单"];
        
        UIButton * againNeedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [againNeedBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
        [againNeedBtn setTitleColor:WC forState:UIControlStateNormal];
        //    [self.backView addSubview:self.changeBtn];
        [self.headView addSubview:againNeedBtn];
        [againNeedBtn addTarget:self action:@selector(againNeedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        againNeedBtn.clipsToBounds = YES;
        againNeedBtn.layer.cornerRadius = 6;
        [againNeedBtn setTitle:@"再发一单" forState:UIControlStateNormal];
        [againNeedBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            
            make.top.equalTo(serInfoLab.mas_bottom).offset(8);
            make.right.offset(-15);
            make.width.offset(90);
            make.height.offset(30);
        }];
    }
    
    //需求技能
    UILabel * tellTextLab = [[UILabel alloc]init];
    [self.headView addSubview:tellTextLab];
    
    [tellTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(serInfoLab.mas_bottom).offset(45);
        make.left.offset(15);
        make.width.offset(SCREEN_W - 30);
        make.height.offset(20);
    }];
    tellTextLab.textAlignment = NSTextAlignmentCenter;
    tellTextLab.textColor = [UIColor blackColor];
    tellTextLab.font =Font(13);
    tellTextLab.text = [NSString stringWithFormat:@"已有%d位应聘者!",self.neededModel.countUser];
    //,其中%d位已成交self.neededModel.dealNum
    UIView * thirdLineView = [[UIView alloc]init];
    [self.headView addSubview:thirdLineView];
    [thirdLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tellTextLab.mas_bottom).offset(10);
        make.left.offset(15);
        make.width.offset(SCREEN_W);
        make.height.offset(0.5);
    }];
    thirdLineView.backgroundColor = RGBCOLOR(230, 230, 230);
    
    for (int i = 0; i<self.neededModel.userList.count; i++)
    {
        UIImageView * userIV = [[UIImageView alloc]init];
        [self.headView addSubview:userIV];
        userIV.clipsToBounds = YES;
        userIV.layer.cornerRadius = 15;
        
        [userIV sd_setImageWithURL:[NSURL URLWithString:self.neededModel.userList[i][@"headImg"]]];
        
        if (self.neededModel.dealNum>0 &&self.neededModel.dealNum== i+1) {
            
            UIView * lineView = [[UIView alloc]init];
            [self.headView addSubview:lineView];
            lineView.backgroundColor = RGBCOLOR(188, 188, 188);
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(tellTextLab.mas_bottom).offset(20);
                make.left.offset(15+30*i+10*i+5);
                make.width.offset(1);
                make.height.offset(20);
            }];
        }
        
        [userIV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(tellTextLab.mas_bottom).offset(15);
            make.left.offset(15+30*i+10*i);
            make.width.offset(30);
            make.height.offset(30);
        }];
    }
    
}

#pragma mark -  againNeedBtnClick:再发一单

- (void)againNeedBtnClick:(UIButton *  )btn
{
    SPFindPeopleVC *vc= [[SPFindPeopleVC alloc]init];
    vc.publishAgain = YES;
    vc.needModel = self.neededModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * myNeededDetailCell = @"myNeededDetailCell";
    
    //SPMineNeededTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPMyNeededDetailTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        
        cell = [[SPMyNeededDetailTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myNeededDetailCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WC;
    }
    
    if (self.dataArr.count) {
        
        SPMineNeededDetailModel * model = self.dataArr[indexPath.row];
        cell.model = model;
        [cell initWithModel:model];
    }
    
    //[self.myNeededDetailTableView reloadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    //服务时间
    //CGFloat cellHeight = 100;//[SPLzsMySkillsTableViewCell initWithCellHeight:model];
    SPMineNeededDetailModel * model = self.dataArr[indexPath.row];
    CGSize maxSize = CGSizeMake(SCREEN_W-40, CGFLOAT_MAX);
    NSString * serInfoStr = [NSString stringWithFormat:@"服务介绍: %@",model.userIntroduce];
    CGSize textSize = [serInfoStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)} context:nil].size;
    return 200+textSize.height;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArr.count;
}

#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = @"我的需求";
    self.titleLabel.textColor = [UIColor blackColor];
    [self setRight];
}

-(void)setRight{
    
    UIButton *rightButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:nil];
    [rightButton setImage:[UIImage imageNamed:@"h_more"] forState:0];
    [rightButton addTarget:self action:@selector(rightMoreClick) forControlEvents:UIControlEventTouchDown];
    rightButton.titleLabel.font = font(14);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

-(void)rightMoreClick{
    CGFloat h = 0;
    if (self.moreView.originY==0) {
        h = -20-64;
    }else{
        h=0;
    }
    [UIView animateWithDuration:0.4 animations:^{
        self.moreView.originY = h;
    }];
}

-(UIView *)moreView{
    if (!_moreView) {
        _moreView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W-70, -20-SafeAreaTopHeight-SafeAreaBottomHeight, 70, 80)];
        _moreView.backgroundColor = [UIColor whiteColor];
        _moreView.layer.borderColor = HomeBaseColor.CGColor;
        _moreView.layer.borderWidth = 1;
        [self.view addSubview:_moreView];
        
        UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
        [firstBtn setTitle:@"分享" forState:0];
        [firstBtn setTitleColor:[UIColor blackColor] forState:0];
        [firstBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
        firstBtn.titleLabel.font = font(14);
        [_moreView addSubview:firstBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 70, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_moreView addSubview:line];
        UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 41, 70, 40)];
        [secondBtn setTitleColor:[UIColor blackColor] forState:0];
        [secondBtn setTitle:@"删除" forState:0];
        
        [secondBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchDown];
        secondBtn.titleLabel.font = font(14);
        [_moreView addSubview:secondBtn];
    }
    return _moreView;
}

-(void)share{
    [UIView animateWithDuration:0.4 animations:^{
        [self.view addSubview:self.shareView];
        self.shareView.shareImg = [UIImage imageNamed:@"app"];
        self.shareView.shareUrl = [NSString stringWithFormat:@"http://59.110.70.112:8080/web/date.html?id=%@",self.neededModel.ID];
        self.shareView.hidden = NO;
        self.shareView.originY = 0;
    }];
}
//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        //        _shareView.shareImg = self.headIV.image;
    }
    return _shareView;
}

-(void)delete{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.neededModel.ID forKey:@"id"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrldeleteDemand parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        !self.block?:self.block(0);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -  lazyLoad
- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
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


