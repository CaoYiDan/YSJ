//
//  SPSelectionCategoryView.h
//  SmallPig
//
//  Created by 李智帅 on 2017/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSelectionCategoryModel.h"

typedef void(^ProflieHeaderBlock) (NSInteger tag);

@interface SPSelectionCategoryView : UIView

/***/
@property(nonatomic,copy) ProflieHeaderBlock proflieHeaderBLock;
/**<#Name#>*/
@property (nonatomic, strong)SPSelectionCategoryModel *user;
@end
