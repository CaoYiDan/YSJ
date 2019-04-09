//
//  SPLucCommentModel.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLucCommentModel.h"
#import "SPCommentModel.h"
@implementation SPLucCommentModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"commentListVOList":[SPCommentModel class]};
}
@end
