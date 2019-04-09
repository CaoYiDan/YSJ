//
//  SPDynamicCategoryCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* SPDynamicCategoryCellID =@"CellID";

@interface SPDynamicCategoryCell : UICollectionViewCell

/**
 首页 ”约私教  约学生  约机构“ 的赋值

 @param img 本地图片
 @param name name
 */
-(void)setImg:(NSString *)img withName:(NSString *)name;

@end
