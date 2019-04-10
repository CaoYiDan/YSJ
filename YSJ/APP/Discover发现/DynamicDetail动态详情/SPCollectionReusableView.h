////
////  SPDynamicDetialVC.m
////  SmallPig
////
////  Created by 融合互联-------lisen on 17/6/30.
////  Copyright © 2017年 李智帅. All rights reserved.
////
//
//#import "SPDynamicDetialVC.h"
//#import "SPUserNavTitleView.h"
//#import "SPDyDetailImgCell.h"
//#import "SPDyDetailEvaluateCell.h"
//#import "SPDynamicModel.h"
//#import "SDPhotoBrowser.h"
//#import "SPFooterView.h"
//#import "NSString+getSize.h"
//@interface SPDynamicDetialVC ()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>
////collection
//@property(nonatomic,strong)UICollectionView*collectionview;
//@property(nonatomic,strong)NSMutableArray *listArray;
//@property(nonatomic,strong)NSMutableArray *imgHeightArr;//图片高度数组
//@end
//
//@implementation SPDynamicDetialVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self sNav];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self collectionview];
//    //    //1.获取一个全局串行队列
//    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //    //2.把任务添加到队列中执行
//    //    dispatch_async(queue, ^{
//    //
//    //        for (int i = 0;i<(self.model.imgs.count>4?4:self.model.imgs.count);i++) {
//    //
//    //            //3.获取加载的图片的大小，然后按比例返回高度
//    //            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[i]]];
//    //            UIImage *image = [UIImage imageWithData:data];
//    //            [self.imgHeightArr addObject:@(image.size.height/image.size.width*SCREEN_W)];
//    //        }
//    //            //4.回到主线程，创建UI
//    //            dispatch_async(dispatch_get_main_queue(), ^{
//    //            [MBProgressHUD hideHUDForView:self.view animated:YES];
//    //                //创建collectionView
//    //                [self.collectionview reloadData];
//    //            });
//    //        });
//}
//
////请求数据
//-(void)load{
//    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
//    [dict setObject:@"1" forKey:@"pageNum"];
//    [dict setObject:@"10" forKey:@"pageSize"];
//    
//    [[HttpRequest sharedClient]httpRequestPOST:kUrlActivityList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
//        self.listArray = responseObject[@"data"];
//        [self.collectionview reloadData];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        Toast(@"网络错误");
//    }];
//}
//
//-(void)sNav{
//    SPUserNavTitleView *titleView = [[SPUserNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
//    titleView.backgroundColor = [UIColor whiteColor];
//    titleView.model = self.model;
//    self.navigationItem.titleView = titleView;
//    //创建手势对象
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tap:)];
//    //配置属性
//    //轻拍次数
//    tap.numberOfTapsRequired =1;
//    //轻拍手指个数
//    tap.numberOfTouchesRequired =1;
//    //讲手势添加到指定的视图上
//    [titleView addGestureRecognizer:tap];
//}
//#pragma mark - UICollectionViewDelegate
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if(section==0){
//        return self.model.imgs.count>4?4:self.model.imgs.count;
//    }else{
//        return 2;
//    }
//}
//
//-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section ==0) {
//        SPDyDetailImgCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailImgCellID forIndexPath:indexPath];
//        cell.imgUrl = self.model.imgs[indexPath.row];
//        return cell;
//    } else if (indexPath.section ==1) {
//        SPDyDetailEvaluateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailEvaluateCellID forIndexPath:indexPath];
//        return cell;
//    }
//    
//    return [[UICollectionViewCell alloc]init];
//}
//
////返回的cell大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat h = 0;
//    if (indexPath.section ==0) {
//        
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[indexPath.row]]];
//        UIImage *image = [UIImage imageWithData:data];
//        h = image.size.height/image.size.width*SCREEN_W;
//        
//        //        [self.imgHeightArr addObject:@(image.size.height/image.size.width*SCREEN_W);
//    }else{
//        h=200;
//    }
//    return CGSizeMake(SCREEN_W, h);
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    if (section==0) return UIEdgeInsetsMake(10, 0,5, 0);
//    
//    return UIEdgeInsetsMake(1, 1, 5, 1);
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    if (section==0)  return 0;
//    return 2;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//#pragma  mark 返回的header视图大小
////- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
////    return  CGSizeMake(SCREEN_W, 200);
////}
//
//#pragma  mark 返回的footer视图大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    if (section==0) {
//        CGFloat maxW = SCREEN_W-20;
//        //根据字数多少返回对应的高度
//        CGSize contentSize = [self.model.text sizeWithFont:kFontNormal maxW:maxW];
//        return  CGSizeMake(SCREEN_W, contentSize.height+80);
//    }
//    return CGSizeZero;
//}
//
//#pragma  mark //返回Header视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    if (kind==UICollectionElementKindSectionFooter) {
//        SPFooterView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];;
//        footer.backgroundColor = [UIColor whiteColor];
//        [footer setImg:@[@"http://f10.baidu.com/it/u=1981748892,3031683197&fm=72",@"http://f10.baidu.com/it/u=1981748892,3031683197&fm=72"] andTotalNumber:12 content:self.model.text];
//        return footer;
//    }
//    return nil;
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
//        photoBrowser.delegate = self;
//        photoBrowser.currentImageIndex = indexPath.row;
//        photoBrowser.imageCount = self.model.imgs.count;
//        photoBrowser.sourceImagesContainerView = collectionView;
//        [photoBrowser show];
//    }
//}
//
//#pragma mark - SDPhotoBrowserDelegate
//
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *urlString = self.model.imgs[index];
//    return [NSURL URLWithString:urlString];
//}
//
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    UIImageView *imageView = [[UIImageView alloc]init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imgs[index]]];
//    
//    return imageView.image;
//}
//
//#pragma  mark - setter
//#pragma  mark 创建collectionView
//-(UICollectionView*)collectionview{
//    if (!_collectionview) {
//        
//        // 创建瀑布流布局
//        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
//        
//        _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,SCREEN_H) collectionViewLayout:layout];
//        //代理
//        _collectionview.delegate=self;
//        _collectionview.dataSource=self;
//        _collectionview.backgroundColor=[UIColor whiteColor];
//        _collectionview.showsVerticalScrollIndicator = NO;
//        _collectionview.showsHorizontalScrollIndicator = NO;
//        [_collectionview registerClass:[SPDyDetailImgCell class] forCellWithReuseIdentifier:SPDyDetailImgCellID];
//        [_collectionview registerClass:[SPDyDetailEvaluateCell class] forCellWithReuseIdentifier:SPDyDetailEvaluateCellID];
//        [_collectionview registerClass:[SPFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
//        [self.view addSubview:_collectionview];
//    }
//    return _collectionview;
//}
//
//- (NSMutableArray *)listArray
//{
//    if (_listArray == nil) {
//        _listArray = [NSMutableArray array];
//    }
//    return _listArray;
//}
//
//- (NSMutableArray *)imgHeightArr
//{
//    if (_imgHeightArr == nil) {
//        _imgHeightArr = [NSMutableArray array];
//    }
//    return _imgHeightArr;
//}
//
//-(void)tap:(UITapGestureRecognizer*)gesture{
//    
//}
//@end
