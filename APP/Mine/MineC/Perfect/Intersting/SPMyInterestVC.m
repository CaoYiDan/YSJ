//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPMyHeader.h"
#import "SPMyInterestVC.h"
#import "SPKungFuModel.h"
#import "SPPrefectPhotosVC.h"
#import "SPMyInterestCell.h"
#import "SPMyInterestSection.h"

@interface SPMyInterestVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UICollectionView *collectionView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPMyHeader *tableHeader;

@end

@implementation SPMyInterestVC
{
    UIColor *_cellColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cellColor = PURPLECOLOR;
    //背景图片
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    
    //tableview
    [self.view insertSubview:self.collectionView atIndex:1];
    //myHeader
    [self.view insertSubview:self.tableHeader atIndex:2];
    
    //请求数据
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    //从 我的个人中心进入
//    if (self.formMyCenter) {
////        self.jumpBtn.hidden = YES;
//        self.needShow = NO;
////        self.nextBtn.hidden = NO;
////        [self.nextBtn setTitle:@"完成" forState:0];
//    }
}
#pragma  mark - -----------------请求数据-----------------

-(void)loadData{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:HOBBY forKey:@"rootType"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:listHobbiesByUser parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"我的兴趣%@",responseObject[@"data"]);
        self.listArray = (NSMutableArray*)[SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"我的兴趣%@",self.listArray);
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - setter
- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UICollectionView *)collectionView{
    if (!_collectionView ) {
        // 创建瀑布流布局
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,headerHeight1, SCREEN_W, SCREEN_H2-headerHeight1) collectionViewLayout:layout];
        [_collectionView registerClass:[SPMyInterestCell class] forCellWithReuseIdentifier:SPMyInterestCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionView.backgroundColor = RGBCOLORA(250, 250, 250,0.9);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return self.listArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPMyInterestCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPMyInterestCellID forIndexPath:indexPath];
      SPKungFuModel *model1 = self.listArray[indexPath.row];
    cell.model = model1;
//    cell.backgroundColor =RGBCOLORA(250, 250, 250, 0);
    cell.baseColor = [self findColorWithIndex:indexPath.row];
    return cell;
}

//返回的cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat wid = (SCREEN_W-80-2)/3;
//    if (indexPath.section == 1) {
        return CGSizeMake(wid,100);
//    }
//    return CGSizeMake(wid,wid/1.2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 40, 0, 40);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//根据section 选择对应的色调
-(UIColor *)findColorWithIndex:(NSInteger)indexSection{
    NSInteger x = indexSection%6;
    switch (x) {
        case 0:
            _cellColor = PURPLECOLOR;
            break;
        case 1:
            _cellColor = PRINKCOLOR;
            
            break;
        case 2:
            _cellColor = BULECOLOR;
            
            break;
        case 3:
            _cellColor = GREENCOLOR;
            
            break;
        case 4:
            _cellColor = ORANGECOLOR;
            
            break;
        case 5:
            _cellColor = REDCOLOR;
            
            break;
        default:
            break;
    }
    return _cellColor;
}

#pragma mark - event response - 点击事件处理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(SPMyHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SPMyHeader alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, headerHeight1)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        _tableHeader.alpha = 0.9;
        [_tableHeader setImg:[UIImage imageNamed:@"grxx_t"]];
    }
    return _tableHeader;
}

#pragma  mark sectionView点击 折叠或展开
- (void) headerViewClickedAction:(UITapGestureRecognizer *)sender
{
    SPKungFuModel *model1 = self.listArray[sender.view.tag];
    if ([model1.flag isEqualToString:@"NO"]) {
        model1.flag = @"YES";
    } else {
        model1.flag = @"NO";
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.view.tag];
    [self.collectionView reloadSections:set];
}

-(void)jump{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

-(void)next{
    
    self.needShow = NO;
    
    NSMutableArray *skillArr = [[NSMutableArray alloc]init];
    //遍历，将选择的标签 存储到数组
    for (SPKungFuModel *model1 in self.listArray) {
        if(model1.selected){
       [skillArr addObject:[NSString stringWithFormat:@"%@:%@:%@",model1.code,model1.value,model1.parentCode]];
        }
    }
    //将数组元素 用 "," 拼接（  10000000017:银行证券:10000000023,10000000042:家政服务:10000000022  ）
    NSString *skillSrt = [skillArr componentsJoinedByString:@","];
    NSLog(@"%@",skillSrt);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:skillSrt forKey:@"hobbyStr"];
    if (self.formMyCenter) {
        [self postMessage:dict pushToVC:@"onlyBack"];
    }else{
        [self postMessage:dict pushToVC:@"dismiss"];
    }
}

-(void)back{
    //拦截返回按钮 显示提示框
    [self showAliterView];
}
@end
