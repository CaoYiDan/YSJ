//
//  SPUser.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPUser.h"
#import "SPKungFuModel.h"
#import "SPLucCommentModel.h"
#import "SPVisterModel.h"

@implementation SPUser
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"tags" : [SPKungFuModel class],
             @"skills" : [SPKungFuModel class],
             @"userLucCommentDtoList":[SPLucCommentModel class],@"userVisitRecordList":[SPVisterModel class]
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"levelStr":@"level"};
}
@end
