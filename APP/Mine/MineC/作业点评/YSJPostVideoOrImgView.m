//
//  YSJPostVideoOrImgView.m
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPostVideoOrImgView.h"

#import "ImageCell.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "ZLPhotoBrowser.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoManager.h"
#import "LGTextView.h"

@interface YSJPostVideoOrImgView ()

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;

@property (nonatomic, strong) NSArray *arrDataSources;

@property (nonatomic, assign) BOOL isOriginal;
@end

@implementation YSJPostVideoOrImgView

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

- (ZLPhotoActionSheet *)getPas
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.allowSelectVideo = !_canNotSelectedVideo;
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
    //以下参数为自定义参数，均可不设置，有默认值
    //    actionSheet.configuration.sortAscending = self.sortSegment.selectedSegmentIndex==0;
    //    actionSheet.configuration.allowSelectImage = self.selImageSwitch.isOn;
    //    actionSheet.configuration.allowSelectGif = self.selGifSwitch.isOn;
    //    actionSheet.configuration.allowSelectVideo = self.selVideoSwitch.isOn;
    //    actionSheet.configuration.allowSelectLivePhoto = self.selLivePhotoSwitch.isOn;
    //    actionSheet.configuration.allowForceTouch = self.allowForceTouchSwitch.isOn;
    //    actionSheet.configuration.allowEditImage = self.allowEditSwitch.isOn;
    //    actionSheet.configuration.allowEditVideo = self.allowEditVideoSwitch.isOn;
    //    actionSheet.configuration.allowSlideSelect = self.allowSlideSelectSwitch.isOn;
    //    actionSheet.configuration.allowMixSelect = self.mixSelectSwitch.isOn;
    //    actionSheet.configuration.allowDragSelect = self.allowDragSelectSwitch.isOn;
    //    //设置相册内部显示拍照按钮
    //    actionSheet.configuration.allowTakePhotoInLibrary = self.takePhotoInLibrarySwitch.isOn;
    //    //设置在内部拍照按钮上实时显示相机俘获画面
    //    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = self.showCaptureImageSwitch.isOn;
    //    //设置照片最大预览数
    //    actionSheet.configuration.maxPreviewCount = self.previewTextField.text.integerValue;
    //    //设置照片最大选择数
    //    actionSheet.configuration.maxSelectCount = self.maxSelCountTextField.text.integerValue;
    //    actionSheet.configuration.maxVideoSelectCountInMix = 3;
    //    actionSheet.configuration.minVideoSelectCountInMix = 1;
    //    //设置允许选择的视频最大时长
    //    actionSheet.configuration.maxVideoDuration = self.maxVideoDurationTextField.text.integerValue;
    //    //设置照片cell弧度
    //    actionSheet.configuration.cellCornerRadio = self.cornerRadioTextField.text.floatValue;
    //单选模式是否显示选择按钮
    //    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    //    actionSheet.configuration.editAfterSelectThumbnailImage = self.editAfterSelectImageSwitch.isOn;
    //是否保存编辑后的图片
    //    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //设置编辑比例
    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
    //是否在已选择照片上显示遮罩层
    //    actionSheet.configuration.showSelectedMask = self.maskSwitch.isOn;
    //颜色，状态栏样式
    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    //    actionSheet.configuration.shouldAnialysisAsset = self.allowAnialysisAssetSwitch.isOn;
    //    //框架语言
    //    actionSheet.configuration.languageType = self.languageSegment.selectedSegmentIndex;
    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //    actionSheet.configuration.maxVideoDuration = 5;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = [SPCommon getCurrentVC];
    //记录上次选择的图片
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    WeakSelf;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        
        self.arrDataSources = images;
        self.isOriginal = isOriginal;
        self.lastSelectAssets = assets.mutableCopy;
        self.lastSelectPhotos = images.mutableCopy;
        [self.collectionView reloadData];
        NSLog(@"image:%@", images);
        //解析图片
        [self anialysisAssets:assets original:isOriginal];
    }];
    
    
    
    return actionSheet;
}

- (void)anialysisAssets:(NSArray<PHAsset *> *)assets original:(BOOL)original
{
//    ZLProgressHUD *hud = [[ZLProgressHUD alloc] init];
//    //该hud自动15s消失，请使用自己项目中的hud控件
//    [hud show];
    
    //    [ZLPhotoManager ]
    
    [ZLPhotoManager anialysisAssets:assets original:original completion:^(NSArray<UIImage *> *images) {
        //        @zl_strongify(self);
//        [hud hide];
        self.arrDataSources = images;
        self.lastSelectPhotos = images.mutableCopy;
        [self.collectionView reloadData];
        NSLog(@"%@", images);
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_arrDataSources.count);
    return _arrDataSources.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (indexPath.row==_arrDataSources.count) {
        cell.imageView.image = [UIImage imageNamed:@"add7"];
        cell.playImageView.hidden = YES;
    }else{
        cell.imageView.image = _arrDataSources[indexPath.row];
        PHAsset *asset = self.lastSelectAssets[indexPath.row];
        cell.playImageView.hidden = !(asset.mediaType == PHAssetMediaTypeVideo);
    }
    return cell;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==_arrDataSources.count) {
        [self showWithPreview:YES];
        
    }else{
        
        [[self getPas]previewSelectedPhotos:self.lastSelectPhotos assets:self.lastSelectAssets index:indexPath.row];
        
    }
}

- (void)setCanNotSelectedVideo:(BOOL)canNotSelectedVideo{
    _canNotSelectedVideo = canNotSelectedVideo;
    
}
@end
