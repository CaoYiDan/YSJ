//
//  YSJAFNPostImgManager.m
//  SmallPig
//
//  Created by xujf on 2019/6/1.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJAFNPostImgManager.h"

@implementation YSJAFNPostImgManager

-(AFHTTPSessionManager *)getManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         
     @"application/json",
     
     @"text/html",
     
     @"image/jpeg",
     
     @"image/png",
     
     @"application/octet-stream",
     
     @"text/json",
     
     nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
     manager.requestSerializer.timeoutInterval = 30;
    return manager;
}

@end
