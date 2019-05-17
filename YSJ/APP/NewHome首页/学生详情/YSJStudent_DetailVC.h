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

/**
 0 普通进入 1 查看自己的发布
 */
@property (nonatomic,assign) NSInteger vcType;

/**<##>teacherID*/
@property(nonatomic,copy)NSString *studentID;

/**block*/
@property(nonatomic,copy)profileBlock  block;

@property (nonatomic,strong) YSJRequimentModel *model;
@end
