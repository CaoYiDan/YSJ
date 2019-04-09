//
//  SPSelectionCategoryModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/8/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSelectionCategoryModel : NSObject
@property (nonatomic, copy) NSString *beFrom;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *imPasswd;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *haunt;

@property (nonatomic, assign) int infoPercent;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, assign) int id;

@property (nonatomic, assign) int gender;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *zodiac;

@property (nonatomic, copy) NSString *experience;

@property (nonatomic, copy) NSString *job;

@property (nonatomic, strong)NSArray *tags;

@property (nonatomic, strong)NSArray *skills;

@property (nonatomic, strong)NSArray *avatarList;

@property (nonatomic, copy)NSString *distance;//距离

@property (nonatomic, copy)NSString *livenessStatus;//活跃

@property (nonatomic, copy) NSString *age;

@property (nonatomic, assign) BOOL followed;//是否已关注

@property (nonatomic, assign)int likedNum;

@property (nonatomic, assign)int level;
@end
