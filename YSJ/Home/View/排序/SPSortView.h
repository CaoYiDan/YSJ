//
//  SPSortView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"
typedef  void(^sortBlock) (NSString *field);
@interface SPSortView : SPBasePopView

/**block*/
@property(nonatomic,copy)sortBlock block;

/**选中的index*/
@property(nonatomic,assign)NSInteger  index;

-(void)reloadTableView;

@end
