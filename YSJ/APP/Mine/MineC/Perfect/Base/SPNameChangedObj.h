//
//  SPNameChangedObj.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPNameChangedProtovol.h"
@interface SPNameChangedObj : NSObject

/**<##><#Name#>*/
@property (nonatomic, strong)NSMutableArray *objArr;

+(instancetype)share;

-(void)addObject:(id<SPNameChangedProtovol>) obj;

-(void)postChangedNowIs:(NSString *)nowName;
@end
