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

@interface YSJDetailForCompanyPublishVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property (nonatomic, strong) UIView *headerView;
@property(nonatomic,assign) CGFloat headerH;

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma  mark - setter

//再次请求一次位置信息

-(void)getLocation{
    WeakSelf;
    [[SLLocationHelp sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        
    } status:^(CLAuthorizationStatus status) {
        if (status != kCLAuthorizationStatusAuthorizedAlways && status != kCLAuthorizationStatusAuthorizedWhenInUse) {
            _locationEnabled = NO;
            [self locationAlterShow];
        }else{
            _locationEnabled = YES;
            
        }
    } didFailWithError:^(NSError *error) {
        
    }];
}

-(void)locationAlterShow{
    WeakSelf;
    //定位不能用
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不允许访问位置信息是不能发布动态的哦" message:@"是否允许访问您的位置？" preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //            }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    //       [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [weakSelf presentViewController:alertController animated:YES completion:nil];
    
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 500)];
    }
    return _headerView;
}



-(void)setSaveButton{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"保存" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

-(void)save{
    
}

//添加取消按钮->
-(void)addCancelBtn{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setFrame:CGRectMake(20, 20, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftIgtem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = leftIgtem;
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}

//完成发布
-(void)finishPublish{
    //2.block传值
    //    if (self.mDismissBlock != nil) {
    //        self.mDismissBlock();
    //    }
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
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



#pragma  mark - -----------------发送-----------------

//- (void)onRightClick{
//
//    if (isEmptyString([StorageUtil getCity])) {
//        [self locationAlterShow];
//        return;
//    }
//
//    if (isEmptyString(self.textView.text)) {
//        Toast(@"写一写您此时此刻的感受吧");
//        return;
//    }
//
//    [self.view endEditing:YES];
//
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    self.rightButton.enabled = NO;
//
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//
//    for (UIView *vi  in self.photoView.subviews) {
//        if ([vi isKindOfClass:[UIImageView class]]) {
//            [arr addObject:vi];
//        }
//    }
//    //上传图片获取地址
//    [self upDateHeadIcon:arr];
//
//}

#pragma  mark 上传图片
- (void)upDateHeadIcon:(NSArray *)photos{
    if (photos.count==0) {
        [self post];
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    //菊花显示
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    //      __block int i=0;
    
    //    self.imgArr = [NSMutableArray arrayWithCapacity:photos.count];
    
//    for (UIImageView *img  in photos) {
//        [self.imgArr addObject:@""];
//    }
//
    for (int i=0;i<photos.count;i++) {
        
        dispatch_group_enter(group);
        
        UIImageView *photo = photos[i];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                             
                                                             @"text/html",
                                                             
                                                             @"image/jpeg",
                                                             
                                                             @"image/png",
                                                             
                                                             @"application/octet-stream",
                                                             
                                                             @"text/json",
                                                             
                                                             nil];
        
        manager.requestSerializer= [AFHTTPRequestSerializer serializer];
        
        NSData * imageData = UIImageJPEGRepresentation(photo.image,0.5);
        //        NSData *imageData = UIImagePNGRepresentation(photo.image);
        NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
        [imageData writeToFile:fullPath atomically:NO];
        
        NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
        [dictT setObject:imageData forKey:@"image"];
        [dictT setObject:@"/usr/local/tomcat/webapps/" forKey:@"imageUploadPath"];
        NSLog(@"%@",kUrlPostImg);
        [manager POST:kUrlPostImg parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            //将二进制转为字符串
            NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            //字符串转字典
            NSDictionary*dict=[self dictionaryWithJsonString:result2];
            NSLog(@"%@",dict);
            // NSMutableArray 是线程不安全的，所以加个同步锁
//            @synchronized (self.imgArr) {
//                [self.imgArr replaceObjectAtIndex:i withObject:dict[@"image"]];
//            }
            
            dispatch_group_leave(group);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            Toast(@"请检查网络是否错误");
            self.rightButton.enabled = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        [self post];
    });
}

#pragma  mark - -----------------发布接口-----------------

-(void)post{
    
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *contentDict= [[NSMutableDictionary alloc]init];
//    [contentDict setObject:_textView.text forKey:@"content"];
//
    
    if (!isEmptyString([StorageUtil getCity])) {
        [contentDict setObject:@"" forKey:@"at"];
        [paramenters setObject:[StorageUtil getCity] forKey:@"city"];
    }
    
//    [contentDict setObject:self.imgArr forKey:@"imgs"];
//    [contentDict setObject:@"" forKey:@"subject"];
//
//    [paramenters setObject:contentDict forKey:@"content"];
//
//    [paramenters setObject:[SPCommon getLoncationDic] forKey:@"location"];
//
//    [paramenters setObject:[_cityLab.text isEqualToString:@"所在位置"]?@"":_cityLab.text forKey:@"locationValue"];
//
//    [paramenters setObject:self.limitStr forKey:@"receiver"];
//
//    [paramenters setObject:@"CATEGORY" forKey:@"receiverType"];
//
//    [paramenters setObject:[StorageUtil getCode] forKey:@"promulgator"];
//    NSLog(@"%@",paramenters);
//    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedAdd parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
//        Toast(@"发布成功");
//        //发送通知 ，刷新界面
//        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPublishFinish object:nil];
//
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        Toast(@"请检查网络是否错误");
//        self.rightButton.enabled = YES;
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
}

#pragma  mark  将字符串转成字典
-(id )dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        return nil;
    }
    
    return dic;
}

//定位
-(void)city{
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        Toast(@"定位服务尚未打开，请在设置中打开！");
        return;
    }
    
    SPPublishLocationVC *vc = [[SPPublishLocationVC alloc]init];
    vc.selectedIndex = _locationIndex;
    vc.publishLocationBlock = ^(NSString *result,NSInteger index){
        
        self.locationCity = result;
        _locationIndex = index;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//谁可以看

-(void)limit{
    
    SPPublishLimitVC *vc = [[SPPublishLimitVC alloc]init];
    vc.selectedIndex = _limitIndex;
    vc.publishLimitBLock = ^(NSString *limitStr,NSString *limitText,NSInteger index){
     
        _limitIndex = index;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 22;
    return self.listArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSJTeacherForCompanyCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJTeacherCollectionCellID forIndexPath:indexPath];
    cell.dic = @{@"photo":@"",@"name":@"孙二娘",@"teaching_type":@"喝酒"};
//    cell.dic = self.listArr[indexPath.row];
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

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, _headerH);
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    YSJHeaderForPublishCompanyView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSJHeaderForPublishCompanyViewID" forIndexPath:indexPath];
    if (!view) {
        view = [[YSJHeaderForPublishCompanyView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, _headerH)];
    }
    WeakSelf;
    view.block = ^(CGFloat h) {
        //返回 0 ,约定的是点击了“添加老师”按钮
        if (h==0) {
            YSJChoseTeachersVC *vc = [[YSJChoseTeachersVC alloc]init];
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
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    
    [_collectionview registerClass:[YSJTeacherForCompanyCollectionCell class] forCellWithReuseIdentifier:YSJTeacherCollectionCellID];
    [_collectionview registerClass:[YSJHeaderForPublishCompanyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSJHeaderForPublishCompanyViewID"];
    
    [self.view addSubview:_collectionview];
    
}

@end
