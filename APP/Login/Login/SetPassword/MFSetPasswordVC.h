//
//  GTBSetPassWordVC.h
//  GuideTestBao
//
//  Created by 融合互联-------lisen on 2018/7/20.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFSetPasswordVC : UIViewController

/**<##>手机号*/
@property(nonatomic,copy)NSString *tel;


/**
 是第一次设置密码，还是找回密码
 */
@property (nonatomic,copy) NSString * setOrFind;
@end
