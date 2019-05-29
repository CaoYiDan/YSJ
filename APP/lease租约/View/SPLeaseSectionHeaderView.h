//
//  SPLeaseSectionHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPLeaseSectionHeaderViewDelegate <NSObject>

/**
 头部代理

 @param btnString 点击的按钮的text 返回过去处理
 */
-(void)SPLeaseSectionHeaderViewSelectedString:(NSString *)btnString;
@end

@interface SPLeaseSectionHeaderView : UIView
/**代理*/
@property(nonatomic,assign) id <SPLeaseSectionHeaderViewDelegate>  delegate;
-(void)setSelected:(NSString *)type;
@end
