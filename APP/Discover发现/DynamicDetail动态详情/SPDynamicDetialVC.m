//
//  SPDynamicDetialVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicDetialVC.h"
#import "SPUserNavTitleView.h"
#import "SPDyDetailImgCell.h"
#import "SPDyDetailEvaluateCell.h"
#import "SPDynamicModel.h"
#import "SDPhotoBrowser.h"
#import "UIImage+XW.h"
#import "SPFooterView.h"
#import "NSString+getSize.h"
#import "SPCommentModel.h"
#import "SPDyDetailBottomView.h"
#import "CMInputView.h"
#import "LGAnswerVC.h"
#import "SPEvaluateEditVC.h"
//分享
#import "SPShareView.h"

@interface SPDynamicDetialVC ()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>

//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *imgHeightArr;//图片高度数组
@property(nonatomic,strong)NSMutableArray *praiseArr;//点赞数组
@property(nonatomic,strong)NSMutableArray *conmentArr;//评论数组
@property(nonatomic,strong)NSMutableArray *conmentHeightArr;//评论数组高度
@property(nonatomic,assign)BOOL shat;//关闭
@property(nonatomic,strong)SPDyDetailBottomView *toolView;//底部控件
@property(nonatomic,strong)UIView *moreView;
@property(nonatomic,strong)SPUserNavTitleView *titleView;

//分享
@property(nonatomic,strong)SPShareView *shareView;
@end

@implementation SPDynamicDetialVC
{
    CGFloat keyHeight;//键盘高度
}
#pragma  mark - -----------------lefecycle-----------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sNav];
    [self load];
    [self.view addSubview:self.toolView];
    
    if (self.model) {
        //异步计算图片的高度
        [self calculateImgHeight];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
        
    [super viewWillDisappear:animated];
        
}
    
//计算图片的高度
-(void)calculateImgHeight{
    
    if (self.model.imgs.count==0) return;
    
    @try {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            CGFloat totalH = 0;
            for (int i = 0;i<self.model.imgs.count;i++) {
                
                //3.获取加载的图片的大小，然后按比例返回高度  并返回image.
                UIImage *image = [self createImgHeightArrAt:i];
                
                totalH += image.size.height/image.size.width*SCREEN_W;
                NSLog(@"%f",totalH);
#warning  如果 图片总高度超出了总屏幕的高度，则停止计算，直接刷新，在页面滑动的时候，再加载剩余的图片
                if (totalH >SCREEN_H3 || i == self.model.imgs.count-1) {
                    //4.回到主线程，创建UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                        //创建collectionView
                        [self.collectionview reloadData];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                    return ;
                }
            }
        });

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    }

-(UIImage *)createImgHeightArrAt:(NSInteger)index{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[index]]];
    UIImage *image = [UIImage imageWithData:data];
    double sizeH = image.size.height/image.size.width*SCREEN_W;
    
    if (!isnan(sizeH)) {
        [self.imgHeightArr addObject:@(sizeH)];
    }else{
        [self.imgHeightArr addObject:@(200)];
    }

    return image;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     self.collectionview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

-(void)load{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:isEmptyString(self.model.code)?self.feedCode:self.model.code forKey:@"feedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"readerCode"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedGet parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
    
        /** 点赞--数据较少 未生成模型*/
        self.praiseArr = responseObject[@"data"][@"praiseList"];
        
        /** 评论*/
        self.conmentArr = responseObject[@"data"][@"commentList"];
        
         /** 评论cell返回的高度*/
        self.conmentHeightArr = [self getCommentHeightArr];
        
        //给底部toolview 赋值
        [self.toolView setPrasizedCount:self.praiseArr.count evaluateNum:self.conmentArr.count ifPrasized:[responseObject[@"data"][@"praised"] boolValue]];
        
        if (!self.model) {
            self.model = [SPDynamicModel mj_objectWithKeyValues:responseObject[@"data"]];
            //根据model配置
            [self configWithModel];
        }
        
       [self.collectionview reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"网络错误");
    }];
}

//根据model配置
-(void)configWithModel{
    self.titleView.model = self.model;
    self.toolView.feedCode = self.model.code;
    [self setRight];
    [self calculateImgHeight];
}

-(NSMutableArray *)getCommentHeightArr{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    /** 评论cell返回的高度*/
    for (NSDictionary *dic in self.conmentArr) {
        
      [arr addObject:@([self getContentHeightWithDict:dic])];
    }
    return arr;
}

