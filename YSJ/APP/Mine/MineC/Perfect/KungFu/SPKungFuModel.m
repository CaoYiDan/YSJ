//
//  SPKungFuModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPKungFuModel.h"

@implementation SPKungFuModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"subProperties" : [SPKungFuModel class],
             };
}

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"value":@"coursetype_name",@"site_photo":@"venue_pic",@"teacherArr":@"teachers",@"sale_items":@"sale_item"};
}


@end
