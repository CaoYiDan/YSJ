//
//  SPLeaseModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLeaseModel : NSObject

/**<##><#Name#>*/
@property (nonatomic, copy) NSString *leaseId;

/**<##>身份认证*/
@property (nonatomic, copy) NSString *identityStatus;

@property(nonatomic,copy)NSString *bailFee;

@property(nonatomic,copy)NSString *propertyName;

@property (nonatomic, copy) NSString *code;
/*****是否被当前登录人接单过(0否 1是)*/
@property (nonatomic, assign) BOOL orderFlag;

@property (nonatomic, assign) BOOL flushFlag;

@property (nonatomic, assign) CGFloat contentH;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *birthDay;

@property (nonatomic, assign)int  gender;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *userCode;

@property (nonatomic, copy) NSString *userPic;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userAge;

@property (nonatomic, copy) NSString *constellation;

@property (nonatomic, copy) NSString *activeFlag;

@property (nonatomic, copy) NSString *status;
@end
