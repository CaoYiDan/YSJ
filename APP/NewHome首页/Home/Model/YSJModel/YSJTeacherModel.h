//
//  YSJTeacherModel.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSJTeacherModel : NSObject

@property (nonatomic, copy) NSString *teacherID;

@property (nonatomic, assign) int is_auth;
@property (nonatomic,strong) NSArray *red_packet;
@property (nonatomic, assign) int dealcount;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *school;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, assign) BOOL is_fan;

@property (nonatomic, copy) NSString *describe;

@property (nonatomic, copy) NSString *sale_item;

@property (nonatomic, copy) NSString *qualifications;


@property (nonatomic, assign) int price;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) BOOL is_at_home;

@property (nonatomic, assign) double reputation;

@property (nonatomic, copy) NSString *teach_time;

@property (nonatomic, copy) NSString *education;

@property (nonatomic,assign) int distance;

@property (nonatomic, assign) int fans;

@property (nonatomic, copy) NSString *lables;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *coursetypes;

@property (nonatomic, copy) NSString *coursetype;

@end
