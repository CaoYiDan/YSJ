//
//  SPCategoryRightTabCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCategoryRightTabCell.h"
#import "SPKungFuModel.h"
#import "SPOneCategoryListVC.h"
#import "SPRightReusableView.h"
#import "SPDynamicCategoryCell.h"
#import "SPLzsGetMoneyVC.h"
#import "SPFindPeopleVC.h"
@interface SPCategoryRightTabCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *lable;
@end
@implementation SPCategoryRightTabCell
{
    UILabel *_textLab;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //二级分类--contentViewcell（tableView嵌套collectionView）
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
//            make.left.top.offset(0);
//            make.height.offset(200);
//            make.right.offset(-50);
//            make.height.offset(600);
            
        }];
        
//        _textLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
//        _textLab.backgroundColor = [UIColor orangeColor];
//        [self.superview addSubview:_textLab];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

//赋值
-(void)setSecondLevelDataArr:(NSMutableArray *)secondLevelDataArr{
    _secondLevelDataArr = secondLevelDataArr;
    [self.collectionView reloadData];
   
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
//        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        
        
        layout.scrollDirection =     UICollectionViewScrollDirectionVertical;
        
        layout.itemSize = CGSizeMake((SCREEN_W-140)/3, 80);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.userInteractionEnabled = NO;
//        _collectionView.bounces = NO;
        [_collectionView registerClass:[SPDynamicCategoryCell class] forCellWithReuseIdentifier:SPDynamicCategoryCellID];
        
        [_collectionView registerClass:[SPRightReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPRightReusableViewID];
        _collectionView.backgroundColor = CategoryBaseColor;
    }
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.secondLevelDataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    SPKungFuModel *model2 = self.secondLevelDataArr[section];
    
    return model2.subProperties.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPDynamicCategoryCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDynamicCategoryCellID forIndexPath: indexPath];
    
    SPKungFuModel *model2 = self.secondLevelDataArr[indexPath.section];
    SPKungFuModel *model3 = model2.subProperties[indexPath.row];
   
    return cell;
}

#pragma  mark 返回的header视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(kWindowW-100, 30);
}

#pragma  mark 返回Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    SPRightReusableView *monthHeader =
    [collectionView dequeueReusableSupplementaryViewOfKind:
     UICollectionElementKindSectionHeader
                                       withReuseIdentifier:SPRightReusableViewID forIndexPath:indexPath];
    SPKungFuModel *model2 = self.secondLevelDataArr[indexPath.section];
    monthHeader.name = model2.value;
    return monthHeader;
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    CGRect frame1 = [self.collectionView convertRect:_monthHeader.frame fromView:scrollView];
////    NSLog(@"%f",frame1.origin.y);
//    NSLog(@"%f",scrollView.contentOffset.y);
//    self.collectionView.userInteractionEnabled = NO;
//    
////    self.collectionView.contentSize = CGSizeMake(0, self.frameHeight-10);
//}
//
////减速停止了时执行，手触摸时执行执行
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
//
//{
//    
//    NSLog(@"scrollViewDidEndDecelerating");
//    self.collectionView.userInteractionEnabled = NO;
//
//    
//}

-(void)canClick{
    self.collectionView.userInteractionEnabled = YES;
}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    self.collectionView.userInteractionEnabled = YES;
//}
//
//-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
//   self.collectionView.userInteractionEnabled = YES;
//
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SPKungFuModel *model2 = self.secondLevelDataArr[indexPath.section];
   SPKungFuModel *model3 = model2.subProperties[indexPath.row];

//    SPLzsGetMoneyVC *vc = [[SPLzsGetMoneyVC alloc]init];
    NSLog(@"%@",self.type);
    if ([self.type isEqualToString:@"我要赚钱"]) {
        
        SPLzsGetMoneyVC *vc = [[SPLzsGetMoneyVC alloc]init];
        vc.skillCode = [NSString stringWithFormat:@"%@:%@:%@",model3.code,model3.value,model2.code];
        vc.skill = model3.value;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    }else if([self.type isEqualToString:@"我要找人"]){
        SPFindPeopleVC*vc = [[SPFindPeopleVC alloc]init];
//        vc.skillCode = [NSString stringWithFormat:@"%@:%@:%@",model3.code,model3.value,model2.code];
        vc.skill = model3.value;
        vc.code = model3.code;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([self.type isEqualToString:@"首页"]){
        
      SPOneCategoryListVC *vc =[[SPOneCategoryListVC alloc]init];
        vc.skillCode = model3.code;
        vc.titleName = model3.value;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
}

-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

  NSLog(@"将要展示%lu   %lu",indexPath.row,indexPath.section);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"已经展示%lu   %lu",indexPath.row,indexPath.section);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
   
    CGPoint point = [touch  locationInView:self.collectionView];
    
    NSLog(@"%f--%f",point.x,point.y);
}
@end
