//
//  SPProfileDetailVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^profileBlock) (NSDictionary *profileDic);
@class YSJRequimentModel;
#import "BaseViewController.h"

@interface YSJStudent_DetailVC : BaseViewController

/**<##>teacherID*/
@property(nonatomic,copy)NSString *studentID;

/**block*/
@property(nonatomic,copy)profileBlock  block;

@property (nonatomic,strong) YSJRequimentModel *model;
@end
