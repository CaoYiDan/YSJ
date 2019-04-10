//
//  SPLevelModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLevelModel : NSObject

//@property (nonatomic, assign) int id;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *wAvatar;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) int level;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *mAvatar;

@property (nonatomic, copy) NSString *upgradeCondition;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *name;
@end
