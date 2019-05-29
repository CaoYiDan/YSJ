//
//  YSJHomeWorkTypeListCell.h
//  SmallPig

//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJHomeWorkTypeListCell : UITableViewCell
-(void)setDic:(NSDictionary *)dic;
@property (nonatomic,copy) NSString *subText;
@end

NS_ASSUME_NONNULL_END
