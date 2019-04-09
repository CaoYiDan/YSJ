//
//  SPSkillListModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSkillListModel : NSObject
/**<##>*/
@property(nonatomic,copy)NSString*skillCode;
/**<##>*/
@property(nonatomic,copy)NSString*skillValue;
/**<##><#Name#>*/
@property (nonatomic, strong)NSArray *userList;
@end
