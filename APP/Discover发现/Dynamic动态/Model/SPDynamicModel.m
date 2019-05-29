//
//  SPHomeModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicModel.h"

@implementation SPDynamicModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"imgs":@"content.imgs",@"text":@"content.content",@"dynamicId":@"id"};
}

@end
