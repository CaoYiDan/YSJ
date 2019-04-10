//
//  SPNameChangedObj.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNameChangedObj.h"

@implementation SPNameChangedObj

// 创建静态对象 防止外部访问
static SPNameChangedObj *_instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)share
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(void)addObject:(id<SPNameChangedProtovol>)obj{
    [_instance.objArr addObject:obj];
}

-(void)postChangedNowIs:(NSString *)nowName{
    
    for ( id<SPNameChangedProtovol> obj in _instance.objArr) {
        [obj myNameChangedNowIs:nowName];
    }
}

-(NSMutableArray*)objArr{
    if (!_objArr) {
        _objArr = @[].mutableCopy;
    }
    return _objArr;
}

@end
