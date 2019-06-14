//
//  YSJPostVideoOrImgView.m
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJPostVideoView.h"

#import "ImageCell.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <Photos/Photos.h>
#import "ZLPhotoBrowser.h"
#import "LGTextView.h"

@interface YSJPostVideoView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/* <# 注释 #> **/
@property (nonatomic,strong) NSString *videoUrl;
/* <# 注释 #> **/
@property (nonatomic,strong) NSString *fileName;
/* <# 注释 #> **/
@property (nonatomic,strong) NSURL *outputURL;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;

@property (nonatomic, strong) NSMutableArray *arrDataSources;

@property (nonatomic, assign) BOOL isOriginal;

@end

@implementation YSJPostVideoView
-(NSMutableArray*)arrDataSources{
    if (!_arrDataSources) {
        _arrDataSources = @[].mutableCopy;
    }
    return _arrDataSources;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAV];
        [self initCollectionView];
        
    }
    return self;
}

-(void)setAV{
    //设置外放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionMixWithOthers
                   error:nil];
    //设置为扬声器播放，
    UInt32 audioRouteOverride = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
}

- (void)initCollectionView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((width-kMargin*3)/3, (width-kMargin*3)/3);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3,kMargin, 3, kMargin);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 300) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:NSClassFromString(@"ImageCell") forCellWithReuseIdentifier:@"ImageCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_arrDataSources.count);
    return self.arrDataSources.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (indexPath.row==_arrDataSources.count) {
        cell.imageView.image = [UIImage imageNamed:@"add7"];
        cell.playImageView.hidden = YES;
    }else{
        NSDictionary *dic = _arrDataSources[indexPath.row];
        cell.imageView.image = dic[@"obj"];
        if ([dic[@"type"] isEqualToString:@"video"]) {
            cell.playImageView.hidden = NO;
        }else{
            cell.playImageView.hidden = YES;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==_arrDataSources.count) {
        [self takePhotoOrSelectPicture];
    }else{
        
    }
}

#pragma mark - 选取照片或者拍照
- (void)takePhotoOrSelectPicture
{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self startvideoWithType:1];
    }];
    
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosevideo];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertSheet addAction:actionOne];
    [alertSheet addAction:actionTwo];
    [alertSheet addAction:cancelAction];
    
    [[SPCommon getCurrentVC] presentViewController:alertSheet animated:YES completion:nil];
}


//从相册中选取
- (void)choosevideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    //    去除毛玻璃效果
    
    ipc.navigationBar.translucent = NO;
    
      [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = @[availableMedia[1],availableMedia[0]];//设置媒体类型为public.movie
    
    [[SPCommon getCurrentVC] presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
}

//录制视频
- (void)startvideoWithType:(NSInteger)type
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    //    ipc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    if (type==0) {
         ipc.mediaTypes = @[availableMedia[1],availableMedia[0]];//设置媒体类型为public.movie
    }else{
         ipc.mediaTypes = @[availableMedia[1]];//设置媒体类型为public.movie
    }
   
    [[SPCommon getCurrentVC] presentViewController:ipc animated:YES completion:nil];
    ipc.videoMaximumDuration = 600.0f;//10分钟
    ipc.delegate = self;//设置委托
    
    
}


//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//此方法可以获取视频文件的时长。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

//完成视频录制，并压缩后显示大小、时长
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.movie"])
    {
        
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
        NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
        
        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        _fileName = [NSString stringWithFormat:@"output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        NSURL * url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString * urlStr = [url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            //        UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
        
    }else{
        
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:@"img" forKey:@"type"];
        //获取照片的原图
        UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
        [dic setObject:original forKey:@"obj"];
        [self.arrDataSources addObject:dic];
        [self.collectionView reloadData];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}

#pragma mark - 压缩视频
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
               
            
                 _outputURL = outputURL;
                 [self alertUploadVideo:outputURL];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}


-(void)alertUploadVideo:(NSURL*)URL{
    
    CGFloat size = [self getFileSize:[URL path]];
    
    NSString *sizeString;
    CGFloat sizemb= size/1024;
    if(size<=1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }
    
    if(sizemb<=5){
        
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:@"video" forKey:@"type"];
        [dic setObject:URL forKey:@"url"];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            [dic setObject:[self getSomeMessageWithFilePath:URL] forKey:@"obj"];
            [self.arrDataSources addObject:dic];
            
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.collectionView reloadData];
                
                //回调或者说是通知主线程刷新，
            });
            
        });

     
    
    }else if(sizemb>5){
        
        Toast(@"超过5MB，不能上传");
    }
}



- (UIImage *)getSomeMessageWithFilePath:(NSURL *)filePath
{
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:filePath];
  
    return [self getImageWithAsset:asset];
  
}

- (UIImage *)getImageWithAsset:(AVAsset *)asset
{
    AVURLAsset *assetUrl = (AVURLAsset *)asset;
    NSParameterAssert(assetUrl);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:assetUrl];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 0;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
//    [MBProgressHUD hideHUDForView:self];
    
    return thumbnailImage;
}

- (NSMutableArray *)getPhotoImgs{
    
    return self.arrDataSources;
}

  
@end
