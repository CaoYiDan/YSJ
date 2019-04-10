//
//  SPNoDataTipView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/11/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^block) (NSString *btnText);
@interface SPNoDataTipView : UIView
/**<##>block*/
@property(nonatomic,copy)block block;
@end
