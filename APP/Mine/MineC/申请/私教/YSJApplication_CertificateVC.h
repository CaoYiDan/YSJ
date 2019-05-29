//
//  YSJApplication_CertificateVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef  void (^addCertifierSucceed) (NSString  *certifierName);
@interface YSJApplication_CertificateVC : BaseViewController
@property (nonatomic,copy) addCertifierSucceed block;
@end

NS_ASSUME_NONNULL_END
