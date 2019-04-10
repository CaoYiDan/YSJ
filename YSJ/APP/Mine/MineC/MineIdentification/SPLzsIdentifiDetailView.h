//
//  SPLzsIdentifiDetailView.h
//  SmallPig
//
//  Created by 李智帅 on 2017/12/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBasePopView.h"
typedef  void(^sortBlock) (NSString *field);
@interface SPLzsIdentifiDetailView : SPBasePopView
/**block*/
@property(nonatomic,copy)sortBlock block;

/**选中的index*/
@property(nonatomic,assign)NSInteger  index;

-(void)reloadTableView;
@end
