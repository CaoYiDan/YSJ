//
//  SPCityVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSearchVC.h"
#import "SPSearchView.h"
#import "SPThirdLevelCell.h"
#import "SPSearchListVC.h"
#import "SPBaseNavigationController.h"
@interface SPSearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic ,strong)NSMutableArray *lastSearchArr;//最近搜索
@property(nonatomic ,strong)NSArray *guessFindArr;//猜你想找
@property(nonatomic,strong)SPSearchView *searchV;
@end

@implementation SPSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sNav];
    
    [self creatCollection];
    
    [self searchView];
    
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchV textFieldBecomeFirstResponse];
}

-(void)getData{
    
    if (isEmptyString([StorageUtil getCode])) return;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlListSelections parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.guessFindArr = responseObject[@"data"][@"hobby"];
        self.lastSearchArr = responseObject[@"data"][@"history"];
        [self.collectionview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section ==0){
        return self.lastSearchArr.count;
    }else if (section == 1){
        return self.guessFindArr.count;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPThirdLevelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPThirdLevelCellID forIndexPath:indexPath];
    if (indexPath.section ==0) {
        [cell setText:self.lastSearchArr[indexPath.row]];
    }
    if (indexPath.section == 1) {
        [cell setText:self.guessFindArr[indexPath.row]];
    }
    
    cell.backgroundColor = HomeBaseColor;
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 40, 10, 40);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma  mark 返回的header视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_W, 40);
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        
        NSString *identer = @"";
        if (indexPath.section == 0) {
            identer = @"section0";
        }else{
            identer = @"section1";
        }
        //定制头部视图的内容
        UICollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identer forIndexPath:indexPath];
        
        UIImageView *locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7, 22, 22)];
        
        [headerV addSubview:locationImg];
        
        UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 40)];
        textLab.backgroundColor = [UIColor whiteColor];
        [headerV addSubview:textLab];
        textLab.font = kFontNormal;
        if (indexPath.section ==0) {
            [locationImg setImage: [UIImage imageNamed:@"c_location"]];
            
            textLab.text = @"最近搜索";
        }else if(indexPath.section ==1){
            [locationImg setImage: [UIImage imageNamed:@"s_guess"]];
            textLab.text = @"猜你想找";
        }
        
        if (isEmptyString([StorageUtil getCode])) textLab.text = @"";[locationImg setImage: [UIImage imageNamed:@""]];
        
        reusableView = headerV;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *searchText = @"";
    if (indexPath.section==0) {
        searchText = self.lastSearchArr[indexPath.row];
    }else{
        searchText = self.guessFindArr[indexPath.row];
    }
    
    SPSearchListVC *vc = [[SPSearchListVC alloc]init];
    //        vc.type = 1;
    vc.titleString = searchText;
//    SPBaseNavigationController *nav = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
    vc.navigationItem.title = @"搜索列表";
//    [self presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchView{
    
    SPSearchView *search = [[SPSearchView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, 42)];
    self.searchV = search;
    WeakSelf;
    search.searchViewBlock = ^(NSString *searchText){
        SPSearchListVC *vc = [[SPSearchListVC alloc]init];
        vc.titleString = searchText;
//        SPBaseNavigationController *nav = [[SPBaseNavigationController alloc]initWithRootViewController:vc];
        [weakSelf.navigationController pushViewController:vc animated:YES];
//        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    
    [self.view addSubview:search];
}

#pragma  mark 创建collectionView
-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_W-100)/3, 30);
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,50, [UIScreen mainScreen].bounds.size.width,SCREEN_H-50) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPThirdLevelCell class] forCellWithReuseIdentifier:SPThirdLevelCellID];
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section0"];
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section1"];
    [self.view addSubview:_collectionview];
}

- (NSMutableArray *)lastSearchArr
{
    if (_lastSearchArr == nil) {
        _lastSearchArr = [NSMutableArray array];
    }
    return _lastSearchArr;
}

-(void)sNav{
    self.titleLabel.text = @"搜索";
}

@end
