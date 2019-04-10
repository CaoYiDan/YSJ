//
//  SPPublishModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPSkillWorkExp;
@interface SPPublishModel : NSObject

@property (nonatomic, copy) NSString *bailFee;

//@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *serPrice;

@property (nonatomic, copy) NSString *skillImg;

@property (nonatomic, copy) NSString *skill;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *skills;

@property (nonatomic, assign) BOOL top;

@property (nonatomic, assign) int commentNum;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *skillCode;
//技能等级
@property (nonatomic, copy) NSString *skillLevel;
//保证金规则ID
@property (nonatomic, copy) NSString *bailRuleId;
/**<##>图片数组*/
@property (nonatomic, strong)  NSMutableArray *skillImgList;

@property (nonatomic, assign) int sortNum;
//    TIME("TIME","次"),
//    //天
//    DAY("DAY","天"),
//    //小时
//    HOUR("HOUR","小时");
@property (nonatomic, copy) NSString *priceUnit;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *lucID;
@property (nonatomic, copy) NSString *lucCode;
@property (nonatomic, copy) NSString *serIntro;
@property (nonatomic, copy) NSString *serTime;
@property (nonatomic, copy) NSString *serContent;
@property (nonatomic, copy) NSString *serRemark;
@property (nonatomic, copy) NSString *createdAt;
//

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) int readNum;

@property (nonatomic, copy) NSString *identityStatus;

@property (nonatomic, copy) NSString *skillCert;
/**<##>工作经历*/
@property (nonatomic, strong)NSMutableArray*skillWorkExp;
@end
