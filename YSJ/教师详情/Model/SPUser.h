//
//  SPProfileModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUser : NSObject
/***/
@property(nonatomic,assign)NSInteger followed;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *beFrom;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *identityStatus;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) int totalVisitNum;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *haunt;

@property (nonatomic, copy) NSString *levelName;

@property (nonatomic, assign) int praiseNum;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *job;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, assign) int id;

@property (nonatomic, assign) int gender;

@property (nonatomic, assign) int level;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *distance;
/**<##><#Name#>*/
@property (nonatomic, strong)NSMutableArray *skills;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *zodiac;

@property (nonatomic, copy) NSString *livenessStatus;

@property (nonatomic, assign) int age;

@property (nonatomic, copy) NSString *experience;

@property (nonatomic, assign) BOOL firstLogin;

@property (nonatomic, assign) BOOL praised;

/**图片数组*/
@property (nonatomic, strong)NSMutableArray *tags;

/**标签*/
@property (nonatomic, strong)NSMutableArray *avatarList;

/**技能评论列表签*/
@property (nonatomic, strong)NSMutableArray *userLucCommentDtoList;

/**访客数组*/
@property (nonatomic, strong)NSMutableArray *userVisitRecordList;

@end

