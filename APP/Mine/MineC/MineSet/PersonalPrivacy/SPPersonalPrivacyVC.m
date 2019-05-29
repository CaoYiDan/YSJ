//
//  SPPersonalPrivacyVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPersonalPrivacyVC.h"
//#import "SPPersonalSetCell.h"
#import "SPPersonalDynamicVC.h"
@interface SPPersonalPrivacyVC()<UITableViewDelegate,UITableViewDataSource>

{
    
    UITableView * _tableView;
}
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,assign) BOOL accessTenFeeds;//允许十条
@property (nonatomic,assign) BOOL accessMyAlbum;//不允许非关注查看

@end

@implementation SPPersonalPrivacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WC;
    [self initNav];
    [self createTableView];
    //[self createRefresh];
}
#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //
    [_tableView.mj_header beginRefreshing];
    
    
}
//下拉刷新
- (void)loadNewData{
    
    [self loadData];
    
}
#pragma mark - loadData
-(void)loadData{
    
    NSDictionary * dict = @{@"userCode":[StorageUtil getCode]};

    [[HttpRequest sharedClient]httpRequestPOST:GetPersonalListUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        NSLog(@"yuyue%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSDictionary * tempDict = responseObject[@"data"];
        self.accessMyAlbum = tempDict[@"accessMyAlbum"];
        self.accessTenFeeds = tempDict[@"accessTenFeeds"];
        //[self.dataArr addObjectsFromArray:tempDataArr];
        
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - createTableView
- (void)createTableView{
    
    //,@"不许非关注人查看我的朋友圈",@"允许查看十条动态",
    self.titleArr = @[@"不让他看我的动态",@"不看他的动态"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, SCREEN_H-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"personalPrivacyCell";
    
    UITableViewCell * setCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!setCell) {
        
        setCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //setCell.selectionStyle = UITableViewCellSelectionStyleNone;
        setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
//    if (indexPath.row==2) {
//        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-40, 10, 30, 30)];
//        if (self.accessTenFeeds) {
//            [btn1 setImage:[UIImage imageNamed:@"ys_seleted"] forState:UIControlStateNormal];
//        }else{
//        
//            [btn1 setImage:[UIImage imageNamed:@"ys_w"] forState:UIControlStateNormal];
//        }
//        [btn1 addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
//        [setCell addSubview:btn1];
//        //btn1 setImage:[UIImage imageNamed:<#(nonnull NSString *)#>] forState:<#(UIControlState)#>
//        
//    }
//    if (indexPath.row==3) {
//        
//        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-40, 10, 30, 30)];
//        if (self.accessMyAlbum) {
//            [btn2 setImage:[UIImage imageNamed:@"ys_seleted"] forState:UIControlStateNormal];
//        }else{
//            
//            [btn2 setImage:[UIImage imageNamed:@"ys_w"] forState:UIControlStateNormal];
//        }
//        [btn2 addTarget:self action:@selector(secondClick:) forControlEvents:UIControlEventTouchUpInside];
//        [setCell addSubview:btn2];
//    }
    
    setCell.textLabel.text = self.titleArr[indexPath.row];
    
    setCell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    //setCell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    return setCell;
}

- (void)firstClick:(UIButton *)btn{

    btn.selected =!btn.selected;

    if (btn.selected) {
        
    }
    
    NSDictionary * dict = @{@"userCode":[StorageUtil getCode]};
    
    [[HttpRequest sharedClient]httpRequestPOST:GetPersonalListUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        NSLog(@"yuyue%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSDictionary * tempDict = responseObject[@"data"];
        //self.accessMyAlbum = tempDict[@"accessMyAlbum"];
        //self.accessTenFeeds = tempDict[@"accessTenFeeds"];
        //[self.dataArr addObjectsFromArray:tempDataArr];
        
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)secondClick:(UIButton *)btn{

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row ==0) {//不让他看我的动态
        
        SPPersonalDynamicVC * dynamicVC = [[SPPersonalDynamicVC alloc]init];
        dynamicVC.titleStr = @"不让他看我的动态";
        [self.navigationController pushViewController:dynamicVC animated:YES];
        
    }else if (indexPath.row ==1) {//不看他的动态
        
        SPPersonalDynamicVC * dynamicVC = [[SPPersonalDynamicVC alloc]init];
        dynamicVC.titleStr = @"不看他的动态";
        [self.navigationController pushViewController:dynamicVC animated:YES];
        
    }
//    else if (indexPath.row ==2) {//不许非关注人查看我的朋友圈
//        
//        
//        
//    }else if (indexPath.row ==3) {//允许查看十条动态
//        
//        
//        
//    }else if (indexPath.row ==4) {//不让他看我的动态
//        
//        
//
//    }else{//不看他的动态
//    
//        
//    }
    
}

#pragma mark -  initNav
- (void)initNav{

    self.titleLabel.text = @"隐私设置";
    self.titleLabel.textColor = TitleColor;
    
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
