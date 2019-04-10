//
//  SPHomeDataManager.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//


//{
//    id : 126,
//    promulgatorName : D said,
//    praised : 1,
//    commentNum : 0,
//    praiseNum : 1,
//    promulgator : 1769090182153047665,
//    time : 26分钟前,
//    code : 1813415629482058273,
//    locationValue : ,
//    promulgatorAvatar : http://img.bitscn.com/upimg/allimg/c160120/1453262W253120-12J05.jpg,
//    distance : <100m,
//    readNum : 0,
//    content : {
//        at : ,
//        content : 发呆发呆,
//        imgs : [
//                http://192.168.1.227:8080//upload/rtwm/2017090614/447b13eb-4810-437b-bd90-ac4e71b9c66e.jpg
//                ],
//        subject :
//    }




#import "SPDynamicDataManager.h"
#import "SPDynamicFrame.h"
#import "SPDynamicModel.h"
#import "SPCommon.h"

@implementation SPDynamicDataManager

+(void)getMoreHomeDateWithPage:(NSInteger)page refreshDate:(NSString *)refreshDate success:(void (^)(NSArray *, BOOL, NSString *))success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    // 当前用户code（未登录时传0）
    [dict setObject:isEmptyString([StorageUtil getCode])?@"0":[StorageUtil getCode] forKey:@"timeLineOwner"];
    
    //刷新时间
    if (isEmptyString(refreshDate)) {
        return;
    }
    [dict setObject:refreshDate forKey:@"searchTime"];
    
    //城市
    if (isEmptyString([StorageUtil getCity])) {
        [dict setObject:@"" forKey:@"city"];
    }else{
        [dict setObject:[StorageUtil getCity] forKey:@"city"];
    }
    
    [dict setObject:@(page) forKey:@"pageNum"];
    [dict setObject:@"6" forKey:@"pageSize"];
    [dict setObject:@(5) forKey:@"scopeEnd"];
    [dict setObject:@"0" forKey:@"scopeStart"];
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSLog(@"%@",responseObject);
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [dataArr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                SPDynamicFrame *lastModelF = [dataArr lastObject];
                
                success(dataArr,YES,lastModelF.status.score);
                
            });
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+(void)refreshHomeDatesuccess:(void (^)(NSArray *, BOOL,NSString*))success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    // 当前用户code（未登录时传0）
    //
    //    [dict setObject:isEmptyString([StorageUtil getCode])?@"0":[StorageUtil getCode] forKey:@"timeLineOwner"];
    
    
    [dict setObject:[StorageUtil getCode] forKey:@"timeLineOwner"];
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *DateTime = [formatter stringFromDate:date];
    
    // 时间（传空的时候返回最新的）
    [dict setObject:DateTime forKey:@"searchTime"];
    [dict setObject:@(1) forKey:@"pageNum"];
    [dict setObject:@"6" forKey:@"pageSize"];
    [dict setObject:@(5) forKey:@"scopeEnd"];
    [dict setObject:@"0" forKey:@"scopeStart"];
    if (isEmptyString([StorageUtil getCity])) {
        [dict setObject:@"" forKey:@"city"];
    }else{
        [dict setObject:[StorageUtil getCity] forKey:@"city"];
    }
    
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    
    NSLog(@"%@",dict);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录刷新的时间*/
                success(arr,YES,DateTime);
                
            });
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


@end

