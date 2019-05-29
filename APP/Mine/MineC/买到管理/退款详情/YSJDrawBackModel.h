//
//  YSJDrawBackModel.h
//  SmallPig
//
//  Created by xujf on 2019/5/16.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJDrawBackModel : NSObject

@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *teacher_phone;
@property (nonatomic,copy) NSString *cause;
@property (nonatomic,copy) NSString *drop_status;
@property (nonatomic,copy) NSString *course_id;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,assign) NSInteger time;
@property (nonatomic,assign) NSInteger left_time;
@end

NS_ASSUME_NONNULL_END
