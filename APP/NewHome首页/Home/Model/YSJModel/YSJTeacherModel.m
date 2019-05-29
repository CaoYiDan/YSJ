//
//  YSJTeacherModel.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJTeacherModel.h"

@implementation YSJTeacherModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"teacherID":@"id"};
}

@end
