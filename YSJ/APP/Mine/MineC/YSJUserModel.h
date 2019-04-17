//
//  YSJUserModel.h
//  SmallPig
//
//  Created by xujf on 2019/4/16.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJUserModel : NSObject

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) int longitude;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *lables;

@property (nonatomic, assign) int latitude;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, assign) int registtime;

@end

NS_ASSUME_NONNULL_END
