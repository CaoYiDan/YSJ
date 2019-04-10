//
//  SPNewHomeNavView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPHomeNavViewDelegate
-(void)homeNavViewSelectedIndex:(NSInteger)index;
@end

@interface SPNewHomeNavView : UIView

/**未读数目*/
@property(nonatomic,assign)NSInteger  uReadCount;

/**代理*/
@property(nonatomic,weak) id<SPHomeNavViewDelegate> delegate;
//设置左边的city
-(void)setLeftItemText:(NSString *)city;

//租约另一种样式
-(void)setTypeForLease;
@end
