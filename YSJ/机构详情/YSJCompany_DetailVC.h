//
//  SPProfileDetailVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^profileBlock) (NSDictionary *profileDic);

#import "BaseViewController.h"

@interface YSJCompany_DetailVC : BaseViewController

/**<##>companyID*/
@property(nonatomic,copy)NSString *companyID;

/**block*/
@property(nonatomic,copy)profileBlock  block;

@end
