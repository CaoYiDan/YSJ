//
//  SP.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2018/1/15.
//  Copyright © 2018年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SP : NSObject
/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic, copy) NSString *appid;
/** 预支付订单 */
@property (nonatomic, copy) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, copy)NSString *timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, copy) NSString *sign;
@end
