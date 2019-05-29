//
//  HttpRequest.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/26.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "HttpRequest.h"
#import "AFSecurityPolicy.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
static NSString * const  key = @"secret7496";
@implementation HttpRequest

+ (HttpRequest *)sharedClient{
    static HttpRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}

-(AFHTTPSessionManager*)manager{
    static AFHTTPSessionManager *_managera = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _managera = [AFHTTPSessionManager manager];
    });
    return _managera;
}

//取消网络请求
- (void) cancelRequest
{
    [self.manager.operationQueue cancelAllOperations];
}

//GET请求
-(void)httpRequestGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure  {
    
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Accept"];
 self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    // 设置超时时间
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 10.f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
 
    [self.manager GET:  string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(task,responseObject[@"data"],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

//POST请求
- (void)httpRequestPOST:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure {
   
self.manager.requestSerializer= [AFJSONRequestSerializer serializer];
   
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Accept"];
self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 设置超时时间
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval =15.f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [self.manager POST:string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            sucess(task,responseObject[@"data"],responseObject);
//            sucess(task,responseObject,responseObject);
        }else{
            if (!isEmptyString(responseObject[@"message"])) {
                Toast(responseObject[@"message"]);
                NSString *message =responseObject[@"message"];
                //如果是token 过期，则返回所有数据
                if ([message containsString:@"token time"] || [message containsString:@"user not ex"]) {
                    sucess(task,responseObject,responseObject);
                }
            }
             failure(nil,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
//        Toast(@"额，出了点小插曲");
        failure(task,error);
    }];
}

-(NSString*)getData{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSString*datea=[self GetDataWithData:currentDate];
    return [NSString stringWithFormat:@"%@ %@",datea,@"GMT"];
}

-(NSString*)GetDataWithData:(NSDate*)currentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM YYYY HH:mm:ss"];
    //另中文（真机）环境下也能正常转换
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    
    //将获取后的本地时间 转换成东八区时间
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT-0000"];
    
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@",dateString);
    return dateString;
}

-(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    NSData*data = [GTMBase64 encodeData:HMACData];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

//词典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//MD5_base64
- (NSString *) md5_base64:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    base64 = [GTMBase64 encodeData:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    NSLog(@"%@",output);
    return output;
}


// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    if (!dict)
        return @"";
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

//专门为GETCity请求
-(void)httpRequestForCityGET:(NSString *)string parameters:(id)parmeters progress:(ProgressBlock)progress sucess:(SucessBlock)sucess failure:(FailureBlock)failure  {
    
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"application/json"  forHTTPHeaderField:@"Accept"];
    self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    // 设置超时时间
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 5.f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [self.manager GET:  string parameters:parmeters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress!= nil) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(task,responseObject,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
@end