-(CGFloat)getContentHeightWithDict:(NSDictionary *)dic{
    
    CGFloat maxW = SCREEN_W - 75;
    CGSize contentSize  = CGSizeZero;
    //因为 评论有两种类型 1.开始 拼接 “回复。。” 2.直接评论，
    if ([dic[@"type"] isEqualToString:@"COMMENT"]) {//1.评价回复
        
        contentSize = [[NSString stringWithFormat:@" 回复:%@ %@",dic[@"beCommentedUserName"],dic[@"content"]] sizeWithFont:kFontNormal maxW:maxW];
        
    }else{ //直接回复
        contentSize = [dic[@"content"] sizeWithFont:kFontNormal_14 maxW:maxW];
    }
    NSInteger H = contentSize.height;
    return H+80;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return self.imgHeightArr.count;
    }else{
        return self.conmentArr.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {//大图
        SPDyDetailImgCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailImgCellID forIndexPath:indexPath];
        if (indexPath.row >=self.model.imgs.count) {
            return cell;
        }
        cell.imgUrl = self.model.imgs[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    } else if (indexPath.section ==1) {//评价
        SPDyDetailEvaluateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailEvaluateCellID forIndexPath:indexPath];
        NSDictionary *dict = self.conmentArr[indexPath.row];
        [cell setDic:dict andHeight:[self.conmentHeightArr[indexPath.row] doubleValue]];
        return cell;
    }
    
    return [[UICollectionViewCell alloc]init];
}

//返回的cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0;
    
    if (indexPath.section == 0) {
//        NSLog(@"%lu",(unsigned long)self.imgHeightArr.count);
//        h=200;
       h = [self.imgHeightArr[indexPath.row] doubleValue];

//        NSLog(@"%f",[self.imgHeightArr[indexPath.row] doubleValue]);
        
    }else{
        
        h= [self.conmentHeightArr[indexPath.row] doubleValue];
        
    }
    return CGSizeMake(SCREEN_W, h);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) return UIEdgeInsetsMake(10, 0,5, 0);
    
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0)  return 0;
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma  mark 返回的footer视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        CGFloat maxW = SCREEN_W-20;
        //根据字数多少返回对应的高度
        CGSize contentSize = [self.model.text sizeWithFont:kFontNormal maxW:maxW];
        return  CGSizeMake(SCREEN_W, contentSize.height+60);
    }
    return CGSizeZero;
}

#pragma  mark 返回Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        SPFooterView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];;
        footer.backgroundColor = [UIColor whiteColor];
        [footer setArr:self.praiseArr content:self.model.text];
        return footer;
    }
    return [[UICollectionReusableView alloc]init];
}

#pragma  cell 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//查看大图
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        
        photoBrowser.currentImageIndex = indexPath.row;
        photoBrowser.imageCount = self.model.imgs.count;
        photoBrowser.sourceImagesContainerView = collectionView;
        [photoBrowser show];
        
    }else if (indexPath.section == 1){//回复评价
        if (![SPCommon gotoLogin]) {
            NSDictionary *dic = self.conmentArr[indexPath.row];
            
            LGAnswerVC *vc = [[LGAnswerVC alloc]init];
            vc.code = dic[@"code"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma  mark ---- 在页面滑动的时候，再加载剩余的图片
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.model.imgs.count>self.imgHeightArr.count && !self.shat) {
        
        self.shat = YES;
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            for (int i = (int)self.imgHeightArr.count;i<self.model.imgs.count;i++) {
                
            //3.获取加载的图片的大小，然后按比例返回高度
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[i]]];
            UIImage *image = [UIImage imageWithData:data];
            [self.imgHeightArr addObject:@(image.size.height/image.size.width*SCREEN_W)];
            
            }
            //4.回到主线程，创建UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //刷新 section ==0 的界面
                [self.collectionview reloadData];
            });
        });
    }
    
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.model.imgs[index];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imgs[index]]];
    
    return imageView.image;
}

