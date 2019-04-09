//
//  SPSkillListModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSkillListModel.h"
#import "SPUser.h"
@implementation SPSkillListModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"userList" : [SPUser class],
             };
}
@end
