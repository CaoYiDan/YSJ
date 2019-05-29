//
//  YSJPopProtocol.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YSJPopProtocol <NSObject>

-(void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

-(UIView *)getView;


@end

NS_ASSUME_NONNULL_END
