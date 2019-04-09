//
//  SPHomeDataManager.m
//  SmallPi

#import "SPHomeDataManager.h"
#import "SPNewHomeCellFrame.h"
#import "SPHomeModel.h"
#import "SPCommon.h"

@implementation SPHomeDataManager

+ (void)getMoreHomeDateWithPage:(NSInteger)page andDic:(NSMutableDictionary *)dic refreshDate:(NSString *)refreshDate success:(void(^)(NSArray *items, BOOL lastPage, NSString *refreshDate))success failure:(void(^)(NSError *NSError))failure{

    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:@(page) forKey:@"pageNum"];
    [dict setObject:@"6" forKey:@"pageSize"];
    
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    if (!isEmptyString(dic[@"searchType"])) {
        [dict setObject:dic[@"searchType"] forKey:@"searchType"];
    }
    
    if (!isEmptyString(dic[@"gender"])) {
        [dict setObject:dic[@"gender"] forKey:@"gender"];
    }
    
    NSLog(@"%@",dic);
//    年龄范围：LESS：0-25，BETWEEN：25-35，ABOVE：30以上
    if (!isEmptyString(dic[@"age"])) {
    
        if ([dic[@"age"] isEqualToString:@"25以下"]) {
            [dict setObject:@"LESS" forKey:@"ageRange"];
        }else if ([dic[@"age"] isEqualToString:@"25~35"]){
            [dict setObject:@"LEBETWEENSS" forKey:@"ageRange"];
        }else if ([dic[@"age"] isEqualToString:@"35以上"]){
            [dict setObject:@"ABOVE" forKey:@"ageRange"];
        }
    }
    //查询的类型
    if (!isEmptyString(dic[@"searchType"])) {
        [dict setObject:dic[@"searchType"] forKey:@"searchType"];
    }else{
        [dict setObject:@"TIME" forKey:@"searchType"];
    }
    //技能code
    if (!isEmptyString(dic[@"skillCode"])) {
        [dict setObject:dic[@"skillCode"] forKey:@"skillCode"];
    }
    
    NSLog(@"%@",dict);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            NSMutableArray *dataArr = @[].mutableCopy;
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPNewHomeCellFrame *frame = [[SPNewHomeCellFrame alloc]init];
                frame.status = [SPHomeModel mj_objectWithKeyValues:dict];
                [dataArr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                SPNewHomeCellFrame *lastModelF = [dataArr lastObject];
                
                success(dataArr,YES,@"");
                
            });
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void)refreshHomeDateWithDic:(NSMutableDictionary *)dic success:(void(^)(NSArray *items, BOOL lastPage,NSString *currentData))success failure:(void(^)(NSError *NSError))failure{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:@(1) forKey:@"pageNum"];
    [dict setObject:@"6" forKey:@"pageSize"];
    
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    if (!isEmptyString(dic[@"searchType"])) {
        [dict setObject:dic[@"searchType"] forKey:@"searchType"];
    }else{
        [dict setObject:@"DEFAULT" forKey:@"searchType"];
    }
    
    if (!isEmptyString(dic[@"gender"])) {
        [dict setObject:dic[@"gender"] forKey:@"gender"];
    }
    
    if (!isEmptyString(dic[@"skillCode"])) {
        [dict setObject:dic[@"skillCode"] forKey:@"skillCode"];
    }
    
    //年龄范围：LESS：0-25，BETWEEN：25-35，ABOVE：30以上
    if (!isEmptyString(dic[@"age"])) {
        
        if ([dic[@"age"] isEqualToString:@"25以下"]) {
            [dict setObject:@"LESS" forKey:@"ageRange"];
        }else if ([dic[@"age"] isEqualToString:@"25~35"]){
            [dict setObject:@"BETWEEN" forKey:@"ageRange"];
        }else if ([dic[@"age"] isEqualToString:@"35以上"]){
            [dict setObject:@"ABOVE" forKey:@"ageRange"];
        }
    }
    
    if (!isEmptyString(dic[@"city"])) {
        [dict setObject:dic[@"city"] forKey:@"city"];
    }
    NSLog(@"参数%@",dict);

    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                
                [NSObject propertyCodeWithDictionary:dict];
                
                SPNewHomeCellFrame *frame = [[SPNewHomeCellFrame alloc]init];
                frame.status = [SPHomeModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录刷新的时间*/
                success(arr,YES,@"");
                
            });
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

@end
