//
//  YSJSwitchView.m
//  SmallPig
//
//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJTextCell.h"
#import "YSJSwitchView.h"
@interface  YSJSwitchView()<UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@end
@implementation YSJSwitchView
{
    UIView *_line;
    NSInteger _selectedIndex;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCollection];
    }
    return self;
}

-(void)setListArr:(NSArray *)listArr{
    
    _listArr = listArr;
    [self.collectionview reloadData];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
   YSJTextCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"normal" forIndexPath:indexPath];
  
    cell.textStr = self.listArr[indexPath.row][@"name"];

    cell.ifSelected = _selectedIndex==indexPath.row;

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
    _selectedIndex = indexPath.row;
    
    [self.collectionview reloadData];
    
    [self.delegate switchViewDidSelectedIndexRow: indexPath.row];
}

-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_W/5,44);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,44) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
  _collectionview.backgroundColor=[UIColor clearColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[YSJTextCell class] forCellWithReuseIdentifier:@"normal"];
   
    [self addSubview:_collectionview];
    
}
@end
