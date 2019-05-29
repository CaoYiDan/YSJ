//
//  YSJHeaderForPublishCompanyView.m
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJAddTeacherVC.h"
#import "ZLPhotoActionSheet.h"
#import "LGTextView.h"
#import "YSJPhotosOtherView.h"
#import "YSJPhotosForProfileView.h"
#import "YSJPopTextFiledView.h"
#import "YSJPopMoreTextFiledView.h"

@interface YSJPhotosForProfileView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property(nonatomic,weak)YSJPhotosOtherView *photoView;

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;


@end

@implementation YSJPhotosForProfileView

-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.middleView];
        
        self.clipsToBounds = YES;
    }
    return self;
}

//中间视图创建
- (UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 180)];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self middleUI];
    }
    return _middleView;
}

- (void)middleUI{
    
    YSJPhotosOtherView *photoView=[[YSJPhotosOtherView alloc]init];
    [self.middleView addSubview:photoView];
    self.photoView = photoView;
//    photoView.backgroundColor = KMainColor;
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    photoView.photosAsset = self.lastSelectAssets;
    WeakSelf;
    __typeof(photoView)weakPhotoView=photoView;
    photoView .clickblock=^(NSInteger tag){
        //这里的tag ，其实是按图片的高度赋值的，
        if (tag == 110) {
            
            [self showWithPreview:NO];
            
        }else if (tag >120){
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.frameHeight = tag+20;
                weakSelf.middleView.frameHeight = tag;
                weakSelf.contentofYChangeBlock(tag);
            }];
            
        }
    };
    
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
    
//    actionSheet.maxSelectCount =9;
    
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.showCaptureImageOnTakePhotoBtn = NO;
    actionSheet.allowSelectImage =YES;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectLivePhoto = NO;
    actionSheet.allowForceTouch = NO;
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = [SPCommon getCurrentVC];
    
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    weakify(self);
    
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        strongify(weakSelf);
        
        [self postAddImgWithArr:images];
        
    }];
    
    return actionSheet;
}

-(void)postAddImgWithArr:(NSArray *)imgs{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:@"" forKey:@"imgurl"];

    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    // 在parameters里存放照片以外的对象
    [manager POST:YShow parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < imgs.count; i++) {
            
            UIImage *image = imgs[i];
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
    
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[result2 stringChangeToDictionary];
        
        NSLog(@"%@",dict);
        
        self.block();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];
    
}

-(void)add{
    
    /*self.block
     返回 0 ,约定的是点击了“添加老师”按钮
     返回 不是0 ,约定的返回的“h” 是添加图片引发的header的高度的动态变化高度
     */
//    !self.block?:self.block(0.0);
}

-(void)setPhotoImg:(NSArray *)imgs{
    [self.photoView setPhotoImg:imgs];
}

@end
