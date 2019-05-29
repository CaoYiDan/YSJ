//
//  YSJPlatformRulesWebVC.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSJPlatformRulesWebVC : BaseViewController
/**<##>code*/
@property(nonatomic,copy)NSString*code;
/**<##>url*/
@property(nonatomic,copy)NSString*url;
/**<##>标题*/
@property(nonatomic,copy)NSString*titleName;

@property (nonatomic,copy) NSString *rule1;

@property (nonatomic,copy) NSString *rule2;

@end

NS_ASSUME_NONNULL_END
