//
//  YSJHuoDongModel.h
//  SmallPig
//
//  Created by xujf on 2019/6/12.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJHuoDongModel : NSObject
@property (nonatomic,copy) NSString *activity_place;
@property (nonatomic,copy) NSString *activity_pic;
@property (nonatomic,copy) NSString *activity_url;
@property (nonatomic,copy) NSString *activity_title;
@property (nonatomic,copy) NSString *activity_intorduction;
@property (nonatomic,copy) NSString *string;
@property (nonatomic,copy) NSString *is_top;
@property (nonatomic,copy) NSString *activity_time;


@property (nonatomic,copy) NSString *match_pic;
@property (nonatomic,copy) NSString *match_url;
@property (nonatomic,copy) NSString *match_place;
@property (nonatomic,copy) NSString *match_title;
@property (nonatomic,copy) NSString *match_time;
@property (nonatomic,copy) NSString *match_intorduction;

@end

NS_ASSUME_NONNULL_END
