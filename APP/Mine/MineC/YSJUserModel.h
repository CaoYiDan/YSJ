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

@property (nonatomic,strong) NSMutableArray *company_teacher;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) int longitude;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *lables;

@property (nonatomic, assign) int latitude;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *birth;

@property (nonatomic, copy) NSString *job;

@property (nonatomic,copy) NSString *describe;

@property (nonatomic,copy) NSString *skills;

@property (nonatomic,copy) NSString *company_school;
/**
 常住地
 */
@property (nonatomic, copy) NSString *permanent;

@property (nonatomic, assign) int registtime;

@property (nonatomic,strong) NSMutableArray *classArr;

@property (nonatomic, copy) NSString *feature;

@property (nonatomic, copy) NSString *sale_item;

@property (nonatomic, copy) NSString *num_teacher;

@property (nonatomic, copy) NSString *otherphone;

@property (nonatomic, copy) NSString *venue_pic;

@property (nonatomic, assign) BOOL is_auth;

@property (nonatomic, copy) NSString *auth_level;

@property (nonatomic, assign) int reputation;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int priority;

@property (nonatomic, copy) NSString *datetime;

@property (nonatomic, assign) int dealcount;


@property (nonatomic, assign) int fans;

@property (nonatomic, assign) int price;

@end

NS_ASSUME_NONNULL_END
