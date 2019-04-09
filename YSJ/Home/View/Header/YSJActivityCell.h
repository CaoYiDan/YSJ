//
//  YSJActivityCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* YSJActivityCellID =@"YSJActivityCellID";

@interface YSJActivityCell : UICollectionViewCell

/**
 首页 ”赛事 商城 ....“ 的赋值
 
 @param img 本地图片
 @param name name
 */
-(void)setDic:(NSDictionary*)dic;
@end
