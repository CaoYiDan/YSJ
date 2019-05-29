//
//  YSJUserModel.m
//  SmallPig
//
//  Created by xujf on 2019/4/16.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJUserModel.h"

@implementation YSJUserModel
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"classArr":@"classs"};
}
+ (NSDictionary *)mj_objectClassInArray{
     return @{@"classArr":@"YSJRequimentModel"};
}

@end
