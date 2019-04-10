//
//  UIViewController+SPViewController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "UIViewController+SPViewController.h"

@implementation UIViewController (SPViewController)
-(void)pushViewCotnroller:(NSString *)viewConrollerString{
    UIViewController*controller=[[NSClassFromString(viewConrollerString) alloc]init];
    controller.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
