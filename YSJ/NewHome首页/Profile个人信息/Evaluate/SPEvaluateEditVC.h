//
//  SPEvaluateEditVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^evaluateEditVCBlock)();
@interface SPEvaluateEditVC : BaseViewController
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*mainCode;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*type;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*beCommentedCode;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*beCommented;
/***/
@property(nonatomic,copy)evaluateEditVCBlock evaluateEditVCBlock;
@end
