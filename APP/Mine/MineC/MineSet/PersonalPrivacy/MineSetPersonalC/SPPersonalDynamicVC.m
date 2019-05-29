//
//  SPPersonalDynamicVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPersonalDynamicVC.h"
#import "SPDynamicListEditingVC.h"
#import "HomeModel.h"

@interface SPPersonalDynamicVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    CGFloat _imgHeight;
    UICollectionView *_mCollectionView;
    
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation SPPersonalDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WC;
    [self initNav];
    [self initUI];
    [self createRefresh];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self createRefresh];
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
    _mCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    //
    [_mCollectionView.mj_header beginRefreshing];
    
    
}
//下拉刷新
- (void)loadNewData{
    
    

    [self loadData];
    
}


#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString * kurl;
    if ([self.titleStr isEqualToString:@"不让他看我的动态"]) {        [dict setObject:@2 forKey:@"relation"];
        kurl = PrivacyListUrl;
    }else{//  不看他的动态
        [dict setObject:@1 forKey:@"relation"];
        kurl = PrivacyListUrl;
    }
    
    
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
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
        NSLog(@"dataArr%@",self.dataArr);
        
        [_mCollectionView reloadData];
        [_mCollectionView.mj_header endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

#pragma mark - initUI
- (void)initUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _imgHeight = (self.view.frame.size.width - 50)/5;
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 50)/5, _imgHeight + 20);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10,5, 10,5);
    
    _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width,SCREEN_H) collectionViewLayout:layout];
    
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    
    _mCollectionView.scrollEnabled = NO;
    
    [_mCollectionView registerClass:[SPPersonalDynamicCollectionVCell class] forCellWithReuseIdentifier:@"SPPersonalDynamicCollectionVCell"];
    
    [self.view addSubview:_mCollectionView];
}

//UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count + 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    if (indexPath.row==self.dataArr.count) {
        //+
        SPDynamicListEditingVC * editingVC = [[SPDynamicListEditingVC alloc]init];
        editingVC.titleStr = self.titleStr;
        editingVC.editingStr = @"添加";
        [self.navigationController pushViewController:editingVC animated:YES];
        
    }else if (indexPath.row==self.dataArr.count+1){
    
        SPDynamicListEditingVC * editingVC = [[SPDynamicListEditingVC alloc]init];
        editingVC.titleStr = self.titleStr;
        editingVC.editingStr = @"删除";
        [self.navigationController pushViewController:editingVC animated:YES];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * dynamicCell = @"SPPersonalDynamicCollectionVCell";
    
    SPPersonalDynamicCollectionVCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:dynamicCell forIndexPath:indexPath];
   
    if (indexPath.row<self.dataArr.count) {
        
        HomeModel * model = self.dataArr[indexPath.row];
        
        [cell initWithModel:model AndCount:0];
        
    }else if(indexPath.row==self.dataArr.count)
    {//加

        HomeModel * model =nil;
        //self.dataArr[indexPath.row];
        [cell initWithModel:model AndCount:1];
        
    }else if(indexPath.row==self.dataArr.count+1)
    {//减
        HomeModel * model =nil;
        //self.dataArr[indexPath.row];
        [cell initWithModel:model AndCount:2];
        
    }

    return cell;
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}

- (void)initNav{

    self.titleLabel.text = self.titleStr;
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
