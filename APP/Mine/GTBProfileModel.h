//
//  GTBProfileModel.h
//  GuideTestBao
//
//  Created by 融合互联-------lisen on 2018/5/21.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTBProfileModel : NSObject

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) int xueshi;
/**<#title#>*/
@property(nonatomic,assign)BOOL  taocan;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign)BOOL YHQ;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *Registration_type;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *student_location;

@property (nonatomic, copy) NSString *industry;

@end
