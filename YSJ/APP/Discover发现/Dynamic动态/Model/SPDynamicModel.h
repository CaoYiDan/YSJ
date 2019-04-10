//
//  SPHomeModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDynamicModel : NSObject
@property (nonatomic, copy) NSString * dynamicId;

@property (nonatomic, copy) NSString *promulgatorName;//昵称

@property (nonatomic, assign) BOOL praised;

@property (nonatomic, assign) int commentNum;

@property (nonatomic, assign) int praiseNum;

@property (nonatomic, assign) int readNum;

@property (nonatomic, assign) int gender;

@property (nonatomic, assign) int age;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *promulgator;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *locationValue;//发布地点

@property (nonatomic, copy) NSString *promulgatorAvatar;//头像

@property (nonatomic, strong) NSDictionary *content;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, copy) NSString *text;
@end
