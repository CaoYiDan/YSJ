//
//  SPPhotosForMakeMoneyVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPPublishModel;
@interface SPPhotosForMakeMoneyVC : UIViewController
/**<##>模型*/
@property (nonatomic, strong)SPPublishModel *model;
/** 从哪里进来
 0 发布界面  1租约广场 点击了去完善；
 根据进入的不同，判断发布完成后该跳转到哪里*/
@property(nonatomic,assign)NSInteger  formWhere;
@end
