//
//  SPLzsMySkillModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLzsMySkillModel : NSObject
@property (nonatomic,copy) NSString * code;
/**<#title#>*/
//@property(nonatomic,assign)int  bailFee;

@property (nonatomic,copy) NSString * lucCode;
@property (nonatomic,copy) NSString * nickName;
@property (nonatomic,copy) NSString * avatar;
@property (nonatomic,copy) NSString * gender;
@property (nonatomic,copy) NSString * skillCode;
@property (nonatomic,copy) NSString * skill;
@property (nonatomic,copy) NSString * skillImg;
@property (nonatomic,strong) NSMutableArray * skillImgList;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * zodiac;
@property (nonatomic,copy) NSString * serPrice;
@property (nonatomic,copy) NSString * serTime;
@property (nonatomic,copy) NSString * serIntro;
@property (nonatomic,copy) NSString * serContent;//服务优势
@property (nonatomic,copy) NSString * serRemark;
@property (nonatomic,copy) NSString * distance;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * readNum;
@property (nonatomic,copy) NSString * commentNum;
@property (nonatomic,copy) NSString * status;//技能状态
@property (nonatomic,copy) NSString * livenessStatus;
@property (nonatomic,copy) NSString * updatedAt;//更新时间
@property (nonatomic,assign) NSInteger skillLevel;//技能等级
@property (nonatomic,copy) NSString * skillCert;//认证状态
@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * bailFee;//保证金
@end
