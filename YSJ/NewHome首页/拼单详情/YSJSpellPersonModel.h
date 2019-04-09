//
//  YSJSpellPersonModel.h
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSJSpellPersonModel : NSObject
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) int amount;

@property (nonatomic, copy) NSString *course_status;

@property (nonatomic, copy) NSString *multicourse_id;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *user_phone;

@property (nonatomic, assign) int price;

//剩余拼单人数
@property (nonatomic, assign) int leftCount;

@property (nonatomic, assign) BOOL is_creater;

@property (nonatomic, copy) NSString *course_time;

@property (nonatomic, assign) int times;

@property (nonatomic, assign) int create_time;

@property (nonatomic, copy) NSString *course_id;

@property (nonatomic, copy) NSString *evaluation_id;

@property (nonatomic, copy) NSString *teacher_phone;
@end
