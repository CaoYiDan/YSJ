//
//  YSJCompanysModel.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSJCompanysModel : NSObject

@property (nonatomic, assign) int dealcount;

@property (nonatomic, assign) int distance;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *auth_level;
@property (nonatomic, copy) NSString *lables;
@property (nonatomic,strong) NSMutableArray *teacherArr;
@property (nonatomic, copy) NSString *companyID;

@property (nonatomic, copy) NSString *site_photo;

@property (nonatomic, copy) NSString *venue_pic;

@property (nonatomic, assign) int price;

@property (nonatomic, assign) int fans;

@property (nonatomic, assign) CGFloat reputation;

@property (nonatomic, copy) NSString *name;

@property (nonatomic,strong) NSMutableArray *                sale_item;  //能够教授的课程类别
;

@property (nonatomic, copy) NSString *sale_items;

@property (nonatomic,assign) BOOL is_auth;
@property (nonatomic,assign) BOOL is_fan;
@property (nonatomic,copy) NSString *num_teacher;
@property (nonatomic,copy) NSString *_id;
@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *datetime;

@property (nonatomic, copy) NSString *coursetypes;

@property (nonatomic, copy) NSString *coursetype;


@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *feature;

@property (nonatomic,copy) NSString *describe;

@property (nonatomic,copy) NSString *otherphone;

@property (nonatomic,copy) NSString *priority;

//@property (nonatomic,copy) NSString *<#string#>;
@end
