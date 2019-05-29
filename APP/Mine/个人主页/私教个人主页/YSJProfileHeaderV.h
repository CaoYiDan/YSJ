//
//  YSJProfileHeaderV.h
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YSJUserModel;

@interface YSJProfileHeaderV : UIView

@property (nonatomic,strong) YSJUserModel *model;

@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,strong) YSJUserModel *companyModel;
@end

NS_ASSUME_NONNULL_END
