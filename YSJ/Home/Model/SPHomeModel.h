//
//  SPHomeModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHomeModel : NSObject

@property (nonatomic, assign) BOOL top;

/**<##><#Name#>*/
@property(nonatomic,copy)NSString*code;

@property (nonatomic, copy) NSString *serTime;

@property (nonatomic, assign) BOOL followed;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *serContent;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *serRemark;

@property (nonatomic, copy) NSString *skillCode;

@property (nonatomic, copy) NSString *skillImg;

@property (nonatomic, copy) NSString *skillCert;

@property (nonatomic, copy) NSString *identityStatus;

@property (nonatomic, assign) int sortNum;

@property (nonatomic, assign) int gender;

@property (nonatomic, assign) int commentNum;

@property (nonatomic, copy) NSString *serIntro;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *zodiac;

@property (nonatomic, copy) NSString *livenessStatus;

@property (nonatomic, copy) NSString *skill;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *serPrice;

@property (nonatomic, assign) int age;

@property (nonatomic, assign) int readNum;

@property (nonatomic, copy) NSString * bailFee;

@property (nonatomic, assign) BOOL praised;

@property(nonatomic,strong)NSArray *skillImgList;
@end
