//
//  LGEvaluateStatus.h
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGEvaluateStatus : NSObject

@property (nonatomic, copy) NSString *evaluateId;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *mainCode;

@property (nonatomic, assign) int score;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, copy) NSString *commentor;

@property (nonatomic, copy) NSString *beCommented;

@property (nonatomic, assign) BOOL praised;

@property (nonatomic, copy) NSString *commentorName;

@property (nonatomic, copy) NSString *commentorAvatar;

@property (nonatomic, copy) NSString *beCommentedName;

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, assign) int praiseNum;

@property (nonatomic, assign) int commentNum;

@property (nonatomic, copy) NSString *commentedTime;

@property (nonatomic, assign) BOOL commentMain;

@end
