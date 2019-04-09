//
//  SPProfileForHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPUser;

@interface SPProfileForHeaderView : UIView

/**<##>header类型 0 查看他人详情  1 查看自己的个人详情*/
@property(nonatomic,assign)NSInteger type;
/**模型*/
@property (nonatomic, strong)SPUser *model;

@end
