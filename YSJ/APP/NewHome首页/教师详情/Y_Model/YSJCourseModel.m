//
//  YSJCourseModel.m
//  SmallPig
//
//  Created by xujf on 2019/4/1.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJCourseModel.h"

@implementation YSJCourseModel
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"code":@"id",@"pic_url2":@"pic_url",@"teacherArr":@"teachers",@"labels":@"lables"};
}
@end
