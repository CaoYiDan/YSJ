//
//  SPReserveMineViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPReserveMineViewController.h"
#import "HomeModel.h"
#import "HomeCollectionViewCell.h"
#import "SPKitExample.h"

@interface SPReserveMineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView * _collectionView;
    
    int _start;
    int _end;
}

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation SPReserveMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    
    [self createUI];
    [self createRefresh];
    
    // Do any additional setup after loading the view.
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //
    [_collectionView.mj_header beginRefreshing];
    //_collectionView.mj_footer.hidden = YES;
    
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
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    NSString * kurl;
    if (!self.code) {//0是我的预约  我的关注
        
        kurl = MineFollowUrl;
    }else{
        
        kurl = FollowMineUrl;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"关注%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        if (self.dataArr.count==0) {
            Toast(@"暂无数据");
            [self haveNoMessage];
        }
      
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        
//        NSNumber *pages = responseObject[@"pages"];
//        NSNumber *pageNum = responseObject[@"pageNum"];
//        if ([pages integerValue] == [pageNum integerValue]) {
//            _collectionView.mj_footer.hidden = YES;
//        }else{
//            _collectionView.mj_footer.hidden = NO;
//        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - haveNoMessage
- (void)haveNoMessage{
    
    UILabel * messageLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-30, SCREEN_H/2-15, 60, 30)];
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = Font(14);
    messageLab.textColor = [UIColor lightGrayColor];
    messageLab.text = @"暂无数据";
    [_collectionView addSubview:messageLab];
}

- (void)getMoreData{
    
    NSString * kurl;
    
    if (!self.code) {//0是我的预约 我的关注
        
        kurl = MineFollowUrl;
    }else{// 关注我的
        
        kurl = FollowMineUrl;
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
        
//        NSNumber *pages = responseObject[@"pages"];
//        NSNumber *pageNum = responseObject[@"pageNum"];
//        
//        if ([pages integerValue] == [pageNum integerValue]) {
//            _collectionView.mj_footer.hidden = YES;
//        }else{
//            _collectionView.mj_footer.hidden = NO;
//        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - createUI
- (void)createUI{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    //collectionHead用法
    //layout.headerReferenceSize = CGSizeMake(SCREEN_W,SCREEN_H);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 10, SCREEN_W-2 , SCREEN_H - 49) collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = MAINCOLOR;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    
}
#pragma mark - collectionViewdelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * homeCell = @"homeCell";
    
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCell forIndexPath:indexPath];
    if (self.dataArr) {
        
        HomeModel * model = self.dataArr[indexPath.row];
        [cell refreshUI:model withCode:self.code];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_W-4)/2, (SCREEN_W-4)/2 );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1,0,1,0);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeModel * model = self.dataArr[indexPath.row];
    YWPerson *person = [[YWPerson alloc]initWithPersonId:model.code];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
    //    GoodsDetailVCViewController * goodsVC = [[GoodsDetailVCViewController alloc]init];
    //    HomeModel * homeModel = self.dataArr[indexPath.item];
    //    goodsVC.goods_idStr = homeModel.goodsId;
    //
    //    goodsVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:goodsVC animated:YES];
    
    
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}
@end
