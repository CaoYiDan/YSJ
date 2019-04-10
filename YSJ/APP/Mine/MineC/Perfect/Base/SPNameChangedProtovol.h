//
//  SPNameChangedProtovol.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>
//我只是适用一下观察者模式
@protocol SPNameChangedProtovol <NSObject>
-(void)myNameChangedNowIs:(NSString *)nowName;
@end
