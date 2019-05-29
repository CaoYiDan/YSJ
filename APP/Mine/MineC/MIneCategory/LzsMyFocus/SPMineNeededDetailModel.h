//
//  SPMineNeededDetailModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPMineNeededDetailModel : NSObject
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*identityStatus;
@property (nonatomic,copy)NSString * myDemandId;//需求详情id
@property (nonatomic,copy)NSString * userCode;//用户code
@property (nonatomic,copy)NSString * createDateStr;//应聘时间
@property (nonatomic,copy)NSString * headImg;//头像
@property (nonatomic,copy)NSString * dealFlag;//是否成交 是否成交（NODEAL未成交，YDEAL已成交）
@property (nonatomic,copy)NSString * userName;//用户昵称
@property (nonatomic,copy)NSString * flushFlag;//是否闪约 是否闪约（0是1否
@property (nonatomic,copy)NSString * userAge;//
@property (nonatomic,copy)NSString * userConstellation;//用户星座
@property (nonatomic,copy)NSString * userPosition;//用户职业
@property (nonatomic,copy)NSString * userLevel;//用户等级
@property (nonatomic,copy)NSString * userPrice;//用户价格
@property (nonatomic,copy)NSString * userPriceUnit;//用户价格时间
@property (nonatomic,copy)NSString * userIntroduce;//服务介绍

@end
