//
//  SPAuthenticationView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAuthenticationView : UIView
/**类型 0 显示保证金，1 不显示保证金*/
@property(nonatomic,assign)NSInteger type;

-(void)setA0:(BOOL)a0 A1:(BOOL)a1 set2:(BOOL)a2 set3:(BOOL)a3;
@end
