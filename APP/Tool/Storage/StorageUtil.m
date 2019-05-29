//
//  StorageUtil.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/30.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "StorageUtil.h"

@implementation StorageUtil

//获取用户地理信息
+(void)saveUserAddressDict:(NSDictionary*)dict{
[self saveObject:dict forKey:kStorageUserAddressDict];
}
+(NSDictionary*)getUserAddresssDict{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *obj = [defaults objectForKey:kStorageUserAddressDict];
    return   obj;
}
//存储城市信息
+ (void)saveCity:(NSString *)city{
[self saveObject:city forKey:kStorageCity];
}

+ (NSString *)getCity{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *obj = [defaults objectForKey:kStorageCity];
    
    if (!obj) return @"";
    
    return obj;
}

//用户纬度
+ (void)saveUserLat:(NSString *)userLat{
[self saveObject:userLat forKey:kStorageLat];
}
+ (NSString *)getUserLat{
return [self getObjectByKey:kStorageLat];
}

//用户头像
+ (void)savePhoto:(NSString *)photoUrl{
    [self saveObject:photoUrl forKey:kPhoto];
}

+ (NSString *)getPhotoUrl{
    
    return [self getObjectByKey:kPhoto];
}

//经度
+ (void)saveUserLon:(NSString *)userLon{
[self saveObject:userLon forKey:KStorageLon];
}
+ (NSString *)getUserLon{
return [self getObjectByKey:KStorageLon];
}


+(void)saveUserDict:(NSDictionary *)dict{
 [self saveObject:dict forKey:kStorageUserDict];
}
+(NSDictionary*)getUserDict{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *obj = [defaults objectForKey:kStorageUserDict];
    return   obj;
}
//用户首次登陆时，如果没有允许获取位置信息时，第一次刷新首页数据，请求获取位置信息
+ (void)saveIfRefreshLocation:(NSString *)refreshLocation{
    [self saveObject:refreshLocation forKey:kStorageLocation];
}
+ (NSString *)getRefreshLocation{
       return [self getObjectByKey:kStorageLocation];
}

//用户ID
+ (void)saveId:(NSString *)roleId
{
    [self saveObject:roleId forKey:kStorageUserId];
}
+ (NSString *)getId
{
    //return @"3";
    return [self getObjectByKey:kStorageUserId];
}

//code
+ (void)saveCode:(NSString *)code{
    [self saveObject:code forKey:KStorageUserCode];
}

+ (NSString *)getCode{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *obj = [defaults objectForKey:KStorageUserCode];
    
    if (!obj) return @"";
    
    return obj;

}

//是否退出了登录
+ (void)saveIfQuit:(NSString *)type{
    
   [self saveObject:type forKey:KStorageIfQuit];
    
}

+ (NSString *)getIfQuit{
    
  return [self getObjectByKey:KStorageIfQuit];

}


//Id
+ (void)saveHomeRemove:(NSString *)remove{
    [self saveObject:remove forKey:KStorageIfRemove];
}

+ (NSString *)getIfRemove{
  return [self getObjectByKey:KStorageIfRemove];
}

//im_password
+ (void)saveIm_password:(NSString *)im_password{
 [self saveObject:im_password forKey:KStorageIm_password];
}

+ (NSString *)getIm_password{
 return [self getObjectByKey:KStorageIm_password];

}


//用户手机号码
+ (void)saveUserMobile:(NSString *)userMobile
{
    [self saveObject:userMobile forKey:kStorageUserMobile];
}
+ (NSString *)getUserMobile
{
    return [self getObjectByKey:kStorageUserMobile];
}

//userType
+ (void)saveUserType:(NSString *)userType
{
    [self saveObject:userType forKey:kStorageUserType];
}
+ (NSString *)getUser
{
    return [self getObjectByKey:kStorageUserType];
}
//userSubType
+ (void)saveUserSubType:(NSString *)userSubType
{
    [self saveObject:userSubType forKey:kStorageUserSubType];
}
+ (NSString *)getUserSubType
{
    return [self getObjectByKey:kStorageUserSubType];
}
//用户的header姓名
+ (void)saveHeaderName:(NSString *)headerName{
    [self saveObject:headerName forKey:kStorageHeaderName];
}
+ (NSString *)getHeaderName{
    return [self getObjectByKey:kStorageHeaderName];
}

//用户的user昵称
+ (void)saveNickName:(NSString *)nickName{
  [self saveObject:nickName forKey:kStorageUserName];
}
+ (NSString *)getNickName{
  return [self getObjectByKey:kStorageUserName];
}


//用户手机号
+ (void)saveTel:(NSString *)tel{
     [self saveObject:tel forKey:kTel];
}
+ (NSString *)getTel{
    return [self getObjectByKey:kTel];
}

//用户身份
+ (void)saveRole:(NSString *)role{
    [self saveObject:role forKey:kRole];
}
+ (NSString *)getRole{
    return [self getObjectByKey:kRole];
}

//realName
+ (void)saveRealName:(NSString *)realName
{
    [self saveObject:realName forKey:kStorageUserRealName];
}
+ (NSString *)getRealName
{
    return [self getObjectByKey:kStorageUserRealName];
}

+ (void)saveUserStatus:(NSString *)userStatus
{
    [self saveObject:userStatus forKey:kStorageUserStatus];
}
+ (NSString *)getUserStatus
{
    return [self getObjectByKey:kStorageUserStatus];
}


//手机的deviceToken
+ (void)saveDeviceToken:(NSString *)deviceToken{
      [self saveObject:deviceToken forKey:kStorageDeviceToken];
}
+ (NSString *)getDeviceToken{
    return [self getObjectByKey:kStorageDeviceToken];
}


//公用的保存和获取本地数据的方法
+ (void)saveObject:(NSObject *)obj forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];//把数据持久化到standardUserDefaults数据库
}
+ (NSString *)getObjectByKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *obj = [defaults objectForKey:key];
    
    if (!obj) return @"";
    
    return obj;
}

//用户是否第一次登录
+(void)saveFirstLogin:(NSString *)firstLogin{
    
    [self saveObject:firstLogin forKey:kStorageFirstLogin];
}

+ (NSString *)getFirstLogin{
    
    return [self getObjectByKey:kStorageFirstLogin];
}

@end
