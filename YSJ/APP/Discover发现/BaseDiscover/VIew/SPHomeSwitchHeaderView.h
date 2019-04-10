//
//  SPHomeSwitchHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/15.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPHomeSwitchHeaderViewDelegate

-(void)homeSwitchHeaderViewSelectedIndex:(NSInteger)index;

@end
@interface SPHomeSwitchHeaderView : UIView

@property(nonatomic ,strong)UIButton *selectedButton;
/**未读数目*/
@property(nonatomic,assign)NSInteger  uReadCount;

/**代理*/
@property(nonatomic,weak) id<SPHomeSwitchHeaderViewDelegate> delegate;

-(void)setLeftItemText:(NSString *)city;
@end
