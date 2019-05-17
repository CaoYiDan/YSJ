//
//  YSJRequimentModel.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSJRequimentModel : NSObject

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, assign) double distance;

@property (nonatomic, copy) NSString *requimentID;

@property (nonatomic, assign) int price;

@property (nonatomic, copy) NSString *describe;

@property (nonatomic, assign) int times;

@property (nonatomic, copy) NSString *lables;

@property (nonatomic, copy) NSString *userlables;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *coursename;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic,strong) NSMutableArray *sale_item;

@property (nonatomic, copy) NSString *coursetypes;

@property (nonatomic, copy) NSString *coursetype;

@property (nonatomic,assign) NSInteger is_at_home;

@property (nonatomic,copy) NSString *course_status;

@property (nonatomic,copy) NSString *course_kind;

@property (nonatomic,copy) NSString *phone;

@property (nonatomic,copy) NSString *string;

@property (nonatomic,copy) NSString *course_time;

@property (nonatomic,copy) NSString *code;

@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *lowprice;

@property (nonatomic,copy) NSString *highprice;
@end
