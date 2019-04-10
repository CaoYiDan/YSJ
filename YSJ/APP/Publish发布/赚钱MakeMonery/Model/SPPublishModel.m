//
//  SPPublishModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishModel.h"
#import "SPSkillWorkExp.h"
@implementation SPPublishModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"skillWorkExp": [SPSkillWorkExp class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"lucID":@"id"};
}
@end
