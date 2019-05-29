//
//  SPAddNewTagView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/9.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^changeBlock)();
@interface SPChangeView : UIView
/**<#Name#>*/
@property(nonatomic,copy)changeBlock changeBlock;
//开始编辑，弹出键盘
-(void)becomeExid;
@end
