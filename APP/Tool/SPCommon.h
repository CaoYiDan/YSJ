//
//  SPCommon.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCommon : UIView

+(NSString *)changeTelephone:(NSString*)teleStr;

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//最普遍的尺寸大小回弹动画
+(CAKeyframeAnimation *)getCAKeyframeAnimation;
//获取当前控制器
+(UIViewController *)getCurrentVC;
+(NSDictionary *)getLoncationDic;
+(NSDictionary *)getLonDic;

+(BOOL)gotoLogin;
+(UILabel *)noDataLabelWithText:(NSString *)text frame:(CGRect)frame;
//微信分享
+(void)shareWX;

+(void)gotoChatVCWithVC:(UIViewController *)vc;

/**
 为view设置阴影

 @param view 被设置阴影的View
 */
+(void)setShaowForView:(UIView*)view;
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+(NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

/**
 
 @param m 输入的数据
 @return 如果大于1000m, 将 m 转化为km， 小于1000m ,返回原数据

 */
+(NSString *)changeKm:(int)m;

#pragma mark - 弹出编辑框
+(void)creatAlertControllerTitle:(NSString*) title subTitle:(NSString *)subTitle _alertSure:(void (^)(NSString *text)) resultText;


#pragma mark - 弹出编辑框
+(void)creatAlertControllerTitle:(NSString*) title subTitle:(NSString *)subTitle _alertSure:(void (^)(NSString *text)) resultText keyBoard:(UIKeyboardType)keyBoard;

#pragma mark ---- 将时间戳转换成时间

+(NSString *)getTimeFromTimestamp:(NSInteger)time;

+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

+(NSString *)md5WithStr:(NSString *)str;

@end
