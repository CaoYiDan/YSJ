//
//  SPMineNeededDetailVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"
#import "SPMineNeededDetailModel.h"
#import "SPMineNeededModel.h"
typedef void(^deleteBlock) (NSInteger indexRow);
@interface SPMineNeededDetailVC : BaseViewController
@property (nonatomic,strong) SPMineNeededModel * neededModel;
/**<##>block*/
@property(nonatomic,copy)deleteBlock block;
@end
