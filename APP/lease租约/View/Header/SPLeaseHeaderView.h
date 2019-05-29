//
//  SPHomeHeader.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^headerMore)();

@interface SPLeaseHeaderView: UIView

/**<##>block回传*/
@property(nonatomic,copy) headerMore moreBlock;
/**<##>数据数组*/
@property (nonatomic, strong)NSArray *activityArr;
@end

