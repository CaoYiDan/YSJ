//
//  SPHomeDataManager.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHomeDataManager : NSObject
/**
 * 获取动态数据
 */
+ (void)getMoreHomeDateWithPage:(NSInteger)page andDic:(NSMutableDictionary *)dic refreshDate:(NSString *)refreshDate success:(void(^)(NSArray *items, BOOL lastPage, NSString *refreshDate))success failure:(void(^)(NSError *NSError))failure;
+ (void)refreshHomeDateWithDic:(NSMutableDictionary *)dic success:(void(^)(NSArray *items, BOOL lastPage,NSString *currentData))success failure:(void(^)(NSError *NSError))failure;
/**
 * 获取轮播图数据
 */
+ (void)getBannerSuccess:(void(^)(NSArray *responseObject,NSArray *bannerImageArr))success failure:(void(^)(NSError *NSError))failure;
/**
 * 获取首页分类模块图片
 */
+ (void)getHomeCatrgorySuccess:(void(^)(NSArray *ImageArr))success failure:(void(^)(NSError *NSError))failure;


@end
