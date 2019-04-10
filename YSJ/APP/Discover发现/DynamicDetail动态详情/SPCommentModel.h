//
//  SPCommentModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/2.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCommentModel : NSObject

@property (nonatomic, assign) int id;

@property (nonatomic, copy) NSString *beCommentedCode;

@property (nonatomic, copy) NSString *commentorAvatar;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *commentorCode;

@property (nonatomic, copy) NSString *beCommentedUserName;

@property (nonatomic, copy) NSString *commentorName;

@property (nonatomic, copy) NSString *beCommentedUserCode;

@property (nonatomic, copy) NSString *feedCode;

@property (nonatomic, copy) NSString *content;

/**<#title#>*/
@property(nonatomic,assign)NSInteger  commentScore;
/**<#title#>*/
@property(nonatomic,assign)NSInteger  attitudeScore;
@end
