//
//  SPLevelView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"
typedef void(^levelViewBlock) (NSArray *array);
@interface SPLevelView :SPBasePopView
/**<##>bolck回调*/
@property(nonatomic,copy)levelViewBlock levelBlock;
@end
