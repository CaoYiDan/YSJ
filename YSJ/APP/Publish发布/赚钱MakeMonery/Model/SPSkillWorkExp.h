//
//  SPSkillWorkExp.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSkillWorkExp : NSObject
//"companyName": "大米公司",
//"workCity": "北京",
//"jobTitle": "网络工程师",
//"workBeginTime": "2010-05-12",
//"workEndTime": "",
//"working": true,
//"industry": "大米科技"
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*companyName;
/**<#Name#>*/
@property(nonatomic,copy)NSString*workCity;
/**<#Name#>*/
@property(nonatomic,copy)NSString*jobTitle;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*workBeginTime;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*workEndTime;
/**<##><#Name#>*/
@property(nonatomic,assign)BOOL working;
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*industry;
@end
