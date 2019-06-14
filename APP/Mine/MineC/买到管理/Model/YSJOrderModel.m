//
//  YSJOrderModel.m
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJOrderModel.h"

@implementation YSJOrderModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"orderId":@"id",};
}

@end
