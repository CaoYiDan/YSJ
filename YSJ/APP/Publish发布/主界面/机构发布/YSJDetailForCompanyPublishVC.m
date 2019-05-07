//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "YSJHeaderForPublishCompanyView.h"
#import "YSJTeacherForCompanyCollectionCell.h"
#import "YSJPopTextFiledView.h"
#import "LGTextView.h"
#import "SLLocationHelp.h"
#import "LGComposePhotosView.h"
#import "SPPublishLimitVC.h"
#import "SPPublishLocationVC.h"
#import "YSJChoseTeachersVC.h"
#import "YSJDetailForCompanyPublishVC.h"
#import "ZLPhotoActionSheet.h"

#import "SPCommon.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface YSJDetailForCompanyPublishVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ChoseTeacherDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;

@property(nonatomic,assign) CGFloat headerH;

@property (nonatomic,strong) YSJHeaderForPublishCompanyView *headerView;

@property (nonatomic,strong) NSMutableArray *listArr;

/**
 上课时间
 */
@property (nonatomic,strong) YSJPopTextFiledView *classTime;
/**
 课时数
 */
@property (nonatomic,strong) YSJPopTextFiledView *classNums;

@end

@implementation YSJDetailForCompanyPublishVC
{
    NSInteger _limitIndex;
    NSInteger _locationIndex;
   
    BOOL _locationEnabled;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程详情";
    _headerH = 380;
    [self creatCollection];
    [self setBottomView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}





#pragma mark - textViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self countWord:textView.text]>500) {
        Toast(@"您已超出了最大输入字符限制");
        return NO;
    }
    return YES;
}

-(int)countWord:(NSString *)s
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
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

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, _headerH);
    return size;
}

#pragma mark header

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    YSJHeaderForPublishCompanyView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSJHeaderForPublishCompanyViewID" forIndexPath:indexPath];
    if (!view) {
        view = [[YSJHeaderForPublishCompanyView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, _headerH)];
    }
    
    self.headerView = view;
    WeakSelf;
    view.block = ^(CGFloat h) {
        //返回 0 ,约定的是点击了“添加老师”按钮
        if (h==0) {
            #pragma mark  跳转到选择老师
            YSJChoseTeachersVC *vc = [[YSJChoseTeachersVC alloc]init];
            vc.delegate = weakSelf;
            vc.selectedArr = weakSelf.listArr.mutableCopy;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
             //返回 不是0 ,约定的返回的“h” 是添加图片引发的header的高度的动态变化高度
            weakSelf.headerH = 380+h;
            [weakSelf.collectionview reloadData];
        }
    };
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 选择老师代理

- (void)choseTeacherFinishWithArr:(NSMutableArray *)teacherArr{
    self.listArr = teacherArr;
    [self.collectionview reloadData];
}

-(void)creatCollection{
    
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat cellH = 150;
    
    layout.itemSize = CGSizeMake(SCREEN_W/4, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kWindowW,kWindowH-SafeAreaTopHeight-KBottomHeight) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    
    [_collectionview registerClass:[YSJTeacherForCompanyCollectionCell class] forCellWithReuseIdentifier:YSJTeacherCollectionCellID];
    [_collectionview registerClass:[YSJHeaderForPublishCompanyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSJHeaderForPublishCompanyViewID"];
    
    [self.view addSubview:_collectionview];
    
}
- (NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = @[].mutableCopy;
    }
    return _listArr;
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"保存" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

-(void)save{
    
    if (isEmptyString(self.headerView.textView.text) || self.headerView.photos.count==0 || self.listArr.count==0) {
        Toast(@"请填写完整信息");
        return;
    }
    
    //将company_teacher_id提取出来
    NSMutableArray *teacherIdArr = @[].mutableCopy;
    for ( NSDictionary *dic  in self.listArr) {
        [teacherIdArr addObject:dic[@"company_teacher_id"]];
    }
    
    [self.delegate getDetailText:self.headerView.textView.text courseImgArr:self.headerView.photos teacherIdArr:teacherIdArr];
   
    [self.navigationController popViewControllerAnimated:YES];
}

@end
