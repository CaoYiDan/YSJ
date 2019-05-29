//
//  SPDepositModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2018/1/11.
//  Copyright © 2018年 李智帅. All rights reserved.
//

#import "SPDepositModel.h"

@implementation SPDepositModel
+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"bailId":@"id"};
}
@end
