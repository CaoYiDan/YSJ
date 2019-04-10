//
//  SPProfileDynamicVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SPProfileDynamicVC : UIViewController
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*code;

/**是否有底部控件*/
@property(nonatomic,assign)BOOL dontNeedBottom;

@end
