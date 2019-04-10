//
//  UIViewController+SPViewController.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SPViewController)
//push到另一个ViewCOntroller(适用于没有参数传递)
-(void)pushViewCotnroller:(NSString *)viewConrollerString;
@end
