//
//  SPPopAgeChosedView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"

typedef void(^ageBlock)(NSString *ageStr,NSString *ageParameter);

@interface SPPopAgeChosedView : SPBasePopView

/***/
@property(nonatomic,copy) ageBlock block;
//吊起时，将contentPonit 设置为 00
-(void)setPonitZero;

@end
