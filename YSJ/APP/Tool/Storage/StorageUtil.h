//
//  StorageUtil.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/30.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface StorageUtil : NSObject

//保存用户地理信息
+(void)saveUserAddressDict:(NSDictionary*)dict;
+(NSDictionary*)getUserAddresssDict;

//存储城市信息
+ (void)saveCity:(NSString *)city;
+ (NSString *)getCity;

//用户纬度
+ (void)saveUserLat:(NSString *)userLat;
+ (NSString *)getUserLat;

//经度
+ (void)saveUserLon:(NSString *)userLon;
+ (NSString *)getUserLon;

//Id
+ (void)saveHomeRemove:(NSString *)remove;
+ (NSString *)getIfRemove;

//保存用户信息
+(void)saveUserDict:(NSDictionary*)dict;
+(NSDictionary*)getUserDict;

//Id
+ (void)saveId:(NSString *)roleId;
+ (NSString *)getId;

//保存用户头像imgurl
+ (void)savePhoto:(NSString *)photoUrl;
+ (NSString *)getPhotoUrl;

//用户首次登陆时，如果没有允许获取位置信息时，第一次刷新首页数据，请求获取位置信息
+ (void)saveIfRefreshLocation:(NSString *)refreshLocation;
+ (NSString *)getRefreshLocation;

//code
+ (void)saveCode:(NSString *)code;
+ (NSString *)getCode;

//是否退出了登录
+ (void)saveIfQuit:(NSString *)type;
+ (NSString *)getIfQuit;

//im_password
+ (void)saveIm_password:(NSString *)im_password;
+ (NSString *)getIm_password;

//用户手机号
+ (void)saveUserMobile:(NSString *)userMobile;
+ (NSString *)getUserMobile;

//用户的Header姓名
+ (void)saveHeaderName:(NSString *)headerName;
+ (NSString *)getHeaderName;

//用户的user昵称
+ (void)saveNickName:(NSString *)nickName;
+ (NSString *)getNickName;

//正真的姓名
+ (void)saveRealName:(NSString *)realName;
+ (NSString *)getRealName;
//userType
+ (void)saveUserType:(NSString *)userType;
+ (NSString *)getUserType;
//第二种角色
+ (void)saveUserSubType:(NSString *)userSubType;
+ (NSString *)getUserSubType;
//用户认证状态
+ (void)saveUserStatus:(NSString *)userStatus;
+ (NSString *)getUserStatus;
//手机的deviceToken
+ (void)saveDeviceToken:(NSString *)deviceToken;
+ (NSString *)getDeviceToken;
//保存退出状态
+ (void)saveLoginStatus:(NSString * )loginStatus;
+ (NSString *)getLoginStatus;

//用户是否第一次登录
+ (void)saveFirstLogin:(NSString * )firstLogin;
+ (NSString *)getFirstLogin;
@end
