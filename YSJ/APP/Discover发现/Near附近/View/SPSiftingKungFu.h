//
//  SPSiftingKungFu.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SPKungFuModel;

#import "SPBasePopView.h"

typedef void(^siftingKungFuBlock)(NSMutableArray *chosedArr);

@interface SPSiftingKungFu : SPBasePopView
/***/
@property(nonatomic,copy) siftingKungFuBlock siftingKungFuBlock;
//吊起时，将contentPonit 设置为 00
-(void)setPonitZero;
@end
