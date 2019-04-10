//
//  SPFindPeopleVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"
#import "SPMineNeededModel.h"
@interface SPFindPeopleVC : BaseViewController
@property (nonatomic,strong) UILabel * skillCategoryLab;//技能类别
@property (nonatomic,strong) UILabel * flashDatingLab;//闪约
@property (nonatomic,strong) UILabel * needLab;//技能类别
@property (nonatomic,strong) UISwitch * flashSwich;//技能类别
/**<##>code*/
@property(nonatomic,copy)NSString*code;
/**<##>技能*/
@property(nonatomic,copy)NSString*skill;

/**是不是再发一单*/
@property(nonatomic,assign)BOOL  publishAgain;
/**<##>如果是再发一单，则需要将上次的信息赋值*/
@property (nonatomic, strong)SPMineNeededModel *needModel;
@end

