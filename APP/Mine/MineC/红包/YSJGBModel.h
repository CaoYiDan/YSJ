//
//  YSJGBModel.h
//  SmallPig
//
//  Created by xujf on 2019/6/11.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJGBModel : NSObject

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *starttime;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *endtime;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *gate;

@property (nonatomic, copy) NSString *couse_id;

@property (nonatomic, copy) NSString *ctreater;

@property (nonatomic, copy) NSString *redpacket_id;

@property (nonatomic, assign) int is_used;

@property (nonatomic, copy) NSString *seller;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
