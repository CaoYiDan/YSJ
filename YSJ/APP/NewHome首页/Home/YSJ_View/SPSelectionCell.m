//
//  SPSelectionCell.m
//  SmallPig

#import "SPSelectionCell.h"
#import "SPUser.h"
#import "YSJTeacherModel.h"
#import "SPSelectionCollectionCell.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJStudent_DetailVC.h"
#import "YSJCompany_DetailVC.h"
#import "SPCommon.h"
#import "YSJTeacherCell.h"
#import "YSJCompanyCell.h"
#import "YSJRequimentCell.h"
#import "YSJCompanysModel.h"
#import "YSJRequimentModel.h"
@interface SPSelectionCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;

@end

@implementation SPSelectionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andCellType:(YSJHomeCellType)ceType
{
    SPSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectionCellID"];
    if (cell==nil) {
    
        cell = [[SPSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectionCellID" WithCellType:ceType];
        
    }
    return cell;
}

/**
*  cell的初始化方法，一个cell只会调用一次
*  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithCellType:(YSJHomeCellType)ceType;
{
    self.cellType = ceType;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
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
    
//    // 每次先从字典中根据IndexPath取出唯一标识符
//    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
//    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
//    if (identifier == nil) {
//        identifier = [NSString stringWithFormat:@"%@%@",@"collectionID", [NSString stringWithFormat:@"%@", indexPath]];
//        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
//        // 注册Cell
//        [self.collectionview registerClass:[LGHotActivityCell class]  forCellWithReuseIdentifier:identifier];
//    }
    NSLog(@"%u",self.cellType);
    if (self.cellType == HomeCellTeacher) {
        YSJTeacherCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJTeacherCellID forIndexPath:indexPath];
            cell.model = self.listArr[indexPath.row];
        //    cell.userModel= self.listArr[indexPath.row];
        return cell;
    }else if (self.cellType == HomeCellCompany){
        YSJCompanyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJCompanyCellID forIndexPath:indexPath];
               cell.model = self.listArr[indexPath.row];
        return cell;
    }else if (self.cellType == HomeCellRequiment){
        YSJRequimentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJRequimentCellID forIndexPath:indexPath];
         cell.model = self.listArr[indexPath.row];
        return cell;
    }
   
    return [[UICollectionViewCell alloc]init];
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
    //没有登录，就弹出登录界面
//    if ([SPCommon gotoLogin]) return;
    
    
    if (self.cellType == HomeCellCompany) {
        
        YSJCompanysModel *model  = self.listArr[indexPath.row];
        
        YSJCompany_DetailVC *vc = [[YSJCompany_DetailVC alloc]init];
        
        vc.companyID = model.companyID;
        
        [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
    }else if (self.cellType == HomeCellTeacher){
        YSJTeacherModel *model  = self.listArr[indexPath.row];
        
        YSJTeacher_DetailVC *vc = [[YSJTeacher_DetailVC alloc]init];
//        vc.M = model;
        vc.teacherID = model.teacherID;
        
        [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
    }else if (self.cellType == HomeCellRequiment){
        YSJRequimentModel *model  = self.listArr[indexPath.row];
        
        YSJStudent_DetailVC *vc = [[YSJStudent_DetailVC alloc]init];
        
        vc.model = model;
        
        vc.studentID = model.requimentID;
        
        [[SPCommon getCurrentVC].navigationController  pushViewController:vc animated:YES];
    }
    
}

#pragma  mark - -----------创建 collection----------------

-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat cellH = SCREEN_W/3+50;
    
    if (self.cellType == HomeCellCompany) {
        cellH = SCREEN_W/3+80;
    }
    
   layout.itemSize = CGSizeMake(SCREEN_W/3, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width-2*kMargin,cellH) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    
     [_collectionview registerClass:[YSJTeacherCell class] forCellWithReuseIdentifier:YSJTeacherCellID];
     [_collectionview registerClass:[YSJCompanyCell class] forCellWithReuseIdentifier:YSJCompanyCellID];
    [_collectionview registerClass:[YSJRequimentCell class] forCellWithReuseIdentifier:YSJRequimentCellID];
    [self addSubview:_collectionview];
    
}

-(void)more{
//    !self.moreBlock?:self.moreBlock();
}

@end
