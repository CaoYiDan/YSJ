//
//  SPCommon.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCommon.h"
#import "WXApi.h"
#import "SPKitExample.h"

@implementation SPCommon

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma  mark  将字符串转成字典
+(id )dictionaryWithJsonString:(NSString *)jsonString {
    
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

-(CAKeyframeAnimation*)getCAKeyframeAnimation{
//需要实现的帧动画,这里根据自己需求改动
CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
animation.keyPath = @"transform.scale";
animation.values = @[@1.0,@1.1,@0.9,@1.0];
animation.duration = 0.3;
animation.calculationMode = kCAAnimationCubic;
    return animation;
}

+ (UIViewController *)getCurrentVC {
    
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+(NSDictionary *)getLoncationDic{
    
    NSMutableDictionary *dic  = @{}.mutableCopy;
    
    if (YES)
    {
        [dic setObject:@"39.030928" forKey:@"latitude"];
        [dic setObject:@"117.279395" forKey:@"longitude"];
        return  dic;
    }else{
        [dic setObject:isEmptyString([StorageUtil getUserLat])?@"":[StorageUtil getUserLat] forKey:@"latitude"];
        [dic  setObject:isEmptyString([StorageUtil getUserLon])?@"":[StorageUtil getUserLon] forKey:@"longitude"];
    }
    return dic;
}

+(BOOL)gotoLogin{
    if (isEmptyString([StorageUtil getCode])) {
        RegisterViewController *vc = [[RegisterViewController alloc]init];
        
        [[self getCurrentVC] presentViewController:vc animated:YES completion:nil];
        return YES;
    }else{
        return NO;
    }
}

+(UILabel*)noDataLabelWithText:(NSString *)text frame:(CGRect)frame{
    UILabel * noDataLab = [UILabel labelWithFont:font(15) textColor:[UIColor lightGrayColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
    noDataLab.frame = frame;
    noDataLab.text = text;
    return noDataLab;
}

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+(NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}
/**
 为view设置阴影
 
 @param view 被设置阴影的View
 */
+(void)setShaowForView:(UIView *)view{
    view.backgroundColor = KWhiteColor;
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowOpacity = 0.2;
    view.layer.shadowColor = [UIColor hexColor:@"27347d"].CGColor;
    view.layer.cornerRadius = 8;
}
/**
 
 @param m 输入的数据
 @return 如果大于1000m, 将 m 转化为km， 小于1000m ,返回原数据
 
 */
+(NSString *)changeKm:(int)m{
    if (m>=1000){
        return  [NSString stringWithFormat:@"%.1fkm",m/1000.0];
    }
    return [NSString stringWithFormat:@"%um",m];
}
@end
