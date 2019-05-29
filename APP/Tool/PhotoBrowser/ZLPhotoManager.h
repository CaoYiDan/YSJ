//
//  ZLPhotoManager.h
//  ZLPhotoBrowser
//
//  Created by long on 17/4/12.
//  Copyright © 2017年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "ZLPhotoModel.h"

@class ZLAlbumListModel;

@interface ZLPhotoManager : NSObject

/**
 * @brief 设置排序模式
 */
+ (void)setSortAscending:(BOOL)ascending;


/**
 * @brief 保存图片到系统相册
 */
+ (void)saveImageToAblum:(UIImage *)image completion:(void (^)(BOOL suc, PHAsset *asset))completion;


/**
 * @brief 在全部照片中获取指定个数、排序方式的部分照片，在跳往预览大图界面时候video和gif均为no，不受参数影响
 */
+ (NSArray<ZLPhotoModel *> *)getAllAssetInPhotoAlbumWithAscending:(BOOL)ascending limitCount:(NSInteger)limit allowSelectVideo:(BOOL)allowSelectVideo allowSelectImage:(BOOL)allowSelectImage allowSelectGif:(BOOL)allowSelectGif allowSelectLivePhoto:(BOOL)allowSelectLivePhoto;


/**
 * @brief 获取相机胶卷相册列表对象
 */
+ (ZLAlbumListModel *)getCameraRollAlbumList:(BOOL)allowSelectVideo allowSelectImage:(BOOL)allowSelectImage;

/**
 * @brief 获取用户所有相册列表
 */
+ (void)getPhotoAblumList:(BOOL)allowSelectVideo allowSelectImage:(BOOL)allowSelectImage complete:(void (^)(NSArray<ZLAlbumListModel *> *))complete;


#pragma mark - 逐个解析asset方法
/**
 自行解析图片方法
 
 使用顺序单个解析，缓解了框架同时解析大量图片造成的内存暴涨
 如果一下选择20张及以上照片(原图)建议使用自行解析
 
 请求到图片后做了一个大小的压缩（原图时并未压缩尺寸）来缓解内存的占用
 */
+ (void)anialysisAssets:(NSArray<PHAsset *> *)assets original:(BOOL)original completion:(void (^)(NSArray<UIImage *> *images))completion;

/**
 * @brief 将result中对象转换成ZLPhotoModel
 */
+ (NSArray<ZLPhotoModel *> *)getPhotoInResult:(PHFetchResult<PHAsset *> *)result allowSelectVideo:(BOOL)allowSelectVideo allowSelectImage:(BOOL)allowSelectImage allowSelectGif:(BOOL)allowSelectGif allowSelectLivePhoto:(BOOL)allowSelectLivePhoto;

/**
 * @brief 获取选中的图片
 */
+ (void)requestSelectedImageForAsset:(ZLPhotoModel *)model isOriginal:(BOOL)isOriginal allowSelectGif:(BOOL)allowSelectGif completion:(void (^)(UIImage *, NSDictionary *))completion;


/**
 获取原图data，转换gif图
 */
+ (void)requestOriginalImageDataForAsset:(PHAsset *)asset completion:(void (^)(NSData *, NSDictionary *))completion;

/**
 * @brief 获取原图
 */
+ (void)requestOriginalImageForAsset:(PHAsset *)asset completion:(void (^)(UIImage *, NSDictionary *))completion;

/**
 * @brief 根据传入size获取图片
 */
+ (PHImageRequestID)requestImageForAsset:(PHAsset *)asset size:(CGSize)size completion:(void (^)(UIImage *, NSDictionary *))completion;


/**
 * @brief 获取live photo
 */
+ (void)requestLivePhotoForAsset:(PHAsset *)asset completion:(void (^)(PHLivePhoto *, NSDictionary *))completion;

/**
 * @brief 获取视频
 */
+ (void)requestVideoForAsset:(PHAsset *)asset completion:(void (^)(AVPlayerItem *, NSDictionary *))completion;

/**
 * @brief 将系统mediatype转换为自定义mediatype
 */
+ (ZLAssetMediaType)transformAssetType:(PHAsset *)asset;

/**
 * @brief 判断图片是否存储在本地/或者已经从iCloud上下载到本地
 */
+ (BOOL)judgeAssetisInLocalAblum:(PHAsset *)asset;

/**
 * @brief 获取图片字节大小
 */
+ (void)getPhotosBytesWithArray:(NSArray<ZLPhotoModel *> *)photos completion:(void (^)(NSString *photosBytes))completion;

/**
 * @brief 标记源数组中已被选择的model
 */
+ (void)markSelcectModelInArr:(NSArray<ZLPhotoModel *> *)dataArr selArr:(NSArray<ZLPhotoModel *> *)selArr;

/**
 * @brief 将image data转换为gif图片，sdwebimage
 */
+ (UIImage *)transformToGifImageWithData:(NSData *)data;


@end