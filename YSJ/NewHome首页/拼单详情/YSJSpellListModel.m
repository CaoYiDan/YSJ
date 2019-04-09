//
//  YSJSpellListModel.m
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJSpellListModel.h"

@implementation YSJSpellListModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"startTime":@"end_time"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"member" : @"YSJSpellPersonModel"};//前边，是属性数组的名字，后边就是类名
}
- (instancetype)init {
    if (self = [super init]) {
        
        self.currentTime = [self getTime];
       
    }
    return self;
}

- (void)countDown {
    
    self.startTime--;
    
    if (self.startTime - self.currentTime <= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CZHCountDownFinishNotification object:nil];
        
        return;
    }
}

- (NSInteger)getTime {
    
    NSDate *senddate = [NSDate date];
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
     NSLog(@"%@",date2);
    return [date2 integerValue];
}
@end
