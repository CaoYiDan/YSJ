//
//  NSString+getSize.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (getSize)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
