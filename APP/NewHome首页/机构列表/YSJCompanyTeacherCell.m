//
//  YSJHomeTableViewCell.m
//  SmallPig
//


#import "YSJCompanyTeacherCell.h"
#import "SPUser.h"
#import "YSJTeacherModel.h"
#import "YSJHomeTableViewCell.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJStudent_DetailVC.h"
#import "YSJCompany_DetailVC.h"
#import "SPCommon.h"
#import "YSJTeacherForCompanyCollectionCell.h"
#import "YSJCompanyCell.h"
#import "YSJRequimentCell.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
@interface YSJCompanyTeacherCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;

@end

@implementation YSJCompanyTeacherCell


-(void)setListArr:(NSArray *)listArr{
    
    _listArr = listArr;
    [self.collectionview reloadData];
}

- (void)initUI{
    // 初始化原创UI
    [self creatCollection];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSJTeacherForCompanyCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJTeacherCollectionCellID forIndexPath:indexPath];
    cell.dic = self.listArr[indexPath.row];
    //    cell.userModel= self.listArr[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
}

#pragma  mark - -----------创建 collection----------------

-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat cellH = 150;
  
    layout.itemSize = CGSizeMake(SCREEN_W/4, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width-40,cellH) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    
    [_collectionview registerClass:[YSJTeacherForCompanyCollectionCell class] forCellWithReuseIdentifier:YSJTeacherCollectionCellID];
    
    [self addSubview:_collectionview];
    
}

-(void)more{
    //    !self.moreBlock?:self.moreBlock();
}

@end
