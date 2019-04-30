//
//  SPPublishVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) ();

typedef void(^publishFinish)();

@interface YSJDetailForCompanyPublishVC :BaseViewController

/**定位城市*/
@property(nonatomic,copy)NSString*locationCity;

/**回调*/
@property(nonatomic,copy) publishFinish publishFinsih;

//block
//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;
@end
