//
//  SPMineNeededModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPMineNeededModel : NSObject

@property (nonatomic,copy)NSString * skillImg;//技能图片
@property (nonatomic,copy)NSString * ID;//需求id
@property (nonatomic,copy)NSString * skill;
@property (nonatomic,copy)NSString * skillCode;
@property (nonatomic,copy)NSString * createDateStr;
@property (nonatomic,copy)NSString * content;//需求描述
@property (nonatomic,copy)NSString * dealFlag;//是否成交 是否成交（NODEAL未成交，YDEAL已成交）
@property (nonatomic,strong)NSMutableArray * userList;
@property (nonatomic,copy)NSString * flushFlag;//是否闪约 是否闪约（0是1否
@property (nonatomic,assign)int countUser;//多少接单者
@property (nonatomic,assign)int dealNum;//多少成交者
@property (nonatomic,copy)NSString *overdueFlag;// 该需求是否过期（NODEAL 未过期，YDEAL过期，NAVERNO永不过期）
@property (nonatomic,copy)NSString * bailFee;//诚意金

@end
