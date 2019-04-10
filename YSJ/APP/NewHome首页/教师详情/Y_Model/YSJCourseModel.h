//
//  YSJMulticourseModel.h
//  SmallPig
//
//  Created by xujf on 2019/3/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>
//reputation = 4.8
//coursetypes = 素描
//coursetype = 美术
//labels = 地方好找,老师耐心
//id = 5c9c56c8e6a9214b30e4f914
//title = 素描速成课周末班
//course_time = 每周六晚八点
//pic_url = /static/images/user_display/13426446689/share3.jpg
//surplus = 3
//max_user = 8
//dealcount = 120
//price = 399
//old_price = 699

@interface YSJCourseModel : NSObject

@property (nonatomic,assign)double reputation;
@property (nonatomic,strong) NSMutableArray *teacherArr;
@property (nonatomic,copy) NSString *coursetypes;
@property (nonatomic,copy) NSString *coursetype;
@property (nonatomic,copy) NSString *lables;
@property (nonatomic,copy) NSString *labels;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,strong) NSMutableArray *pic_url2;
@property (nonatomic,copy) NSString *course_time;
@property (nonatomic,copy) NSString *surplus;
@property (nonatomic,assign)NSInteger max_user;
@property (nonatomic,assign)int min_user;
@property (nonatomic,assign)int success;
@property (nonatomic,copy) NSString *dealcount;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *multi_price;
@property (nonatomic,copy) NSString *old_price;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *feaature;
@property (nonatomic,copy) NSString *feaatures;
@property (nonatomic,assign)double distance;
@property (nonatomic,copy) NSString *suitable_range;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *times;
@property (nonatomic,strong) NSMutableArray *course_display;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) BOOL is_fan;
@property (nonatomic,copy) NSString *min_times;
@property (nonatomic,copy) NSString *r_times;
@property (nonatomic,assign) NSInteger fans;
@end
