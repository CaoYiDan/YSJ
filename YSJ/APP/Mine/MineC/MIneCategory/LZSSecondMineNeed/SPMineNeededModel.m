//
//  SPMineNeededModel.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMineNeededModel.h"

@implementation SPMineNeededModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"])
    {
        self.ID = value;
    }
}

@end
