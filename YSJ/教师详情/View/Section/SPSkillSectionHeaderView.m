//
//  SPSkillSectionHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSkillSectionHeaderView.h"
#import "SPProfileSkillCell.h"
#import "SPLucCommentModel.h"
#import "SPPublishModel.h"
@interface SPSkillSectionHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;

@end

@implementation SPSkillSectionHeaderView
{
    UILabel *_title;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self setTitle];
    [self creatCollection];
   
}

-(void)setTitle{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 5, SCREEN_W-2*kMargin, 30)];
    _title = title;
    title.font = kFontNormal_14;
    title.text = @"TA的技能";
    [self addSubview:title];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.categoryArr.count;
}

#pragma  mark 返回 UICollectionViewCell*
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPProfileSkillCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPProfileSkillCellID forIndexPath:indexPath];
    SPLucCommentModel *lucM = self.categoryArr[indexPath.row];
    SPPublishModel *skillM = lucM.lucrativetDto;
    [cell setImgUrl:skillM.skillImg withName:skillM.skill code:skillM.code];
    return cell;
}

#pragma  mark 返回的cell大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_W/4, 80);
}

#pragma  mark 边缘大小

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma  mark cell水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma  mark 竖间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate SPSkillSectionHeaderViewDidSelectedIndex:indexPath.row];
}

#pragma  mark 创建collectionView
-(void)creatCollection{
   
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, [UIScreen mainScreen].bounds.size.width,80) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPProfileSkillCell class] forCellWithReuseIdentifier:SPProfileSkillCellID];
    [self addSubview:_collectionview];
}

//数据赋值
-(void)setCategoryArr:(NSMutableArray *)categoryArr{
    _categoryArr = categoryArr;
    if (_categoryArr.count == 0) {
        _title.text= @"他还没有发布过技能";
        
        _title.textColor = [UIColor grayColor];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    [_collectionview reloadData];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self setSelectedCell];
}

-(void)setSelectedCell{
     [self.collectionview selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
   
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionview.contentOffset = CGPointMake(SCREEN_W/4*self.selectedIndex, 0);
    }];
    
}
@end
