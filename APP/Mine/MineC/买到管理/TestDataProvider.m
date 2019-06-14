//
//  TestDataProvider.m
//  SmallPig
//
//  Created by xujf on 2019/6/11.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "TestDataProvider.h"
#import "NIMKitInfo.h"
@implementation TestDataProvider

- (NIMKitInfo *)infoByUser:(NSString *)userId
                    option:(NIMKitInfoFetchOption *)option {

   NIMKitInfo *info = [[NIMKitInfo alloc] init];
   NSLog(@"%@  %@",userId,[StorageUtil getCode]);
    
    if ([userId isEqualToString:[StorageUtil getCode]]) {
        
        info.showName = [StorageUtil getNickName];
        
        info.avatarUrlString = [StorageUtil getPhotoUrl];
        
    }else{
        
        NSDictionary *dic = [StorageUtil getUserPhotoAndNameByUserId:userId];
       
        if (isNull(dic)){
            
            NSMutableDictionary *dic = @{}.mutableCopy;
            [dic setObject:userId forKey:@"accid"];
            
            [[HttpRequest sharedClient]httpRequestPOST:Ymessageshowurl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                
                NSLog(@"%@",responseObject);
                
                [StorageUtil savedHaveLearnMethd:[NSString stringWithFormat:@"%@lisen%@",[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,responseObject[@"photo"]],responseObject[@"nickname"]]];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
             
                
            }];

            info.showName = userId;
            info.avatarImage = [UIImage imageNamed:@"Photo1"];
            
        }else{
            
            NSArray *arr = [dic[userId] componentsSeparatedByString:@"lisen"];
            info.showName = arr[1];
            info.avatarUrlString = arr[0];
        }
    }

    return info;

}

-(NSDictionary *)getInfoWithAccounId:(NSString *)accounId{
   
    return nil;
}

@end
