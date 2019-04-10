//
//  OneViewController.m
//  XWPopMenuVCDemo
//
//  Created by 邱学伟 on 16/5/17.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "SPMySkillForMakeMonery.h"
#import "SPAllCategoryVC.h"
#import "SPRightReusableView.h"
#import "SPKungFuModel.h"
#import "SPUser.h"
#import "SPLzsGetMoneyVC.h"
#import "SPDynamicCategoryCell.h"
@interface SPMySkillForMakeMonery ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)SPUser *user;
//存储的数组
@property (nonatomic, strong)NSMutableArray *dataArr;
//热门技能
@property (nonatomic, strong)NSMutableArray *hotArr;
@end

@implementation SPMySkillForMakeMonery

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[].mutableCopy;
    self.hotArr = @[].mutableCopy;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setNavigation];
    
    [self.view addSubview:self.collectionView];
    
    //查看全部分类
    [self checkAllSkill];
    
    //添加取消按钮->
    [self addCancelBtn];
    
    //请求数据
    [self getData];
    
    [self.navigationController  setNavigationBarHidden:NO animated:YES];
}

-(void)getData{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlGetSkill parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.dataArr = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self getHotSkill];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

//获取热门技能
-(void)getHotSkill{
    [[HttpRequest sharedClient]httpRequestGET:kUrlHotSkill parameters:nil
                                     progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                                         NSLog(@"%@",responseObject);
                                         self.hotArr = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                                         [self.collectionView reloadData];
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         
                                     }];
}

#pragma  mark - collectionDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArr.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section<self.dataArr.count) {
        SPKungFuModel *model2 = self.dataArr[section];
        
        return model2.subProperties.count;
    }
    
    return self.hotArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPDynamicCategoryCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDynamicCategoryCellID forIndexPath: indexPath];
    if (indexPath.section<self.dataArr.count) {
        SPKungFuModel *model2 = self.dataArr[indexPath.section];
        SPKungFuModel *model3 = model2.subProperties[indexPath.row];
        
    }else{
        
        SPKungFuModel *model3 = self.hotArr[indexPath.row];
//        [cell setImgUrl:model3.tagImg withName:model3.value code:model3.code];
    }
    
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
    [monthHeader changeTextProperty];
    
    if (indexPath.section<self.dataArr.count) {
        SPKungFuModel *model2 = self.dataArr[indexPath.section];
        monthHeader.name = model2.value;
        [monthHeader setFont:font(13)];
    }else{
        monthHeader.name = @"热门技能";
        [monthHeader setFont:font(16)];
    }
    
    return monthHeader;
}
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
    SPKungFuModel *model2 = nil;
    SPKungFuModel *model3  = nil;
    if (indexPath.section<self.dataArr.count) {
       model2 = self.dataArr[indexPath.section];
        model3 = model2.subProperties[indexPath.row];
    }else{
        
        model3 = self.hotArr[indexPath.row];
    }
    
    SPLzsGetMoneyVC *vc = [[SPLzsGetMoneyVC alloc]init];
    vc.skillCode = [NSString stringWithFormat:@"%@:%@:%@",model3.code,model3.value,model3.parentCode];
    vc.skill = model3.value;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setNavigation{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationItem.title = @"我要赚钱";
}

-(void)checkAllSkill{
    UIButton *allSkill = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight-50, SCREEN_W-80, 40)];
    allSkill.backgroundColor = PrinkColor;
    allSkill.layer.cornerRadius = 5;
    allSkill.clipsToBounds = YES;
    [allSkill setImage:[UIImage imageNamed:@""] forState:0];
    [allSkill setTitle:@"查看全部分类" forState:0];
    allSkill.titleLabel.font = font(14);
    [allSkill addTarget:self action:@selector(checkAll) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:allSkill];
}

-(void)checkAll{
     SPAllCategoryVC*vc = [[SPAllCategoryVC alloc]init];
    vc.formType = @"我要赚钱";
    [self.navigationController pushViewController:vc animated:YES];
}

//添加取消按钮->
-(void)addCancelBtn{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setFrame:CGRectMake(20, 20, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: cancelBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}

#pragma mark - 完成发布
//完成发布
-(void)finishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
     [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UILabel *titile = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, SCREEN_W, 40)];
        titile.text = @"我的技能";
        titile.font = font(16);
        [self.view addSubview:titile];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.scrollDirection =     UICollectionViewScrollDirectionVertical;
        
        layout.itemSize = CGSizeMake((SCREEN_W-140)/3, 80);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W, SCREEN_H2-40-SafeAreaTopHeight-SafeAreaBottomHeight-60) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
   
        [_collectionView registerClass:[SPDynamicCategoryCell class] forCellWithReuseIdentifier:SPDynamicCategoryCellID];
        [_collectionView registerClass:[SPRightReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPRightReusableViewID];        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
@end

