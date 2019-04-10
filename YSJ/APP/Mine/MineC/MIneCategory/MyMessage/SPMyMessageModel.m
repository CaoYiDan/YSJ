//
//  SPMyMessageModel.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyMessageModel.h"

@implementation SPMyMessageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        
        self.Id = value;
    }
}



@end
