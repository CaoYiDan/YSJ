//
//  YSJOrderModel.h
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJOrderModel : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic,copy) NSString *sub_status;
@property (nonatomic,strong) NSArray *pic_url;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic, assign) int checktype_time;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *sub_order_id;

@property (nonatomic, copy) NSString *coursetypes;

@property (nonatomic,copy) NSString *phone;

@property (nonatomic, assign) CGFloat amount;

@property (nonatomic, assign) CGFloat real_amount;

@property (nonatomic,copy) NSString *name;

@property (nonatomic, assign) int max_user;

@property (nonatomic, copy) NSString *coursetype;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) int price;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *order_status;

@property (nonatomic, assign) int times;

@property (nonatomic, assign) int create_time;

@property (nonatomic, copy) NSString *course_id;

@property (nonatomic, copy) NSString *checktype;

@end

NS_ASSUME_NONNULL_END