#pragma  mark - setter
#pragma  mark 创建collectionView
-(UICollectionView*)collectionview{
    if (!_collectionview) {
        
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
        _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,SCREEN_W,SCREEN_H2-SafeAreaTopHeight-50-SafeAreaBottomHeight)collectionViewLayout:layout];
    _collectionview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPDyDetailImgCell class] forCellWithReuseIdentifier:SPDyDetailImgCellID];
    [_collectionview registerClass:[SPDyDetailEvaluateCell class] forCellWithReuseIdentifier:SPDyDetailEvaluateCellID];
    [_collectionview registerClass:[SPFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    [self.view addSubview:_collectionview];
    }
    return _collectionview;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (NSMutableArray *)imgHeightArr
{
    if (_imgHeightArr == nil) {
        _imgHeightArr = [NSMutableArray array];
        }
    return _imgHeightArr;
}

- (NSMutableArray *)praiseArr
{
    if (_praiseArr == nil) {
        _praiseArr = [NSMutableArray array];
    }
    return _praiseArr;
}

- (NSMutableArray *)conmentArr
{
    if ( _conmentArr== nil) {
        _conmentArr = [NSMutableArray array];
    }
    return _conmentArr;
}

- (NSMutableArray *)conmentHeightArr
{
    if ( _conmentHeightArr== nil) {
        _conmentHeightArr = [NSMutableArray array];
    }
    return _conmentHeightArr;
}

#pragma  mark 底部控件

-(SPDyDetailBottomView*)toolView{
    if (!_toolView) {
        _toolView = [[SPDyDetailBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-SafeAreaBottomHeight-50, SCREEN_W, 50) withCode:self.model.code];
        
        WeakSelf;
        _toolView.toolClick = ^(NSInteger tag){
            if (tag == 1) {//评论
                SPEvaluateEditVC *vc = [[SPEvaluateEditVC alloc]init];
                vc.mainCode= weakSelf.model.code;
                vc.beCommented = weakSelf.model.promulgator;
                vc.beCommentedCode = weakSelf.model.code;
                vc.type= @"FEED";
                vc.evaluateEditVCBlock=^(){
                    [weakSelf load];
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if(tag == 2)
            {//点赞
             [weakSelf load];
            }else if (tag==0){
                
                [weakSelf shareClick];
            }
            
        };
    }
   return  _toolView;
}

#pragma  mark 导航栏

-(void)sNav{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //导航栏上的动态信息
    SPUserNavTitleView *titleView = [[SPUserNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-60-44, 44)];
    _titleView = titleView;
     _titleView.intrinsicContentSize = CGSizeMake(200, 44);
    titleView.model = self.model;
    self.navigationItem.titleView = titleView;
    
    [self setRight];
}

-(void)setRight{

    //如果查看自己 右上角可编辑动态
    if ([[StorageUtil getCode] isEqualToString:self.model.promulgator]) {
        
        UIButton *rightButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:nil];
        [rightButton setImage:[UIImage imageNamed:@"h_more"] forState:0];
        [rightButton addTarget:self action:@selector(rightMoreClick) forControlEvents:UIControlEventTouchDown];
        rightButton.titleLabel.font = font(14);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    }
}

-(UIView *)moreView{
    if (!_moreView) {
        _moreView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W-70, 0, 70, 80)];
        _moreView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_moreView];
        
        UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
        [firstBtn setTitle:@"设为私密" forState:0];
        [firstBtn setTitleColor:[UIColor blackColor] forState:0];
        [firstBtn addTarget:self action:@selector(setPrivity) forControlEvents:UIControlEventTouchDown];
        firstBtn.titleLabel.font = font(14);
        [_moreView addSubview:firstBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 70, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_moreView addSubview:line];
        
        UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 41, 70, 40)];
        [secondBtn setTitleColor:[UIColor blackColor] forState:0];
        [secondBtn setTitle:@"删除动态" forState:0];
        [secondBtn addTarget:self action:@selector(delteDynamic) forControlEvents:UIControlEventTouchDown];
        secondBtn.titleLabel.font = font(14);
        [_moreView addSubview:secondBtn];
    }
    return _moreView;
}

#pragma  mark - action

-(void)rightMoreClick{
    CGFloat h = 0;
    if (self.moreView.originY==SafeAreaTopHeight) {
        h = -20;
    }else{
        h=SafeAreaTopHeight;
    }
    [UIView animateWithDuration:0.4 animations:^{
        self.moreView.originY = h;
    }];
}

#pragma  mark  删除动态

-(void)delteDynamic{
    
    [[HttpRequest sharedClient]httpRequestPOST:KUrlFeedDelete parameters:@{@"code":self.model.code} progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        Toast(@"删除成功");
        !self.dynamicDeleteBlock?:self.dynamicDeleteBlock();
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"服务器错误");
    }];
}

#pragma  mark  设为私密

-(void)setPrivity{
    NSDictionary*dic =@{@"code":self.model.code,@"id":self.model.dynamicId,@"secret":@"true"};
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:KUrlFeedUpdate parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        Toast(@"已设为私密");
        [self rightMoreClick];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"服务器错误");
    }];
}

//-(void)send{
//    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:self.beCommented  forKey:@"beCommented"];
//    [dict setObject:[StorageUtil getCode] forKey:@"commentor"];
//    
//    if (isEmptyString(self.inputView.text)) {
//        Toast(@"评论不能为空");
//        return;
//    }
//    
//    [dict setObject:self.inputView.text forKey:@"content"];
//    if ([self.type isEqualToString:@"COMMENT"]) {
//        [dict setObject:self.beCommentedCode forKey:@"mainCode"];
//    }else{
//        [dict setObject:self.model.code forKey:@"mainCode"];
//    }
//    [dict setObject:self.type forKey:@"type"];
//    [dict setObject:self.beCommentedCode forKey:@"beCommentedCode"];
//    
//    //退下键盘
//    [self coverTap];
//    NSLog(@"%@",dict);
//    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedComment parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
//        NSLog(@"%@",responseObject);
//        //评论成功
//        
//        //刷新数据
//        [self load];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//}
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        //        _shareView.shareImg = self..image;
    }
    return _shareView;
}

//分享动态详情
-(void)shareClick{

    [UIView animateWithDuration:0.4 animations:^{
        [self.view addSubview:self.shareView];
        
        self.shareView.hidden = NO;
        //第一个是动态code 第二个是readercode
        self.shareView.shareUrl = [NSString stringWithFormat:@"http://59.110.70.112:8080/web/info2.html?code=%@&userid=%@",self.model.code,[StorageUtil getCode]];
        self.shareView.title = @"美景、美食、美人！";
        self.shareView.subTitle = @"小猪约的世界如此精彩...";
        self.shareView.shareImg = [UIImage getImageFromURL:self.model.imgs[0]];
        self.shareView.shareImg = [UIImage imageNamed:@"app"];
        self.shareView.originY = 0;
    }];
}
@end
