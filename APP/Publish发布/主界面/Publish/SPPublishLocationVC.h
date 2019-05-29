//
//  SPPublishLocationVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseHomePushVC.h"
typedef  void(^publishsLocationBlock)(NSString *location,NSInteger index);
@interface SPPublishLocationVC : SPBaseHomePushVC
/**<##>*/
@property(nonatomic,copy) publishsLocationBlock publishLocationBlock;

//已选择的index(默认为0);
@property(nonatomic,assign)NSInteger selectedIndex;
@end
