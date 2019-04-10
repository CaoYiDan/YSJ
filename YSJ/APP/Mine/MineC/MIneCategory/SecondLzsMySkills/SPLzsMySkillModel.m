//
//  SPLzsMySkillModel.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsMySkillModel.h"

@implementation SPLzsMySkillModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
