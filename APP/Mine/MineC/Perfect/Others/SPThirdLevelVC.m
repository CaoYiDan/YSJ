//
//  SPThirdLevelVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPThirdLevelVC.h"
#import "SPThirdLevelCell.h"
@interface SPThirdLevelVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UICollectionView *collectionView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@end

@implementation SPThirdLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图片
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    self.nextBtn.hidden = YES;
    self.jumpBtn.hidden = YES;
    //tableview
    [self.view insertSubview:self.collectionView atIndex:1];
    //请求数据
    [self loadData];
}

-(void)loadData{
    [[HttpRequest sharedClient]httpRequestGET:kUrlListSkill parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
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
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[SPThirdLevelCell class] forCellWithReuseIdentifier:SPThirdLevelCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alpha = 0.8;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPThirdLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPThirdLevelCellID forIndexPath:indexPath];
    if(indexPath.row%2==0){
     [cell setText:@"人生苦"];
    }else{
    [cell setText:@"人生苦kuduan"];
    }
    
    return cell;
}

//返回的cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_W/4, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

#pragma  mark 返回的header视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_W, 40);
}

#pragma  mark //返回Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_W, 40)];
    title.text =@"遇见";
    [header addSubview:title];
    
    return header;
}

#pragma mark - event response - 点击事件处理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}


@end
