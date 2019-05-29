//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//
#import "StarView.h"
#import "YSJChoseTagCell.h"
#import "YSJPopTextFiledView.h"
#import "LGTextView.h"
#import "YSJPopMoreTextFiledView.h"
#import "SLLocationHelp.h"
#import "LGComposePhotosView.h"
#import "SPPublishLimitVC.h"
#import "SPPublishLocationVC.h"
#import "BDImagePicker.h"
#import "YSJEvaluateVC.h"
#import "ZLPhotoActionSheet.h"
#import "FFDifferentWidthTagModel.h"
#import "SPCommon.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface YSJEvaluateVC ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic,strong) StarView *star1;
@property(nonatomic,weak)LGComposePhotosView *photoView;

@property(nonatomic,weak)LGTextView *textView;

@property (nonatomic,strong) UILabel *evaluate;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *evaluateArr;

@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong) YSJChoseTagCell *cell;

@end

@implementation YSJEvaluateVC
{
   
    //标签模型
    FFDifferentWidthTagModel *_commentModel;
}

-(NSMutableArray*)evaluateArr{
    if (!_evaluateArr) {
        _evaluateArr = @[
                         @"强烈推荐",@"很满意",@"还不错",@"一般",@"差"
                     ].mutableCopy;
    }
    return _evaluateArr;
}

-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = @[
           @[@"课程服务差",@"老师不专业",@"上课氛围差"],
           @[@"课程服务一般",@"授课内容一般"],
           @[@"课程服务还不错",@"老师很棒"],
           @[@"课程服务很满意",@"老师很不错"],
           @[@"超值",@"物有所值",@"拓展丰富",@"地方好找",@"环境很好"]
           ].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"评价";
    
    _index = 4;
    
    [self getData];
    
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

#pragma mark - 获取数据

-(void)getData{
    
    _commentModel = [FFDifferentWidthTagModel new];
    _commentModel.selectedArr = @[].mutableCopy;
    
    NSMutableArray *tagsArrM = [NSMutableArray array];
    NSArray *arr = self.dataArr[self.index];
    NSLog(@"%@",arr);
    for (int j = 0; j < arr.count; j++){
        
        [_commentModel.selectedArr addObject:@(0)];
        
        [tagsArrM addObject:arr[j]];
    }
    
    _commentModel.tagsArrM = tagsArrM;
   
}

-(void)reloadLabelView{

    for (UIView *vi  in self.cell.subviews) {
        [vi removeFromSuperview];
    }
    
    self.cell.tagModel = _commentModel;
    self.cell.frameHeight =_commentModel.cellHeight;
    self.evaluate.text = self.evaluateArr[4-self.index];
}

#pragma  mark - setter

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
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, 156+200)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
    }
    return _topView;
}

- (void)topUI{
    //课程评价
    UILabel * evaluateTitle = [[UILabel alloc]init];
    evaluateTitle.font = font(16);
    evaluateTitle.text = @"课程评价";
    evaluateTitle.textColor = KBlack333333;
    [self.topView addSubview:evaluateTitle];
    [evaluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin+5);
        make.height.offset(20);
        make.top.offset(28);
    }];
    
    //评分
    _star1 = [[StarView alloc]initWithFrame:CGRectMake(SCREEN_W/2-68, 70, 140, 30)];
    _star1.font_size=25;
    _star1.canSelected = YES;
    [self.topView addSubview:_star1];
    WeakSelf;
    _star1.StarBlock = ^(NSInteger showShar) {
        NSLog(@"%ld",(long)showShar);
        if (showShar>100) {
            showShar =100;
        }
        weakSelf.index = showShar/20-1;
        [weakSelf getData];
        [weakSelf reloadLabelView];
    };
    [_star1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(evaluateTitle.mas_right).offset(15);
        make.width.offset(140);
        make.height.offset(30);
        make.centerY.equalTo(evaluateTitle).offset(0);
    }];
    
    //总评价
    UILabel * evaluate = [[UILabel alloc]init];
    evaluate.font = font(14);
    evaluate.text = @"强烈推荐";
    evaluate.textColor = [UIColor hexColor:@"BBBBBB"];
    self.evaluate = evaluate;
    [self.topView addSubview:evaluate];
    [evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_star1.mas_right).offset(0);
        make.height.offset(20);
        make.top.offset(28);
         make.centerY.equalTo(evaluateTitle).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.bottom.equalTo(_star1).offset(29);
    }];
    
    YSJChoseTagCell *cell = [[YSJChoseTagCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    cell.tagModel = _commentModel;
    cell.originY = 80;
    cell.frameWidth = kWindowW;
    self.cell = cell;
    cell.frameHeight = _commentModel.cellHeight;
    [self.topView addSubview:cell];
    
    UIView *bottomLine22 = [[UIView alloc]init];
    bottomLine22.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine22];
    [bottomLine22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(cell).offset(0);
    }];
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"评价详情";
    xuTextTitle.textColor = KBlack333333;
    [self.topView addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin+5);
        make.height.offset(20);
        make.top.equalTo(cell.mas_bottom).offset(10);
    }];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56+130, SCREEN_W-2*kMargin, 104)];
    self.textView = textView;
    [self.topView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(104);
        make.width.offset(SCREEN_W-2*kMargin); make.top.equalTo(xuTextTitle.mas_bottom).offset(20);
    }];
    textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
    textView.textColor = black666666;
    textView.delegate = self;
    textView.font  = font(14);
    textView.placeholder = @"聊聊此次课程感受\n1.通过参加课程，学到东西了吗\n2.老师上课方式喜欢吗？\n3.环境怎么样？ ";
    [self.topView addSubview:textView];
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//中间视图创建
- (UIView *)middleView{
    
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frameHeight+10, SCREEN_W, 180)];
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
    
}

//下部分视图创建
-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView=[[UIView alloc]init];
        [self.scrollView addSubview:self.bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.equalTo(_middleView.mas_bottom).offset(0);
            make.size.mas_offset(CGSizeMake(SCREEN_W-20, normalCellH
                                            *2));
        }];
        
       
    }
    return _bottomView;
}

-(void)setSaveButton{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"发表评价" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
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

#pragma mark - 保存

-(void)save{
    
    if (isEmptyString(self.textView.text)) {
        Toast(@"请填写完整信息");
        return;
    }
    
    self.imgArr =  self.photos;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:self.order_Id forKey:@"order_id"];
    [dic setObject:@(_star1.show_star/20) forKey:@"evaluation"];
    [dic setObject:self.textView.text forKey:@"content"];
    
    NSMutableArray *arr = @[].mutableCopy;
    
    int i =0;
    for (NSNumber *selected in _commentModel.selectedArr) {
        if ([selected integerValue] == 1) {
            [arr addObject:_commentModel.tagsArrM[i]];
        }
        i++;
    }
    [dic setObject:[arr componentsJoinedByString:@","] forKey:@"lables"];
    NSLog(@"%@",dic);
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    // 在parameters里存放照片以外的对象
    [manager POST:YCourseEvaluation parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < _photos.count; i++) {
            
            UIImage *image = _photos[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@%d.jpg", dateString,i];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:fileName fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        Toast(@"评价已提交");
        UIViewController *vc = self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];
    return;
}

@end
