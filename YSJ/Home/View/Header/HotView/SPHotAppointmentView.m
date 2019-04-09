//
//  SPHotAppointmentView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPHotCollectionViewCell.h"
#import "SPHotAppointmentView.h"
#import "SPProfileVC.h"
#import "SelectionViewController.h"
@interface SPHotAppointmentView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView*collectionview;

@end
@implementation SPHotAppointmentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cUI];
    }
    return self;
}

-(void)cUI{
    // 初始化原创UI
    [self addTitle];
    [self creatCollection];
    [self addLine];
}

-(void)addTitle{
    UIButton *title = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    title.backgroundColor  = [UIColor whiteColor];
    [title setTitleColor:[UIColor blackColor] forState:0];
    [title setImage:[UIImage imageNamed:@"sy_ry"] forState:0];
    [title addTarget:self
              action:@selector(more) forControlEvents:UIControlEventTouchDown];
    [title setTitle:@" 热约" forState:0];
    title.titleLabel.font = BoldFont(16);
    [self addSubview:title];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-32, 5, 20, 30)];
    
    [arrowImg setImage:[UIImage imageNamed:@"sy_ryf"]];
    [self addSubview:arrowImg];
}

-(void)addLine{
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = [UIColor grayColor];
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(0);
//        make.size.mas_offset(CGSizeMake(SCREEN_W-10, 1));
//        make.left.offset(10);
//    }];
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
    
    SPHotCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPHotCollectionViewCellID forIndexPath:indexPath];
    cell.hotDict= self.listArr[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) return UIEdgeInsetsMake(0, 10, 1, 10);
    
    return UIEdgeInsetsMake(1, 1, 5, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0)  return 20;
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
//    SPUser *user  = self.listArr[indexPath.row];
//
    NSDictionary *dic = self.listArr[indexPath.row];
    
   SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code = dic[@"code"];
    vc.titleName = dic[@"nickName"];
    [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
}

#pragma  mark - -----------创建 collection----------------

-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_W-12*2-2*10)/3, SCREEN_W/3+40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, [UIScreen mainScreen].bounds.size.width,SCREEN_W/3+40) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPHotCollectionViewCell class] forCellWithReuseIdentifier:SPHotCollectionViewCellID];
    [self addSubview:_collectionview];
    
}

-(void)more{
    //    !self.moreBlock?:self.moreBlock();
    SelectionViewController *vc = [[SelectionViewController alloc]init];
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}
@end
