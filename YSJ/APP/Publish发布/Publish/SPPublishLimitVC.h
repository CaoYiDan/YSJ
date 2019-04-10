//
//  SPPublishLimitVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseHomePushVC.h"

typedef void(^publishLimitBlock) (NSString *limitStr,NSString *limitText,NSInteger index);
@interface SPPublishLimitVC : SPBaseHomePushVC

/**<##>回传*/
@property(nonatomic,copy)publishLimitBlock publishLimitBLock;

//已选择的index(默认为0);
@property(nonatomic,assign)NSInteger selectedIndex;
@end
