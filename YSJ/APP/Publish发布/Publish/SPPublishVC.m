//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "YSJPopTextFiledView.h"
#import "LGTextView.h"
#import "SLLocationHelp.h"
#import "LGComposePhotosView.h"
#import "SPPublishLimitVC.h"
#import "SPPublishLocationVC.h"
#import "BDImagePicker.h"
#import "SPPublishVC.h"
#import "ZLPhotoActionSheet.h"

#import "SPCommon.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface SPPublishVC ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *cityLab;
@property (nonatomic, strong) UILabel *limitLab;
@property(nonatomic,weak)LGComposePhotosView *photoView;
@property(nonatomic,weak)LGTextView *textView;
@property(nonatomic,copy)NSString *limitStr;
@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;

@property (nonatomic, strong) NSMutableArray *photos;

/**
 上课时间
 */
@property (nonatomic,strong) YSJPopTextFiledView *classTime;
/**
 课时数
 */
@property (nonatomic,strong) YSJPopTextFiledView *classNums;
@end

@implementation SPPublishVC
{
    NSInteger _limitIndex;
    NSInteger _locationIndex;
    
    BOOL _locationEnabled;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"课程详情";
    
//    [self getLocation];//请求位置信息

    self.limitStr = @"ALL";
    
    _limitIndex = 0;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.middleView];
    self.bottomView.backgroundColor = KWhiteColor;
    [self  setSaveButton];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
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

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _scrollView.contentSize=CGSizeMake(0, 900);
    }
    return _scrollView;
}

//上半部分创建
- (UIView *)topView{
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, 156)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
    }
    return _topView;
}

- (void)topUI{
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"课程详情";
    xuTextTitle.textColor = KBlack333333;
    [self.topView addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.offset(18);
    }];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56, SCREEN_W-2*kMargin, 84)];
    self.textView = textView;
    [self.topView addSubview:textView];
    textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
    textView.textColor = black666666;
    textView.delegate = self;
    textView.font  = font(14);
    textView.placeholder = @"详细描述课程内容\n1.描述课程内容特色、学习目标、教学理念等\n2.描述老师授课特色\n3.描述课程为学生带来的影响是什么";
    [self.topView addSubview:textView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//中间视图创建
- (UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frameHeight+28, SCREEN_W, 120)];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self middleUI];
    }
    return _middleView;
}

- (void)middleUI{
    
    LGComposePhotosView *photoView=[[LGComposePhotosView alloc]init];
    [self.middleView addSubview:photoView];
    self.photoView = photoView;
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    photoView.photosAsset = self.lastSelectAssets;
    WeakSelf;
    __typeof(photoView)weakPhotoView=photoView;
    photoView .clickblock=^(NSInteger tag){
        if (tag == 110) {
           
            [self showWithPreview:NO];
            
        }else if (tag >120){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.middleView.frameHeight = tag;
            }];
        }else{
            [weakSelf.lastSelectAssets removeObjectAtIndex:tag];
            [weakSelf.photos removeObjectAtIndex:tag];
            [weakSelf.photoView setImgs:weakSelf.photos];
        }
    };
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.middleView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//下部分视图创建
-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView=[[UIView alloc]init];
        [self.scrollView addSubview:self.bottomView];
      
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.equalTo(_middleView.mas_bottom).offset(0);
            make.size.mas_offset(CGSizeMake(SCREEN_W-20, normaelCellH*2));
        }];
        
          [self bottomUI];
    }
    return _bottomView;
}

- (void)bottomUI{
    
    YSJPopTextFiledView *cell = [[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, 0, kWindowW,normaelCellH) withTitle:@"上课时间" subTitle:@""];
    self.classTime = cell;
    [self.bottomView addSubview:cell];
    
    YSJPopTextFiledView *cell2 = [[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, normaelCellH, kWindowW,normaelCellH) withTitle:@"课时数" subTitle:@""];
    self.classNums = cell2;
    [self.bottomView addSubview:cell2];
  
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

#pragma  mark - -----------------调取相册-----------------

- (void)showWithPreview:(BOOL)preview
{
    ZLPhotoActionSheet *a = [self getPas];
    
    if (preview) {
        [a showPreviewAnimated:YES];
    } else {
        [a showPhotoLibrary];
    }
}

- (ZLPhotoActionSheet *)getPas
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    actionSheet.maxSelectCount =9;
    
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.showCaptureImageOnTakePhotoBtn = NO;
    actionSheet.allowSelectImage =YES;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectLivePhoto = NO;
    actionSheet.allowForceTouch = NO;
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;
    
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    weakify(self);
    
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        strongify(weakSelf);
        //for (UIImage *img in images) {
        //  [strongSelf.photoView addPhoto:img];
        //}
        [strongSelf.photoView setImgs:images];
        strongSelf.photos = images.mutableCopy;
        strongSelf.lastSelectAssets = assets.mutableCopy;
    }];
    
    return actionSheet;
}

#pragma  mark - -----------------发送-----------------

- (void)onRightClick{
   
    if (isEmptyString([StorageUtil getCity])) {
        [self locationAlterShow];
        return;
    }
    
    if (isEmptyString(self.textView.text)) {
        Toast(@"写一写您此时此刻的感受吧");
        return;
    }
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.rightButton.enabled = NO;
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (UIView *vi  in self.photoView.subviews) {
        if ([vi isKindOfClass:[UIImageView class]]) {
            [arr addObject:vi];
        }
    }
    //上传图片获取地址
    [self upDateHeadIcon:arr];
    
}

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
    
    for (UIImageView *img  in photos) {
        [self.imgArr addObject:@""];
    }
    
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
            @synchronized (self.imgArr) {
            [self.imgArr replaceObjectAtIndex:i withObject:dict[@"image"]];
            }
            
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
    [contentDict setObject:_textView.text forKey:@"content"];
    
    
    if (!isEmptyString([StorageUtil getCity])) {
        [contentDict setObject:@"" forKey:@"at"];
        [paramenters setObject:[StorageUtil getCity] forKey:@"city"];
    }
    
    [contentDict setObject:self.imgArr forKey:@"imgs"];
    [contentDict setObject:@"" forKey:@"subject"];
    
    [paramenters setObject:contentDict forKey:@"content"];
    
    [paramenters setObject:[SPCommon getLoncationDic] forKey:@"location"];
    
    [paramenters setObject:[_cityLab.text isEqualToString:@"所在位置"]?@"":_cityLab.text forKey:@"locationValue"];
    
    [paramenters setObject:self.limitStr forKey:@"receiver"];
    
    [paramenters setObject:@"CATEGORY" forKey:@"receiverType"];
    
    [paramenters setObject:[StorageUtil getCode] forKey:@"promulgator"];
    NSLog(@"%@",paramenters);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedAdd parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        Toast(@"发布成功");
        //发送通知 ，刷新界面
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPublishFinish object:nil];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"请检查网络是否错误");
        self.rightButton.enabled = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
        self.cityLab.text = result;
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
        self.limitStr = limitStr;
        self.limitLab.text = limitText;
        _limitIndex = index;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
