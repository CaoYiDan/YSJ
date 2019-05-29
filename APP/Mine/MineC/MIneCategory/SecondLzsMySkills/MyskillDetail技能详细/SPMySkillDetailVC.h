//
//  SPMySkillDetailVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPLzsMySkillModel;
@interface SPMySkillDetailVC : UIViewController
/**<##>code*/
@property(nonatomic,copy)NSString*code;

/**模型*/
@property (nonatomic, strong)SPLzsMySkillModel *model;
@end
