//
//  YSJRequimentModel.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJRequimentModel.h"

@implementation YSJRequimentModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"requimentID":@"id",@"code":@"id"};
}
@end
