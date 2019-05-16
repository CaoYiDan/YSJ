//
//  SPLocationSearchVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseHomePushVC.h"

typedef void(^searchBlock) (NSString *resultStr);


@interface SPLocationSearchVC : SPBaseHomePushVC
/**<##>回传*/
@property(nonatomic,copy)searchBlock searchBlock;
@end
