//
//  LGAnswerVC.h
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/5/11.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGAnswerVC : UITableViewController
/**<##>评价Id*/
@property(nonatomic,copy) NSString *code;

@property(nonatomic,assign)NSInteger evaluateType;

/**<#Name#>*/
@property(nonatomic,copy)NSString *type;
@end
