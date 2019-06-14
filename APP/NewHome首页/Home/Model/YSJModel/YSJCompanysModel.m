//
//  YSJCompanysModel.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJCompanysModel.h"

@implementation YSJCompanysModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    
    return @{@"companyID":@"id",@"site_photo":@"venue_pic",@"teacherArr":@"teachers",@"sale_items":@"sale_item"};
    
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"red_packet":@"YSJGBModel"};
}

@end
