//
//  YSJCourseTypeModel.h
//  SmallPig
//
//  Created by xujf on 2019/4/18.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJCourseTypeModel : NSObject
@property (nonatomic,copy) NSString *value;
@property (nonatomic,assign)BOOL chosed;
@property (nonatomic,strong)  NSMutableArray*subProperties;
@end

NS_ASSUME_NONNULL_END
